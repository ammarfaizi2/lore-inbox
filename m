Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSLHBGL>; Sat, 7 Dec 2002 20:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLHBGL>; Sat, 7 Dec 2002 20:06:11 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:29430 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S265077AbSLHBGJ>; Sat, 7 Dec 2002 20:06:09 -0500
Date: Sat, 07 Dec 2002 17:13:32 -0800
From: Bill Leuze <billeuze@shaw.ca>
Subject: can't load 8139too/mii in 2.5.50
To: linux-kernel@vger.kernel.org
Message-id: <1039310012.311.10.camel@krusty.spring>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This module and NIC works in 2.4.20

In 2.5.50 using Rusty's latest modutils, This is the error message I
get:
~# modprobe -v 8139too
insmod /lib/modules/2.5.50/kernel/mii.o
WARNING: Error inserting mii (/lib/modules/2.5.50/kernel/mii.o): Invalid
module format
insmod /lib/modules/2.5.50/kernel/8139too.o
FATAL: Error inserting 8139too (/lib/modules/2.5.50/kernel/8139too.o):
Unknown symbol in module

another clue (maybe) is in the output from dmesg after booting:
Module crc32 cannot be unloaded due to unsafe usage in lib/crc32.c:554
8139too: Unknown symbol mii_ethtool_gset

Here is the dmesg lines from booting 2.4.20:
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 5 for device 00:0e.0
eth0: RealTek RTL8139 Fast Ethernet at 0xf293df80, 00:20:18:88:fc:e5,
IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139 rev K'

Anyone know why it isn't loading in 2.5.50? all my other modules work.

