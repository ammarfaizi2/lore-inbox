Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVAABVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVAABVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 20:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVAABVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 20:21:21 -0500
Received: from orcas.net ([66.92.223.130]:11693 "EHLO orcas.net")
	by vger.kernel.org with ESMTP id S262170AbVAABVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 20:21:16 -0500
Date: Fri, 31 Dec 2004 17:21:04 -0800 (PST)
From: Terry Hardie <terryh@orcas.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Asus P4C800-E Deluxe and Intel Pro/1000
In-Reply-To: <41D5C459.8050601@tmr.com>
Message-ID: <Pine.LNX.4.58.0412311715190.3717@orcas.net>
References: <200411112003.43598.Gregor.Jasny@epost.de><6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com>
 <Pine.LNX.4.58.0412262127510.3478@orcas.net> <41D5C459.8050601@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004, Bill Davidsen wrote:

> Terry Hardie wrote:
> > Well, this has been plauging me for months, and finally figured it out.
> >
> > Any 2.6 kernel on my board, would boot, then give errors (paraphrased,
> > sorry) when I tried to bring up the ethernet:
> >
> > NETDEV WATCHDOG: eth0: transmit timed out
> > IRQ #18: Nobody cared!
> >
> > And no ethernet conectivity.
> >
> > The Fix: Update bios from asus' website. I guess their ACPI was screwed
> > up. This is the second time I've had to update this MB to fix
> > incompatibilities with Linux. So, watch out with Asus boards on Linux.
> >
> > BTW - Linux 2.4's driver worked fine with the old bios. Only 2.6 didn't
> > work.
>
> Some additional info, I've been investigating this for a few hours, and
> it appears that (a) IRQ 18 on my system is shared by ide0 and ide1, and
> that the IRQ storm seems to start the first time I use ide1 (DVD only).
>
> I will be posting a bunch of dmesg results when/if the system reboots,
> but acpi={off,ht} doesn't help, pollirq doesn't help, and system
> shutdown leaves the system unbootable without a full (pull the power
> cord) hardware power cycle.
>
> Questions:
> 1 - do you have trouble rebooting after a failure?

Since I flashed my bios, no more problems, so I've had no more failures

> 2 - do you see the IRQ 18 storm start just after the first use of ide1?

No. I got it when I used the ethernet, which was on IRQ 18. I'm not using
ide0 and ide1 on my board. I'm using a 3ware SATA RAID controller

> 3 - and of course if you can get up in console mode, are ide0 and ide1
> shared?

I think they are, although I can't be sure since I am not using them -
They don't show up in my /proc/interrupts.

---
Terry Hardie					terry@net.com
SHOUTip System Architect & Principal Engineer	ICQ#: 977679
net.com, 6900 Paseo Padre Parkway
Fremont, CA 94555, USA				V: +1-510-574-2366
