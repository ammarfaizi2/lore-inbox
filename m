Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311270AbSCTCkV>; Tue, 19 Mar 2002 21:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311401AbSCTCkL>; Tue, 19 Mar 2002 21:40:11 -0500
Received: from pool-141-153-141-47.mad.east.verizon.net ([141.153.141.47]:51438
	"EHLO bard.cbnet") by vger.kernel.org with ESMTP id <S311270AbSCTCkC>;
	Tue, 19 Mar 2002 21:40:02 -0500
Date: Tue, 19 Mar 2002 21:40:00 -0500 (EST)
From: PlasmaJohn <lkml@projectplasma.com>
To: linux-kernel@vger.kernel.org
Subject: Re: I/O APIC fixed in 2.4.19-pre3 & 2.5.6 (was Re: Linux 2.4.19-pre3)
Message-ID: <Pine.LNX.4.21.0203192116020.15805-100000@bard.cbnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any chance this will cure the lockups on a Dell Latitude C600 every time
> you exit X? I've disabled both the IO-APIC and APIC-uni, which was
> supposed to fix the problem but didn't. Dare I hope that the disable
> wasn't enough?

Does it also lock up when the text console blanks?

The X lockups were what had been plaguing me for the past two weeks.  
I thought it was the new Radeon (7500), but it seems[1] to have been my 
Asus CUSL2-C's[2] broken APM implementation (Quite recently Alan Cox 
mentioned this problem with Asus' BIOS).

Out of fear, I do not compile in ACPI[3].

I have since recompiled with APM as a module and life seems much more
stable.  (I issue "modprobe apm" at shutdown so the box actually turns 
off :)

Perhaps your BIOS has similar "issues"?

John Klar

[1] No lockup in 3 days.  Knock bits.

[2] Intel 815ep, 700MHz Coppermine PIII not overclocked.
    RH6.2 frankensteined to 7.2 (mostly)
    kernel 2.4.15 (with Viro's inode patch) (yes, yes, I'm slow)
    (RH's gcc-2.96-98)
    XFree86 4.2.0 from their binary tarballs.

[3] One of the side-effects of ACPI support is disabling APM if
    an ACPI capable board is found.  This, I suspect, is why reports
    of CUSL2 hangs are rare...

