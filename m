Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRBACXe>; Wed, 31 Jan 2001 21:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129919AbRBACXX>; Wed, 31 Jan 2001 21:23:23 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:31243 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129460AbRBACXO>; Wed, 31 Jan 2001 21:23:14 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFC7@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Adam Schrotenboer'" <ajschrotenboer@lycosmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] 2.4.1 Detects 64 MB RAM, actual 192MB
Date: Wed, 31 Jan 2001 18:22:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Adam Schrotenboer [mailto:ajschrotenboer@lycosmail.com]
> 
> > On Wed, 31 Jan 2001 10:01:08 -0500, Adam Schrotenboer wrote:
> > 
> >>> On Tue, 30 Jan 2001 23:25:22 -0500, Adam Schrotenboer wrote:
> >>> 
> >>>> ...
> >>>> Linux version 2.4.1 (root@tabriel) (gcc version egcs-2.91.66 
> >>> 
> >> 19990314/Linux (egcs-1.1.2 release)) #9 Tue Jan 30 
> 15:35:21 EST 2001
> >> 
> >>>> BIOS-provided physical RAM map:
> >>>> BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
> >>>> BIOS-88: 0000000003ff0000 @ 0000000000100000 (usable)
> >>>> On node 0 totalpages: 16624
> >>> 
> >> ...
> >> Linux version 2.4.0 (root@tabriel) (gcc version 
> pgcc-2.95.2 19991024 (release)) #2 Mon Jan 8 09:02:27 EST 2001
> >> BIOS-provided physical RAM map:
> >> BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
> >> BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
> >> BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
> >> BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
> >> BIOS-e820: 000000000bef0000 @ 0000000000100000 (usable)
> >> BIOS-e820: 000000000000d000 @ 000000000bff3000 (ACPI data)
> >> BIOS-e820: 0000000000003000 @ 000000000bff0000 (ACPI NVS)
> >> On node 0 totalpages: 49136
> 
> It did it again. fresh tree, egcs 1.1.2, etc
~~~~~~~~~~~~~~~~~~~~~~~~~~~
Different versions of gcc were used on 2.4.0 vs. 2.4.1.
Were different versions of as also used?  (hint?)

Or somehow in linux/arch/i386/boot/setup.S, your source
file has
#define STANDARD_MEMORY_BIOS_CALL
?

~Randy  /  503-677-5408
_______________________________________________
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
