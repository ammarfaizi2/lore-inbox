Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTIHSsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTIHSsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:48:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263478AbTIHSsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:48:20 -0400
Date: Mon, 8 Sep 2003 14:48:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@suse.cz>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some read-errors on floppys not reported on 2.4.22
In-Reply-To: <20030904171758.GR1358@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.53.0309081442580.194@chaos>
References: <Pine.LNX.4.53.0308291207430.25423@chaos> <20030904171758.GR1358@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Pavel Machek wrote:

> Hi!
>
> > Success, even where there are lots of CRC errors that
> > prematurely terminate the read:
>
> Can you find out if it works in 2.4.21?
> --
> 				Pavel

Okay. It works on 2.4.21, the code is identical to 2.4.20 which also
works. On 2.4.22, bad CRC errors which terminate the read, don't
always result in a bad return code. Some just return 0, which
is treated like EOF in user-mode code. Application software
has to add a call to fstat() to see if the bytes read were equal
to the file size as a work-around. This step should not be required.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


