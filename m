Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132060AbRBFAGN>; Mon, 5 Feb 2001 19:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136065AbRBFAGC>; Mon, 5 Feb 2001 19:06:02 -0500
Received: from beaker.bluetopia.net ([63.219.235.110]:34640 "EHLO
	beaker.bluetopia.net") by vger.kernel.org with ESMTP
	id <S136046AbRBFAFx>; Mon, 5 Feb 2001 19:05:53 -0500
Date: Mon, 5 Feb 2001 19:05:36 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] 2.4.1 Detects 64 MB RAM, actual 192MB
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFC7@orsmsx31.jf.intel.com>
Message-ID: <Pine.LNX.4.04.10102051856530.2712-100000@beaker.bluetopia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Dunlap, Randy wrote:
...

Interesting...  I just checked my machine (2.4.1-SMP) to see it only saw
64MB when it has 256MB.

>From 2.4.0-test5:
Linux version 2.4.0-test5-SMP (root@chickenboo) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #12 SMP Thu Aug 10 12:56:38 EDT 2000
BIOS-provided physical RAM map: 
 e820: 000000000009fc00 @ 0000000000000000 (usable) 
 e820: 0000000000000400 @ 000000000009fc00 (reserved)
 e820: 0000000000020000 @ 00000000000e0000 (reserved)
 e820: 000000000fee0000 @ 0000000000100000 (usable) 
 e820: 0000000000018000 @ 000000000ffe0000 (ACPI data)
 e820: 0000000000008000 @ 000000000fff8000 (ACPI NVS)
 e820: 0000000000001000 @ 00000000fec00000 (reserved)
 e820: 0000000000001000 @ 00000000fee00000 (reserved)
 e820: 0000000000040000 @ 00000000fffc0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes. 
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000fb560 
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65504
zone(0): 4096 pages.
zone(1): 61408 pages.
zone(2): 0 pages.

>From 2.4.1:
Linux version 2.4.1-SMP (root@chickenboo) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Tue Jan 30 17:13:07 EST 2001
BIOS-provided physical RAM map: 
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable) 
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000003f00000 @ 0000000000100000 (usable) 
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000040000 @ 00000000fffc0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes. 
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000fb560 
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.

Nothing at all has changed in either the BIOS setup, compiler, etc.  All I
did was reboot (and not pay it any attention.)  The configuration was the
same (make oldconfig.)

--Ricky


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
