Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbULYVni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbULYVni (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbULYVni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:43:38 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:57044 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261581AbULYVnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:43:19 -0500
From: Juergen Krause <Krause.J@gmx.de>
Reply-To: Krause.J@gmx.de
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.10: promise sx6000 not detected by i2o_block
Date: Sat, 25 Dec 2004 22:44:48 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412252244.48875.Krause.J@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am happy to see that kernel 2.6 supports the promise sx6000,
but my controller isn't detected by the kernel.

Infos about my computer:
AMD Athlon(tm) 64 Processor 3200+
ASUS A8V Deluxe

Infos about controller:
Promise SX6000
firmware: 1.20.0.27

lspci output:
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0282
0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1282
0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2282
0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3282
0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4282
0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7282
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
0000:00:0a.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 13)
0000:00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH B1 ISDN
0000:00:0c.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 02)
0000:00:0c.1 Class ff00: Intel Corp. 80960RM [i960RM Microprocessor] (rev 02)
0000:00:0e.0 SCSI storage controller: Adaptec AHA-2930CU (rev 03)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:02:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64 Pro] (rev 15)

the attached 5 harddrives are configured as 1 raid5 group, so I load following i2o modules

i2o_core
i2o_proc
i2o_block

syslog entries when i2o modules are loaded:

Dec 25 21:28:26 server I2O Core - (C) Copyright 1999 Red Hat Software
Dec 25 21:28:26 server i2o: max_drivers=4
Dec 25 21:28:26 server I2O Block Storage OSM v0.9
Dec 25 21:28:26 server (c) Copyright 1999-2001 Red Hat Software.
Dec 25 21:28:26 server block-osm: registered device at major 80

I running gentoo linux with udev-050, 

The controller works fine under linux 2.4 with the promise driver (1.34.0.1) and under windows xp.

Do I anything wrong or is the Promise sx6000 support still broken?

Regards,
Juergen Krause

