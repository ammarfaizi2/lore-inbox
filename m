Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbUKCWkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbUKCWkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUKCWh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:37:29 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:28686 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261908AbUKCWda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:33:30 -0500
Date: Wed, 3 Nov 2004 16:33:08 -0600
From: mike.miller@hp.com
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: problems with ACPI on 2.4.28-rc1
Message-ID: <20041103223308.GA3588@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com, mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Can anyone assist with this problem? I'm seeing a hang very early in boot under both 2.4.27 & 2.4.28-rc1.
When the kernel begins to execute the system hangs with ERROR: Invalid Checksum. This seems to be ACPI related. The HW is HP DL360G4. Any help is appreciated. Here is the console output:

GRUB Loading stage2...
  Booting command-list

root (hd0,0)
 Filesystem type is ext2fs, partition type 0x83
kernel /vmlinuz-2427 ro root=LABEL=/ console=ttyS0,115200 console=tty1
   [Linux-bzImage, setup=0x1400, size=0x10b8d4]
initrd /initrd-2427
   [Linux-initrd @ 0x37f45000, 0xaaafb bytes]

ok
Bootdata ok (command line is ro root=LABEL=/ console=ttyS0,115200 console=tty1)
Linux version 2.4.27 (root@orange-rh3u4) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-46)) #1 SMP Wed Nov 3 14:40:24 CST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff3000 (usable)
 BIOS-e820: 000000003fff3000 - 000000003fffb000 (ACPI data)
 BIOS-e820: 000000003fffb000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
kernel direct mapping tables upto 10100000000 @ 8000-c000
No NUMA configuration found
Faking a node at 0000000000000000-000000003fff3000
Bootmem setup node 0 0000000000000000-000000003fff3000
Scan SMP from 0000010000000000 for 1024 bytes.
Scan SMP from 000001000009fc00 for 1024 bytes.
Scan SMP from 00000100000f0000 for 65536 bytes.
found SMP MP-table at 00000000000f4fa0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
setting up node 0 0-3fff3
On node 0 totalpages: 262131
zone(0): 4096 pages.
zone(1): 258035 pages.
zone(2): 0 pages.
ACPI: RSDP (v002 HP                                        ) @ 0x00000000000f4f20
  >>> ERROR: Invalid checksum
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: PROLIANT     APIC at: 0xFEE00000
Processor #0 15:3 APIC version 20
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC10000.
Processors: 1
Checking aperture...
Kernel command line: ro root=LABEL=/ console=ttyS0,115200 console=tty1
Initializing CPU#0
time.c: Detected 1.193182 MHz PIT timer.
time.c: Detected 3000.220 MHz TSC timer.
Console: colour VGA+ 80x25
Calibrating delay loop... 5989.99 BogoMIPS
Memory: 1021296k/1048524k available (1612k kernel code, 0k reserved, 703k data, 152k init)
Dentry cache hash table entries: 131072 (order: 9, 2097152 bytes)
Inode cache hash table entries: 65536 (order: 8, 1048576 bytes)
Mount cache hash table entries: 256 (order: 0, 4096 bytes)

I've tried several different things including disabling ACPI in the kernel, erasing NVRAM, etc. No luck.

Thanks,
mikem
