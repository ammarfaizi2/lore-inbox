Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTKYUOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbTKYUOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:14:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8321 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263062AbTKYUOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:14:36 -0500
Date: Tue, 25 Nov 2003 15:17:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
In-Reply-To: <3FC358B5.3000501@softhome.net>
Message-ID: <Pine.LNX.4.53.0311251510310.6584@chaos>
References: <3FC358B5.3000501@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003, Ihar 'Philips' Filipau wrote:

As documented, malloc() will never fail as long as there
is still address space (not memory) available. This is
the required nature of the over-commit strategy. This is
necessary because many programs never even touch all the
memory they allocate.

You can turn OFF over-commit by doing:

echo "2" >proc/sys/vm/overcommit_memory

However, you will probably find that many programs fail
or seg-fault when normally they wouldn't. So, if you don't
mind restarting sendmail occasionally, then turn off over-commit.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


