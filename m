Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWAQU2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWAQU2A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWAQU2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:28:00 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:44499 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964786AbWAQU17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:27:59 -0500
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata_mv important note 
In-reply-to: <200601171734.25598.arekm@pld-linux.org> 
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com> <200601171734.25598.arekm@pld-linux.org>
Comments: In-reply-to Arkadiusz Miskiewicz <arekm@pld-linux.org>
   message dated "Tue, 17 Jan 2006 17:34:25 +0100."
Date: Tue, 17 Jan 2006 13:28:19 -0700
From: Sebastian Kuzminsky <seb@highlab.com>
Message-Id: <E1EyxRD-0007Nd-U5@highlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz <arekm@pld-linux.org> wrote:
> On Tuesday 17 January 2006 17:24, Sebastian Kuzminsky wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > > For sata_mv users, you should be aware of three things:
> > >
> > > 1) The Marvell driver is experimental, and not yet considered ready for
> > > production use.  As Kconfig notes: HIGHLY EXPERIMENTAL.
> >
> > Right, understood.
> 
> I'm using:
> 
> 03:03.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX6041=20
> 4-port SATA II PCI-X Controller (rev 07)
> 
> but with http://www.keffective.com/mvsata/FC3/mvSata-3.4.2a-patched.tbz driver
> and it works nicely (+ 2.8GHz Xeon HT, smp kernel). I was quite suprised to
> see that there are no problems with it in typical usage (while I'm sure that
> this driver is far away from kernel standards).

I'm using:

0000:02:01.0 IDE interface: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 09)

I'm running the stock 2.6.15 kernel & the in-kernel driver.  I have four
disks on this controller.  The controller and disks seem perfectly stable,
I've been running four parallel "badblocks -n" processes (one on each
disk) for almost 5 days now.  Using the disks as PVs in LVM works fine,
and building a RAID-6 out of them also works fine.

But when I build a RAID-6 out of them, and use the array as a PV
for LVM, the system locks up within seconds (no errors, no sysrq,
no CapsLock-blinky, no network-pingy).  This behavior is perfectly
repeatable.

The problem goes away and everything works if I turn on all the debugging
options in the kernel config (but I dont get any debug output from
the kernel).

Arkadiusz, if possible, please see if you can replicate my hang.


-- 
Sebastian Kuzminsky
