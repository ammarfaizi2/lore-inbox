Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRIZKXa>; Wed, 26 Sep 2001 06:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273309AbRIZKXL>; Wed, 26 Sep 2001 06:23:11 -0400
Received: from hacksaw.org ([216.41.5.170]:35989 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S271911AbRIZKXA>; Wed, 26 Sep 2001 06:23:00 -0400
Message-Id: <200109261023.f8QANQ901237@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.3
To: linux-kernel@vger.kernel.org
Subject: stuck on TLB IPI wait (CPU#0)  ??? [2.2.19]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Sep 2001 06:23:26 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran scsi_info, which appeared to run just fine. Then the machine moved into 
molasses mode.

The last log entries I before the reboot was this:

Sep 26 04:59:23 habitrail kernel: IP_MASQ:reverse ICMP: failed checksum from 
193.158.133.165!
Sep 26 05:00:00 habitrail kernel: IP_MASQ:reverse ICMP: failed checksum from 
195.252.130.145!
Sep 26 05:28:55 habitrail kernel: IP_MASQ:reverse ICMP: failed checksum from 
193.158.133.165!
Sep 26 05:29:13 habitrail kernel: IP_MASQ:reverse ICMP: failed checksum from 
193.158.133.165!
Sep 26 05:43:51 habitrail sudo:  hacksaw : TTY=pts/0 ; PWD=/lib/modules/2.2.19 
; USER=root ; COMMAND
=/sbin/scsi_info /dev/sda 
Sep 26 05:44:01 habitrail kernel: stuck on TLB IPI wait (CPU#0) 
Sep 26 05:45:00 habitrail last message repeated 4 times


A bit of info about the machine:
Sep 26 06:01:57 habitrail kernel: Linux version 2.2.19 
(hacksaw@habitrail.home.fools-errant.com) (gc
c version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 SMP Sat Jun 2 
22:24:40 EDT 2001
Sep 26 06:01:57 habitrail kernel: BIOS-provided physical RAM map: 
Sep 26 06:01:57 habitrail kernel:  BIOS-e820: 0009f000 @ 00000000 (usable) 
Sep 26 06:01:57 habitrail kernel:  BIOS-e820: 1ff00000 @ 00100000 (usable) 
Sep 26 06:01:57 habitrail kernel: Intel MultiProcessor Specification v1.1 
Sep 26 06:01:57 habitrail kernel:     Virtual Wire compatibility mode. 
Sep 26 06:01:57 habitrail kernel: OEM ID: OEM00000 Product ID: PROD00000000 
APIC at: 0xFEE00000
Sep 26 06:01:57 habitrail kernel: Processor #0 Pentium(tm) Pro APIC version 17 
Sep 26 06:01:57 habitrail kernel: Processor #1 Pentium(tm) Pro APIC version 17 
Sep 26 06:01:57 habitrail kernel: I/O APIC #2 Version 17 at 0xFEC00000. 
Sep 26 06:01:57 habitrail kernel: Processors: 2 
Sep 26 06:01:57 habitrail kernel: mapped APIC to ffffe000 (fee00000) 
Sep 26 06:01:57 habitrail kernel: mapped IOAPIC to ffffd000 (fec00000) 
Sep 26 06:01:57 habitrail kernel: Detected 451029 kHz processor. 
Sep 26 06:01:57 habitrail kernel: Console: colour VGA+ 132x60 
Sep 26 06:01:57 habitrail kernel: Calibrating delay loop... 897.84 BogoMIPS 
Sep 26 06:01:57 habitrail kernel: Memory: 516528k/524288k available (1640k 
kernel code, 420k reserve
d, 5616k data, 84k init) 

It's a Soyo motherboard. It has a SCSI drive from which it boots, CD-ROM and 
tape drive. It also has an IDE drive, which is used for backup, and extra 
storage.

At the time of the crash, I was reading mail.

I've never had this happen before. My uptimes with this kernel have typically 
run into weeks or months, and have always been broken because I was 
reconfiguring the kernel.

The IP_MASQ icmp checksum things are often in the logs; I could never find 
anyone to explain what they were. As far as I know, they are not causing me 
problems.

Should I care about the TLB IPI thing? Should I not run scsi_info? (I'd run a 
test, but it's a production machine, and I didn't want it down at all. I might 
be able to test later if this is an unknown problem.


-- 
Digression is nine tenths of the lore
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


