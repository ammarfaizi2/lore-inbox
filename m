Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUGUPpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUGUPpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUGUPpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:45:31 -0400
Received: from 214.98-30-64.ftth.swbr.surewest.net ([64.30.98.214]:13586 "HELO
	sublime.the-space.net") by vger.kernel.org with SMTP
	id S266512AbUGUPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:45:28 -0400
Date: Wed, 21 Jul 2004 08:46:11 -0700 (PDT)
From: Andy Biddle <andyb@chainsaw.com>
X-X-Sender: andyb@sublime.winfirst.com
To: linux-kernel@vger.kernel.org
Subject: Re: Asus A7M266-D, Linux 2.6.7 and APIC
In-Reply-To: <200407211045.i6LAjjmO024229@harpo.it.uu.se>
Message-ID: <20040721084241.P27268@sublime.winfirst.com>
References: <200407211045.i6LAjjmO024229@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well I had a few minutes this morning, so I swapped CPU0 and 1 and still
have the same results.  Boots in single proc mode, APIC errors on a
dual-proc kernel.  (For what it's worth, both CPUs are recognized by the
BIOS and report "MP capable".

I checked the Asus website and I'm at the latest beta kernel...

Tonight I'll bounce back to the 1800+s to see if it's a BIOS thing...

Any other suggestions?

Thanks,
AndyB

On Wed, 21 Jul 2004, Mikael Pettersson wrote:

> On Tue, 20 Jul 2004 17:55:32 -0700 (PDT), Andy Biddle wrote:
> >I have a dual-proc server that I've recently decided to overhaul.  It's an
> >Asus A7M266-D motherboard.  It had been running with dual Athlon MP 1800+s
> >and RedHat and BIOS rev 1003 for at least a year with no real problems.
> >
> >First I decided to change the OS to Gentoo.  I build the system with no
> >problem and built a custom kernel based on linux 2.6.7-gentoo-r11.
> >Everything was working great.  Then I changed out the procs and went with
> >dual Athlon MP 2800+s.  To support these, I needed to (according to Asus's
> >website) upgrade the BIOS to 1011.002 or higher.  (Latest is 1011.003, so
> >that's what I used.)
> >
> >Now, when I boot to this custom kernel I get about 2 seconds into the boot
> >process before the system starts spewing constant "APIC error on CPU0:
> >04(04)" messages.   It stops booting at that point.
> >
> >I've done a little research and it seems that I'm supposed to do a couple
> >of things:
> >	1.  Disable "MPS 1.4 Support" in the BIOS.
> >	2.  pass the kernel "noapic" as a parameter.
> >
> >I've done both of these and I STILL get the APIC messages.  (Which leads
>
> 04 is "send accept error". That noapic doesn't kill it means
> that it occurs when CPU0 sends messages to CPU1.
>
> I suspect that CPU1 isn't booting properly, or that the BIOS
> set it up with an APIC ID not matching the MP table.
>
> How far in the boot did it get before the errors & halt?
>
> 1. Try swapping CPU0 and CPU1.
> 2. Try downgrading both CPUs to your original MP 1800+ ones.
> 3. Check if ASUS' German ftp site has a newer beta BIOS than
>    that 1011.003 you're using. For older boards these betas
>    may be the only way to get newer CPUs to work.
>
>
