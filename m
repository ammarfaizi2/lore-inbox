Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBURuo>; Wed, 21 Feb 2001 12:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBURuf>; Wed, 21 Feb 2001 12:50:35 -0500
Received: from host217-32-138-113.hg.mdip.bt.net ([217.32.138.113]:65031 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129051AbRBURuU>;
	Wed, 21 Feb 2001 12:50:20 -0500
Date: Wed, 21 Feb 2001 17:53:18 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Desjardins, Kristian" <Kristian.Desjardins@CCRS.NRCan.gc.ca>
cc: linux-kernel@vger.kernel.org
Subject: RE: 128MB lost... where ?
In-Reply-To: <2951561DB3DDD0118FEC00805FFE98050435E154@s5-ccr-r1>
Message-ID: <Pine.LNX.4.21.0102211750140.2050-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

free is not an interesting command. Much more interesting is the kernel
messages on boot, e.g. on my laptop it looks like this:

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 000000000000c000 @ 00000000000c0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000010000 @ 0000000007ff0000 (ACPI data)
 BIOS-e820: 0000000000060000 @ 00000000100a0000 (reserved)
 BIOS-e820: 0000000000200000 @ 00000000ffe00000 (reserved)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=241 ro root=302
BOOT_FILE=/boot/vmlinuz-2.4.1
Initializing CPU#0
Detected 448.628 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 894.56 BogoMIPS
kdb version 1.7 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights
Reserved
Memory: 125696k/131008k available (1311k kernel code, 4924k reserved, 949k
data, 184k init, 0k highm
em)

as you can see, the above tells you exactly how many pages you have in
each zone and the total number of usable pages. But even that is not
relevant to your question. What is relevant is the number after the first
"/" in the "Memory:" line and also the BIOS-e820 map, of course.

Also, on 6.4G machine you should definitely use 64G i.e. PAE support and
so if not all memory is detected, please report to this list. People like
David Parsons will probably be interested in your configuration...

Regards,
Tigran

