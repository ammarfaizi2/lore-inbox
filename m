Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTIVVZD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTIVVZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:25:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:26280 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263328AbTIVVY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:24:59 -0400
Message-Id: <200309222124.h8MLOon25385@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linuxppc-dev@lists.linuxppc.org
cc: linux-kernel@vger.kernel.org
Subject: PPC - ohci-1394 - bad scheduling while atomic ( -test5  )
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Sep 2003 14:24:50 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kernel is latest from ppc.bkbits.net/linuxppc-2.5
System is iBook2, 500Mhz processor
Distro is Debian unstable. 
Firewire drivers built as modules

CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m

On boot, i see following msg, however firewire devices
tested so far work fine ( firewire disk )

cliffw
(Please cc me, i am not on linuxpcc-dev, thanks ) 
--------------------------------------

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max 
Packet=[2048]
bad: scheduling while atomic!
Call trace:
 [c0009d88] dump_stack+0x18/0x28
 [c0016fa4] schedule+0x620/0x624
 [c00061f4] syscall_exit_work+0x120/0x124
 [d79e9d48] 0xd79e9d48
 [d9b7eacc] nodemgr_add_host+0xac/0x11c [ieee1394]
 [d9b7a474] highlevel_add_host+0xac/0xb4 [ieee1394]
 [d9b79684] hpsb_add_host+0x80/0xc0 [ieee1394]
 [d9b3d154] ohci1394_pci_probe+0x38c/0x4f4 [ohci1394]
 [c00f94c4] pci_device_probe_static+0x6c/0x8c
 [c00f9534] __pci_device_probe+0x50/0x70
 [c00f9584] pci_device_probe+0x30/0x60
 [c0143650] bus_match+0x50/0x8c
 [c01437d0] driver_attach+0x88/0xc8
 [c0143b24] bus_add_driver+0x94/0xfc
 [c0143f9c] driver_register+0x30/0x40
raw1394: /dev/raw1394 device initialized
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Node 0-00:1023: Using 36byte inquiry workaround


