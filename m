Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265330AbTFUUjw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbTFUUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 16:39:52 -0400
Received: from AMontsouris-108-2-4-77.w193-252.abo.wanadoo.fr ([193.252.199.77]:14258
	"EHLO smtp.all-3rd.net") by vger.kernel.org with ESMTP
	id S265330AbTFUUju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 16:39:50 -0400
From: Julien LEMOINE <speedblue@happycoders.org>
Reply-To: Julien LEMOINE <speedblue@happycoders.orgg>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21] SYM53C8XX on alpha system
Date: Sat, 21 Jun 2003 22:53:49 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306212253.49591.speedblue@happycoders.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I have an scsi U160 card with 53c1010 chipset (tekram DC-390U3W) on an Alpha 
PCA56 (Digital AlphaPC 164SX 533 MHz). The card is correctly detected, but 
all U160 HD are detected as FAST-10 SCSI instead of U160. I am using 
"SYM53C8XX Version 2" driver, and I tryed every parameters documented in 
sym53c8xx_2/Documentation.txt.

Thanks.

******** dmesg ********
PCI: dev LSI Logic / Symbios Logic (formerly NCR) 53c1010 Ultra3 SCSI Adapter 
type 64-bit
PCI: dev LSI Logic / Symbios Logic (formerly NCR) 53c1010 Ultra3 SCSI Adapter 
(#2) type 64-bit
PCI: dev LSI Logic / Symbios Logic (formerly NCR) 53c1010 Ultra3 SCSI Adapter 
type 64-bit
PCI: dev LSI Logic / Symbios Logic (formerly NCR) 53c1010 Ultra3 SCSI Adapter 
(#2) type 64-bit
SMC37c669 Super I/O Controller found @ 0x3f0
[...]
SCSI subsystem driver Revision: 1.00
sym.0.7.0: setting PCI_COMMAND_PARITY...
sym.0.7.0: setting PCI_COMMAND_INVALIDATE.
sym.0.7.1: setting PCI_COMMAND_PARITY...
sym.0.7.1: setting PCI_COMMAND_INVALIDATE.
sym0: <1010-33> rev 0x1 on pci bus 0 device 7 function 0 irq 26
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <1010-33> rev 0x1 on pci bus 0 device 7 function 1 irq 26
sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
scsi1 : sym-2.1.17a
blk: queue fffffc000026a8f0, no I/O memory limit
  Vendor: COMPAQ    Model: BD009735C6        Rev: B021
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue fffffc000026aaf0, no I/O memory limit
  Vendor: COMPAQ    Model: BD009735C6        Rev: B021
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue fffffc000026acf0, no I/O memory limit
  Vendor: COMPAQ    Model: BD009735C6        Rev: B021
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue fffffc000026aef0, no I/O memory limit
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:2:0: tagged command queuing enabled, command queue depth 16.
sym0:4:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
sym0:0: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 31)
sda: Spinning up disk.............ready
SCSI device sda: 17773524 512-byte hdwr sectors (9100 MB)
 sda: sda1 sda2 sda3
sym0:2: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 31)
sdb: Spinning up disk.............ready
SCSI device sdb: 17773524 512-byte hdwr sectors (9100 MB)
 sdb: sdb1
sym0:4: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 31)
sdc: Spinning up disk.............ready
SCSI device sdc: 17773524 512-byte hdwr sectors (9100 MB)
 sdc: sdc1

-- 
Julien LEMOINE / SpeedBlue

