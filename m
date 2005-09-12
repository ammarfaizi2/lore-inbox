Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVILQcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVILQcE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVILQcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:32:04 -0400
Received: from main.gmane.org ([80.91.229.2]:61359 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932070AbVILQcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:32:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: On bott: printk twice for SATA drive under libata? (SMP related?)
Date: Tue, 13 Sep 2005 01:25:43 +0900
Message-ID: <dg4a7l$ugf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, there.

Not sure if this is a bug or not, but is there any reason to "find"
a SATA disk drive twice during boot? Here is a snippet of dmesg:

Linux version 2.6.13.1-K01 (root@char) (gcc version 3.3.6 (Gentoo
3.3.6, ssp-3.3.6-1.0, pie-8.7.8)) #1 SMP Sat Sep 10 14:56:54 JST 2005
...
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
...
CPU0: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
...
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 03
...
libata version 1.12 loaded.
ahci version 1.01
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl
IDE mode
ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xF8806D00 ctl 0x0 bmdma 0x0 irq 19
ata2: SATA max UDMA/133 cmd 0xF8806D80 ctl 0x0 bmdma 0x0 irq 19
ata3: SATA max UDMA/133 cmd 0xF8806E00 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xF8806E80 ctl 0x0 bmdma 0x0 irq 19
ata1: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43
87:4003 88:007f
ata1: dev 0 ATA, max UDMA/133, 145226112 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: no device found (phy stat 00000000)
scsi1 : ahci
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 31.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
...

This is a dual-core P4 system (single CPU), that might be the
problem if it is considered a problem. Almost vanilla-2.6.13.1
(sk98lin and mppe-mppc patched)

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

