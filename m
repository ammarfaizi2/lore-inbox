Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422835AbWBNWWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbWBNWWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWBNWWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:22:07 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:18182 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1422836AbWBNWWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:22:06 -0500
Date: Tue, 14 Feb 2006 23:22:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Random reboots
Message-Id: <20060214232222.5d4384a8.khali@linux-fr.org>
In-Reply-To: <20060214132904.GI16566@tau.solarneutrino.net>
References: <20060213210435.GC16566@tau.solarneutrino.net>
	<20060213211044.066CE5E401E@latitude.mynet.no-ip.org>
	<20060213212243.GE16566@tau.solarneutrino.net>
	<7c3341450602131332x2fcd7d8co@mail.gmail.com>
	<20060213213929.GG16566@tau.solarneutrino.net>
	<20060214132904.GI16566@tau.solarneutrino.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

> > We recently had such an issue with a dual AMD64 machine rebooting at
> > mke2fs. It turned out it was a faulty power supply. After we changed
> > the power supply, everything ran smooth again.
> > 
> > You could start to test by powering your drives from an old AT-style
> > power supply leaving more "juice" for the main board and CPUs.
> 
> It's possible, but I doubt it.  More often than not, the reboot happens
> when the machine is completely idle - in fact I can't remember a single
> time when it wasn't idle.  I just spent a couple months debugging a
> SCSI-tape crash, and I ran the backups a lot and had lots of RAID
> resyncs and it *never* rebooted during either of these events.  Anyway
> it has quite a large 2+1 redundant power supply, and, like I said, we
> routinely had 3+ months of uptime with older kernels.

You seem to have hardware monitoring drivers loaded on the system, so
I'd suggest that you watch the returned values over time. If the
hardware is going wrong it might show there. Your system could be
overheating for some reason (stuck fan...)

The fact that older kernels were seemingly working better doesn't prove
much. You were running these kernels before, not now, and hardware
*does* age, contrary to what people seem to think. If you want to make
certain that older kernels were indeed working better for purely
software reasons, you should switch back to such an old kernel and see
if things actually improve or not.

A wild guess while I'm at it... Is the machine behind a KVM switch by
any chance? I have a fun (old) motherboard here which reboots when I
unplug the keyboard and plug it again. Never seen that before...

> During the years I've had this machine, I've experienced at least 10-15
> strange kernel bugs that only happened on this machine.  Each and every
> time I was *convinced* that the hardware was at fault (and people on the
> mailing list suggested it) until either a kernel came out that fixed the
> problem or a kernel developer positively identified it as a kernel
> problem and eventually fixed it.  This machine just seems to be a magnet
> for kernel bugs.

Note that the first case ("a kernel came out that fixed the problem")
doesn't mean that the hardware was not at fault. There are quite a few
quirks in the Linux kernel code which are just there to workaround
known hardware or BIOS bugs.

-- 
Jean Delvare
