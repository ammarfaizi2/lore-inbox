Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVBBS6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVBBS6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVBBSz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:55:27 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:28856 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S262751AbVBBSs5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:48:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux hangs during IDE initialization at boot for 30 sec
Date: Wed, 2 Feb 2005 10:48:45 -0800
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B301ACE7F7@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux hangs during IDE initialization at boot for 30 sec
Thread-Index: AcUIVeTWldzlZY7gSRGqCb1aAi8JNQBATYUA
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Michael Brade" <brade@informatik.uni-muenchen.de>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Feb 2005 18:48:57.0127 (UTC) FILETIME=[D9D3D370:01C50957]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Michael Brade
>Sent: Tuesday, February 01, 2005 3:58 AM
>To: linux-kernel@vger.kernel.org
>Subject: Linux hangs during IDE initialization at boot for 30 sec
>
[snip]
>
>I found additional lines in the log just before the line above:
>
>Probing IDE interface ide2...
>Probing IDE interface ide3...
>Probing IDE interface ide4...
>Probing IDE interface ide5...
>
>But I only have ide0 and ide1. This problem persists even with 
>2.6.11-rc2. For 
>the last test I removed every option from the kernel that is 
>not needed, but 
>the problem stays. So I'm sure it's not because of ACPI or PNP 
>or the like.
>
>With 2.6.11-rc2 I get in my syslog:
>
>Feb  1 11:30:02 newton kernel: ICH3M: chipset revision 2
>Feb  1 11:30:02 newton kernel: ICH3M: not 100%% native mode: 
>will probe irqs 
>later
>Feb  1 11:30:02 newton kernel:     ide0: BM-DMA at 0xcfa0-0xcfa7, BIOS 
>settings: hda:DMA, hdb:pio
>Feb  1 11:30:02 newton kernel:     ide1: BM-DMA at 0xcfa8-0xcfaf, BIOS 
>settings: hdc:DMA, hdd:pio
>Feb  1 11:30:02 newton kernel: Probing IDE interface ide0...
>Feb  1 11:30:02 newton kernel: hda: HITACHI_DK23DA-30, ATA DISK drive
>Feb  1 11:30:02 newton kernel: DEV: registering device: ID = 'ide0'
>Feb  1 11:30:02 newton kernel: PM: Adding info for No Bus:ide0
>Feb  1 11:30:02 newton kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>Feb  1 11:30:02 newton kernel: DEV: registering device: ID = '0.0'
>Feb  1 11:30:02 newton kernel: PM: Adding info for ide:0.0
>Feb  1 11:30:02 newton kernel: bus ide: add device 0.0
>Feb  1 11:30:02 newton kernel: Probing IDE interface ide1...
>Feb  1 11:30:02 newton kernel: hdc: TOSHIBA DVD-ROM SD-R2212, 
>ATAPI CD/DVD-ROM 
>drive
>Feb  1 11:30:02 newton kernel: DEV: registering device: ID = 'ide1'
>Feb  1 11:30:02 newton kernel: PM: Adding info for No Bus:ide1
>Feb  1 11:30:02 newton kernel: ide1 at 0x170-0x177,0x376 on irq 15
>Feb  1 11:30:02 newton kernel: DEV: registering device: ID = '1.0'
>Feb  1 11:30:02 newton kernel: PM: Adding info for ide:1.0
>Feb  1 11:30:02 newton kernel: bus ide: add device 1.0
>Feb  1 11:30:02 newton kernel: bus pci: add driver PIIX_IDE
>Feb  1 11:30:02 newton kernel: bound device '0000:00:1f.1' to driver 
>'PIIX_IDE'
>Feb  1 11:30:02 newton kernel: bus pci: add driver PCI_IDE
>Feb  1 11:30:02 newton kernel: Probing IDE interface ide2...
>Feb  1 11:30:02 newton kernel: Probing IDE interface ide3...
>Feb  1 11:30:02 newton kernel: Probing IDE interface ide4...
>Feb  1 11:30:02 newton kernel: ide4: Wait for ready failed 
>before probe !
>---> I guess the line above is the reason for the wait <---
>Feb  1 11:30:02 newton kernel: Probing IDE interface ide5...
>Feb  1 11:30:02 newton kernel: hda: max request size: 128KiB
>

Since you don't care about anything except ide0 & ide1, try to add
the following to the kernel's command line:
ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe

Aleks.
