Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWBHJ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWBHJ7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWBHJ7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:59:03 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:15233 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932425AbWBHJ7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:59:02 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <33D367D1-870E-46AE-A7EC-C938B51E816F@bootc.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: libata PATA status report on 2.6.16-rc1-mm5
Date: Wed, 8 Feb 2006 09:58:57 +0000
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I just gave 2.6.16-rc1-mm5 a shot on my old VIA-based Duron machine,  
and everything seems to work fine. I notice PATA CD-ROMs still aren't  
being recognised (with libata.atapi_enabled=1) which is a bit of a  
shame, but fortunately I won't be needing to use the CD-ROM on this  
machine at all. In fact this machine has so little use that I'm quite  
happy to surrender it to testing.

HTH,
Chris

PS: relevant details below:

[   17.983579] libata version 1.20 loaded.
[   17.983639] pata_via 0000:00:07.1: version 0.1.2
[   17.983675] PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
[   17.983929] ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma  
0xFFA0 irq 14
[   18.140987] ata1: dev 0 cfg 49:2f00 82:74eb 83:43ea 84:4000  
85:7469 86:0002 87:4000 88:203f
[   18.141001] ata1: dev 0 ATA-5, max UDMA/100, 60036480 sectors: LBA
[   18.141094] via_do_set_mode: Mode=12 ast broken=N udma=100 mul=3
[   18.141191] via_do_set_mode: Mode=69 ast broken=N udma=100 mul=3
[   18.141517] ata1: dev 0 configured for UDMA/100
[   18.141579] scsi0 : pata_via
[   18.141961]   Vendor: ATA       Model: IBM-DTLA-307030   Rev: TX4O
[   18.142200]   Type:   Direct-Access                      ANSI SCSI  
revision: 05
[   18.142532] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma  
0xFFA8 irq 15
[   18.452348] scsi1 : pata_via
[   18.452687] SCSI device sda: 60036480 512-byte hdwr sectors (30739  
MB)
[   18.452801] sda: Write Protect is off
[   18.452852] sda: Mode Sense: 00 3a 00 00
[   18.452874] SCSI device sda: drive cache: write back
[   18.453085] SCSI device sda: 60036480 512-byte hdwr sectors (30739  
MB)
[   18.453187] sda: Write Protect is off
[   18.453236] sda: Mode Sense: 00 3a 00 00
[   18.453258] SCSI device sda: drive cache: write back
[   18.453325]  sda: sda1 sda2
[   18.463389] sd 0:0:0:0: Attached scsi disk sda

0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/ 
VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a  
[Master SecP PriP])
         Flags: bus master, medium devsel, latency 64
         I/O ports at ffa0 [size=16]
         Capabilities: [c0] Power Management version 2
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00


