Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129754AbRAaXUc>; Wed, 31 Jan 2001 18:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129770AbRAaXUW>; Wed, 31 Jan 2001 18:20:22 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:38370 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129753AbRAaXUD>;
	Wed, 31 Jan 2001 18:20:03 -0500
Date: Thu, 1 Feb 2001 00:19:41 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101312319.AAA18556@harpo.it.uu.se>
To: ajschrotenboer@lycosmail.com
Subject: Re: [BUG] 2.4.1 Detects 64 MB RAM, actual 192MB
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 10:01:08 -0500, Adam Schrotenboer wrote:

> > On Tue, 30 Jan 2001 23:25:22 -0500, Adam Schrotenboer wrote:
> >
> >> 2.4.1 detects 64 MB, but 2.4.0 detects 192 (Maybe 191, not sure).
> >> ...
> >> Linux version 2.4.1 (root@tabriel) (gcc version egcs-2.91.66 
>19990314/Linux (egcs-1.1.2 release)) #9 Tue Jan 30 15:35:21 EST 2001
> >> BIOS-provided physical RAM map:
> >> BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
> >> BIOS-88: 0000000003ff0000 @ 0000000000100000 (usable)
> >> On node 0 totalpages: 16624
>...
>Linux version 2.4.0 (root@tabriel) (gcc version pgcc-2.95.2 19991024 (release)) #2 Mon Jan 8 09:02:27 EST 2001
>BIOS-provided physical RAM map:
> BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
> BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
> BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
> BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
> BIOS-e820: 000000000bef0000 @ 0000000000100000 (usable)
> BIOS-e820: 000000000000d000 @ 000000000bff3000 (ACPI data)
> BIOS-e820: 0000000000003000 @ 000000000bff0000 (ACPI NVS)
>On node 0 totalpages: 49136

Your 2.4.1 kernel is really sick. According to this, your bios
does support E820 and 2.4.0 picks it up correctly. 2.4.1 for
some reason doesn't. I've looked through the 2.4.1 patch and
I cannot see anything which could cause this (the one memory
detection patch there only applies to the legacy bios-88 call).
Besides, 2.4.1 obviously works for the majority of users.

All I can suggest is to recompile 2.4.1 from pristine sources
(make mrproper or get a fresh tarball), using a known safe
compiler and absolutely no strange patches or CFLAGS overrides.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
