Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbQLSVH4>; Tue, 19 Dec 2000 16:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQLSVHq>; Tue, 19 Dec 2000 16:07:46 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:44302 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130509AbQLSVHd>; Tue, 19 Dec 2000 16:07:33 -0500
Date: Tue, 19 Dec 2000 12:36:27 -0800 (PST)
From: ferret@phonewave.net
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@chiara.elte.hu
Subject: Re: Startup IPI (was: Re: test13-pre3)
In-Reply-To: <1021802F66E2@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.3.96.1001219121651.11337A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2000, Petr Vandrovec wrote:

> On 18 Dec 00 at 21:59, ferret@phonewave.net wrote:
> > 
> > Pardon me for not fully groking the issues here and possibly coming to a
> > wrong conclusion, but this has to do with SMP systems crashing at APIC
> > init time, just before penguin display (with fbcon at least)? If so, I
> > have a board that does this with certain cache settings made in the BIOS.
> > It's a 430HX chipset with two Pentium MMX 200s installed, *ancient* BIOS.
>  
> I'm using BIOS dated 19/07/2000, last week it was latest BIOS on Gigabyte
> site for 6VXD7 (two PIII/800). I did not looked for updates today yet.
> 
> I tried to change C2P Concurrency & Master (en/dis), AGP Mode (1x/2x/4x),
> Power mgmt - Display Activity (monitor/ignore), PNP OS (yes/no)
> (24 combinations total), but any combination dies if there are read
> accesses to videoram during startup. Today I finally digged out some 
> old ISA VGA (Realtek), plugged it in and - it dies too. So it does not 
> depend on bus type.

Okay. Mine, as far as I can tell, only depends on the L2 cache being set
to '64MB' instead of '512MB' in the field 'L2 Cache Cacheable Size' under
'Chipset Features Setup' on my BIOS. This is unfortunately the latest BIOS
for this motherboard available. It's a TD5TH version 1.1

Hmmmm. Have you tried booting with an hercmono (if you can get your paws
on one, that is)?.


Right after 'Freeing unused kernel memory...'
I get a kernel BUG at buffer.c:821 with this setting at 256MB, -test12
without fbcon. With fbcon it would appear to switch video mode and
freeze with a black screen with cursor at the bottom, at that point.

And then I get an oops dump in the swapper task. I'll try decoding it in a
little while, since I'll have to manually input it.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
