Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUAOVQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUAOVQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:16:21 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:59728 "EHLO
	pd5mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262540AbUAOVNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:13:11 -0500
Date: Thu, 15 Jan 2004 14:07:29 -0700
From: Travis Morgan <lkml@bigfiber.net>
Subject: Promise PDC 20376 and 2.6.1
To: linux-kernel@vger.kernel.org
Message-id: <1074200848.5941.44.camel@castle.bigfiber.net>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using the SATA drivers with my MSI motherboard and Promise PDC
20376 controller for some time now. I finally decided, having two
identical Seagate Barracuda drives, that I wanted to RAID them and use
them as my system drive.

I created a striped array within the controller's BIOS and it says that
the array is active and healthy.

When I get into Linux it still has two seperate devices.

lr-xr-xr-x    1 root     root           33 Jan 15 07:14 /dev/sda ->
scsi/host0/bus0/target0/lun0/disc
lr-xr-xr-x    1 root     root           33 Jan 15 07:14 /dev/sdb ->
scsi/host1/bus0/target0/lun0/disc

Should it not have just /dev/sda now? Or does the driver for this
controller not support RAID? I searched the mailing list archives and
tried to find something about it in the Documentation but wasn't able to
find out either way. If not, are there plans for this? Or is it an issue
with Promise IP still?

They are 160 gig drives. I take it they use 512 block sizes.

[02:04:15]<root@castle:~> cat /sys/block/sd[ab]/size
312581808
312581808

And if I try to fdisk one it says 160 gigs.

00:0d.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 6620
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 19
        I/O ports at e800 [size=64]
        I/O ports at e400 [size=16]
        I/O ports at e000 [size=128]
        Memory at dfffe000 (32-bit, non-prefetchable) [size=4K]
        Memory at dffc0000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [60] Power Management version 2

Regards,
Travis M


