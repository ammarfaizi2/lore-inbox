Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137037AbREKCdP>; Thu, 10 May 2001 22:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137036AbREKCdG>; Thu, 10 May 2001 22:33:06 -0400
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:43407 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S137035AbREKCcy>; Thu, 10 May 2001 22:32:54 -0400
Message-ID: <3AFB4F54.9D63FC3F@bigfoot.com>
Date: Thu, 10 May 2001 19:32:52 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Reply-To: nicklong@home.com
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20pre2-amd-via-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: ncr53c8xx - DAT detection problem - 2.2.14-5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any clues as to why /dev/st0 is never initialized for DAT tape?  Please cc nicklong@home.com if more
info is needed.

rgds,
tim.
...
ncr53c8xx: at PCI bus 1, device 9, function 0
ncr53c8xx: 53c876 detected 
ncr53c8xx: at PCI bus 1, device 9, function 1
ncr53c8xx: 53c876 detected 
ncr53c876-0: rev=0x14, base=0xc6ffdf00, io_port=0x3000, irq=5
ncr53c876-0: ID 7, Fast-20, Parity Checking
ncr53c876-0: on-chip RAM at 0xc6fff000
ncr53c876-0: restart (scsi reset).
ncr53c876-0: Downloading SCSI SCRIPTS.
ncr53c876-1: rev=0x14, base=0xc6ffde00, io_port=0x3400, irq=9
ncr53c876-1: ID 7, Fast-20, Parity Checking
ncr53c876-1: on-chip RAM at 0xc6ffe000
ncr53c876-1: restart (scsi reset).
ncr53c876-1: Downloading SCSI SCRIPTS.
scsi0 : ncr53c8xx - version 3.2a-2
scsi1 : ncr53c8xx - version 3.2a-2
scsi : 2 hosts.
  Vendor: COMPAQ    Model: BD0096349A        Rev: 3B05
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: COMPAQ    Model: BD0096349A        Rev: 3B05
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
ncr53c876-0-<0,0>: tagged command queue depth set to 8
ncr53c876-0-<1,0>: tagged command queue depth set to 8
  Vendor: SEAGATE   Model: DAT    04106-XXX  Rev: 735B
  Type:   Sequential-Access                  ANSI SCSI revision: 02
ncr53c876-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17773524 [8678 MB] [8.7 GB]
 sda: sda1 sda2 < sda5 >
ncr53c876-0-<1,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 17773524 [8678 MB] [8.7 GB]
 sdb: sdb1 sdb2 < sdb5 sdb6 sdb7 >
...

/sbin/lspci -v
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(AGP disa
bled) (rev 03)
        Flags: bus master, medium devsel, latency 64
        Memory at <unassigned> (32-bit, prefetchable)

00:0b.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45) (prog-if 00
[VGA]
)
        Flags: medium devsel
        Memory at c4000000 (32-bit, prefetchable)
        Memory at c6dff000 (32-bit, non-prefetchable)

00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 04)
(prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Capabilities: [dc] Power Management version 1

00:0e.0 System peripheral: Compaq Computer Corporation: Unknown device a0f0
        Subsystem: Compaq Computer Corporation: Unknown device b0f3
        Flags: medium devsel
        I/O ports at 1800
        Memory at c6dfdf00 (32-bit, non-prefetchable)

00:12.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 10
        Memory at c6dfe000 (32-bit, non-prefetchable)
        I/O ports at 2000
        Memory at c6e00000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

00:14.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:14.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at f100

00:14.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)(prog-if 00 [UHCI])
        Flags: medium devsel
        I/O ports at 5800

00:14.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel

01:07.0 Network controller: Compaq Computer Corporation ProLiant Integrated Netelligent 10/100 (rev
10)
        Flags: medium devsel
        I/O ports at 5820

01:09.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 14)
        Subsystem: Compaq Computer Corporation Embedded Ultra Wide SCSI Controller
        Flags: bus master, medium devsel, latency 255, IRQ 5
        I/O ports at 3000
        Memory at c6ffdf00 (32-bit, non-prefetchable)
        Memory at c6fff000 (32-bit, non-prefetchable)

01:09.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 14)
        Subsystem: Compaq Computer Corporation Embedded Ultra Wide SCSI Controller
        Flags: bus master, medium devsel, latency 255, IRQ 9
        I/O ports at 3400
        Memory at c6ffde00 (32-bit, non-prefetchable)
        Memory at c6ffe000 (32-bit, non-prefetchable)


--
