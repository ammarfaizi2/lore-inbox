Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUEENDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUEENDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 09:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUEENDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 09:03:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:58244 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264658AbUEEM7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:59:22 -0400
Date: Wed, 5 May 2004 09:00:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Lucas Nussbaum <lucas@lucas-nussbaum.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ne2k-pci uncorrectly detecting collisions ?
In-Reply-To: <20040505123532.GA3011@blop.info>
Message-ID: <Pine.LNX.4.53.0405050855290.16355@chaos>
References: <20040505123532.GA3011@blop.info>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 May 2004, Lucas Nussbaum wrote:

> Hello,
>
> I have experienced problem with the ne2k-pci driver. The symptoms were
> extremly poor performance with TCP. After some investigations, I believe
> it might be caused by problems with detecting collisions.
>

But software doesn't detect collisions. It just records what
hardware said it did. It looks like you have a 10 Mb/s card
on a 100 Mb/s network. The collisions reported are how the
hardware throttles the difference in physical-link speed.

It is possible that software didn't initialize a 100 Mb/s
device and instead initialized it to 10 Mb/s, but you
don't have any evidence of that presented.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


