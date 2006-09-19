Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWISG2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWISG2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWISG2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:28:31 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:49570 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S1030199AbWISG2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:28:31 -0400
Date: Mon, 18 Sep 2006 23:28:28 -0700
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM
Message-ID: <20060919062828.GD7845@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <p73bqpd62b2.fsf@verdi.suse.de> <20060918235854.GL4610@chain.digitalkingdom.org> <200609190804.14786.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200609190804.14786.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 08:04:14AM +0200, Andi Kleen wrote:
> 
> > Done; it's at
> > http://teddyb.org/~rlpowell/media/regular/lkml/hacked-boot.txt
> > 
> > Note that I had to us "mce=off acpi=off pci=conf1" to get any of
> > that hack's output to show up at all; I wasn't clear whether you
> > intended that or not.
> 
> Unfortunately with mce=off we can't see which device breaks. Can
> you please boot with the patch and just 
> 
> acpi=off pci=conf1 ? 
> 
> and send the full output?

The result is a reboot in the middle of bringing up CPU#1.  No
output from the patch is printed.

I've printed it below anyways.

-Robin

rBootdata ok (command line is root=/dev/sda2 ro console=ttyS1 acpi=off pci=conf1)
Linux version 2.6.17.11 (root@sv-furldb1i) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #4 SMP Mon Sep 18 12:57:57 PDT 2006
BIOS-provided physical RAM map:                                            |
 BIOS-e820: 0000000000000000 - 000000000009b000 (usable)pi=off pci=conf1   |
 BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)                 |
 BIOS-e820: 00000000000cc000 - 0000000000100000 (reserved)                 |
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)                   |
 BIOS-e820: 000000007ff70000 - 000000007ff76000 (ACPI data)                |
 BIOS-e820: 000000007ff76000 - 000000007ff80000 (ACPI NVS)                 |
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)                 |
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)                 |
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)                 |
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)                 |
DMI present.                                                               |
Intel MultiProcessor Specification v1.4------------------------------------+
    Virtual Wire compatibility mode. which entry is highlighted.
OEM ID: AMD      Product ID: HAMMER       APIC at: 0xFEE00000the
Processor #0 15:5 APIC version 16mmand-line, 'o' to open a new line
Processor #1 15:5 APIC version 16selected line, 'd' to remove the
I/O APIC #2 Version 17 at 0xFEC00000.back to the main menu.
I/O APIC #3 Version 17 at 0xFB000000.
I/O APIC #4 Version 17 at 0xFB001000.
Setting APIC routing to flat
Processors: 2
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Checking aperture...
CPU 0: aperture @ e0000000 size 64 MB
CPU 1: aperture @ e0000000 size 64 MB
Built 1 zonelists
Kernel command line: root=/dev/sda2 ro console=ttyS1 acpi=off pci=conf1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 1.193182 MHz WALL PIT GTOD PIT/TSC timer.
time.c: Detected 1804.140 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2059504k/2096576k available (2612k kernel code, 36384k reserved, 1205k data, 224k init)
Calibrating delay using timer specific routine.. 3614.04 BogoMIPS (lpj=18070214)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Uÿ

