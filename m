Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267214AbUHIU60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267214AbUHIU60 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUHIU4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:56:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:53385 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267212AbUHIUt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:49:59 -0400
X-Authenticated: #494916
Message-ID: <41181BF7.6060002@gmx.de>
Date: Tue, 10 Aug 2004 02:51:03 +0200
From: Peter Schaefer <peter.schaefer@gmx.de>
Reply-To: peter.schaefer@gmx.de
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [VIA-RHINE] Timeouts on EP-HDA3+ Motherboard
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm getting reproducable errors when Samba is transferring
large files:

eth0: Transmit timed out, status 0000, PHY status 786d, resetting...

This is not the case if such a file is transferred using FTP.

And yes, im running with "pci=noacpi,usepirqmask,biosirq noapic"
(otherwise the problem happens so frequently that eth0 is more
or less unusable).

I know that the Via-Rhine hardware and/or the driver isn't
perfect, but b/c i'm having a reproducable testcase here, i
thought i might be able to assist in fixing this problem (if
it is fixable at all, of course). In addition, as this
machine is mainly a Samba fileserver it's getting pretty
annoying.

I'm using an Epox EP-8HDA3+ Athlon64 Motherboard with
VIA K8T800 chipset. The board has two on-board ethernet
devices, the VIA Rhine 100BaseT and an 3Com/Marvell 1000BaseT
chip. Both are sharing it's interrupts with each other and
on-board USB devices (however i'm neither using the Marvell
nor any USB peripherals):

PCI: Sharing IRQ 12 with 0000:00:08.0
PCI: Sharing IRQ 12 with 0000:00:10.0
PCI: Sharing IRQ 12 with 0000:00:10.1
PCI: Sharing IRQ 12 with 0000:00:12.0

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
0000:00:08.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
0000:00:09.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
0000:00:0e.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial 
ATA Controller (rev 02)
0000:00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]

*Please CC me, because i'm not subscribed to the list*

Thanks and best regards,

  Peter
