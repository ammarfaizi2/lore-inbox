Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287984AbSABXzE>; Wed, 2 Jan 2002 18:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288037AbSABXym>; Wed, 2 Jan 2002 18:54:42 -0500
Received: from laweleka.austria.eu.net ([193.154.160.152]:62365 "EHLO
	laweleka.austria.eu.net") by vger.kernel.org with ESMTP
	id <S288046AbSABXxO>; Wed, 2 Jan 2002 18:53:14 -0500
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
From: Harald Holzer <harald.holzer@eunet.at>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Timothy D. Witham" <wookie@osdl.org>
In-Reply-To: <1009995669.1253.17.camel@wookie-laptop.pdx.osdl.net>
In-Reply-To: <1009649897.12942.2.camel@hh2.hhhome.at> 
	<1009992652.1249.11.camel@wookie-laptop.pdx.osdl.net> 
	<1009994687.12942.14.camel@hh2.hhhome.at> 
	<1009995669.1253.17.camel@wookie-laptop.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Jan 2002 00:50:50 +0100
Message-Id: <1010015450.15492.19.camel@hh2.hhhome.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today i checked some memory configurations and noticed that the low
memory decreases, when i add more memory to the system,
and the size of reserved memory increases:

at 1GB ram, are 16,936kB low mem reserved.
4GB ram, 72,824kB reserved
8GB ram, 142,332kB reserved
16GB ram, 269,424kB reserved
32GB ram, 532,080kB reserved, usable low mem: 352 MB
64GB ram ?? 

Which function does the reserved memory fulfill ?
Is it all for paging ?


Harald Holzer



Memory related startup messages at 32GB:

Jan  1 15:56:05 localhost kernel: Linux version 2.4.17-64g (root@bigbox) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1 SMP Tue Jan 1 14:19:36 CET 2002
Jan  1 15:56:05 localhost kernel: BIOS-provided physical RAM map:
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 0000000000100000 - 0000000003ff8000 (usable)
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 0000000003ff8000 - 0000000003fffc00 (ACPI data)
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 0000000003fffc00 - 0000000004000000 (ACPI NVS)
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 0000000004000000 - 00000000f0000000 (usable)
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jan  1 15:56:05 localhost kernel:  BIOS-e820: 0000000100000000 - 0000000810000000 (usable)
Jan  1 15:56:05 localhost kernel: 32128MB HIGHMEM available.
Jan  1 15:56:05 localhost kernel: found SMP MP-table at 000f65d0
Jan  1 15:56:05 localhost kernel: hm, page 000f6000 reserved twice.
Jan  1 15:56:05 localhost kernel: hm, page 000f7000 reserved twice.
Jan  1 15:56:05 localhost kernel: hm, page 0009d000 reserved twice.
Jan  1 15:56:05 localhost kernel: hm, page 0009e000 reserved twice.
Jan  1 15:56:05 localhost kernel: On node 0 totalpages: 8454144
Jan  1 15:56:05 localhost kernel: zone(0): 4096 pages.
Jan  1 15:56:05 localhost kernel: zone(1): 225280 pages.
Jan  1 15:56:05 localhost kernel: zone(2): 8224768 pages.
Jan  1 15:56:05 localhost kernel: Intel MultiProcessor Specification v1.4
Jan  1 15:56:05 localhost kernel:     Virtual Wire compatibility mode.
Jan  1 15:56:05 localhost kernel: OEM ID: INTEL    Product ID: SPM8         APIC at: 0xFEE00000
Jan  1 15:56:05 localhost kernel: Processor #7 Pentium(tm) Pro APIC version 17
Jan  1 15:56:05 localhost kernel: Processor #0 Pentium(tm) Pro APIC version 17
Jan  1 15:56:05 localhost kernel: Processor #1 Pentium(tm) Pro APIC version 17
Jan  1 15:56:05 localhost kernel: Processor #2 Pentium(tm) Pro APIC version 17
Jan  1 15:56:05 localhost kernel: Processor #3 Pentium(tm) Pro APIC version 17
Jan  1 15:56:05 localhost kernel: Processor #4 Pentium(tm) Pro APIC version 17
Jan  1 15:56:05 localhost kernel: Processor #5 Pentium(tm) Pro APIC version 17
Jan  1 15:56:05 localhost kernel: Processor #6 Pentium(tm) Pro APIC version 17
Jan  1 15:56:05 localhost kernel: I/O APIC #8 Version 19 at 0xFEC00000.
Jan  1 15:56:05 localhost kernel: Processors: 8
Jan  1 15:56:05 localhost kernel: Kernel command line: BOOT_IMAGE=linux-17-64g ro root=802 BOOT_FILE=/boot/vmlinuz-2.4.17-64g console=ttyS0,38400
Jan  1 15:56:05 localhost kernel: Initializing CPU#0
Jan  1 15:56:05 localhost kernel: Detected 700.082 MHz processor.
Jan  1 15:56:05 localhost kernel: Console: colour VGA+ 80x25
Jan  1 15:56:05 localhost kernel: Calibrating delay loop... 1395.91 BogoMIPS

-->Jan  1 15:56:05 localhost kernel: Memory: 33021924k/33816576k available (1081k kernel code, 532080k reserved, 290k data, 248k init, 32636928k highmem)

Jan  1 15:56:05 localhost kernel: Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  1 15:56:05 localhost kernel: Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  1 15:56:05 localhost kernel: Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan  1 15:56:05 localhost kernel: Buffer-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Jan  1 15:56:05 localhost kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)


