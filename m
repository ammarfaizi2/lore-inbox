Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132771AbRDOR6L>; Sun, 15 Apr 2001 13:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132772AbRDOR6B>; Sun, 15 Apr 2001 13:58:01 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:65033 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132771AbRDOR5r>;
	Sun, 15 Apr 2001 13:57:47 -0400
Date: Sun, 15 Apr 2001 13:59:06 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CML2 1.1.0 bug and snailspeed
Message-ID: <20010415135906.A5501@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk> <002601c0c4fb$c7e54260$0201a8c0@home> <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk> <20010414135618.C10538@thyrsus.com> <5.0.2.1.2.20010415114319.00b13350@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.2.1.2.20010415114319.00b13350@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Sun, Apr 15, 2001 at 11:48:46AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk>:
> At 18:56 14/04/2001, Eric S. Raymond wrote:
> >Anton Altaparmakov <aia21@cus.cam.ac.uk>:
> > > I found a bug: In "Intel and compatible 80x86 processor options", "Intel
> > > and compatible 80x86 processor types" I press "y" on "Pentium Classic"
> > > option and it activates Penitum-III as well as Pentium Classic options at
> > > the same time!?! Tried to play around switching to something else and then
> > > onto Pentium Classic again and it enabled Pentium Classic and Pentium
> > > Pro/Celeron/Pentium II (NEW) this time! Something is very wrong here.
> >
> >Rules file bug, probably.  I'll investigate this afternoon.
> 
> Just to say that this bug still exists in CML2 1.1.1 but it is sometimes 
> hidden, i.e. you only see a "Y" on one of the options but when you select 
> another option, it sometimes says that TWO other options were set to "n" 
> implying that two options were Y before... I also still see random two 
> options being Y when playing with Pentium Classic selection (right now I 
> see Pentium Classic and Pentium-4 at the same time being Y on my screen)...

I can't reproduce this in 1.1.2.  Here's a ttyconfig run, after "v 2" to set
the verbose flag.

    Skip-to-query arrived at x86type
Intel and compatible 80x86 processor types may have these values:
 1: M386                            386
 2: M486                            486
 3: M586                            586/K5/5x86/6x86/6x86MX
 4: M586TSC                         Pentium Classic
 5: M586MMX                         Pentium MMX
 6: M686                            Pentium Pro/Celeron/Pentium II
 7: MPENTIUMIII                     Pentium-III
 8: MPENTIUM4                       Pentium-4
 9: MK6                             K6/K6-II/K6-III
10: MK7                             Athlon/Duron/K7
11: MCRUSOE                         Crusoe
12: MWINCHIPC6                      Winchip-C6
13: MWINCHIP2                       Winchip-2
14: MWINCHIP3D                      Winchip-2A/Winchip-3
15: MCYRIXIII                       CyrixIII/C3
x86type: Intel and compatible 80x86 processor types (M686): 4
User action on M586TSC.
    set_symbol_internal(M586TSC, y, None)
    bindsymbol(M586TSC, y, M586TSC)
    M586TSC=y
    set_symbol_internal(M386, n, M586TSC)
    Symbol M386 unchanged
    set_symbol_internal(M486, n, M586TSC)
    Symbol M486 unchanged
    set_symbol_internal(M586, n, M586TSC)
    Symbol M586 unchanged
    set_symbol_internal(M586MMX, n, M586TSC)
    Symbol M586MMX unchanged
    set_symbol_internal(M686, n, M586TSC)
    bindsymbol(M686, n, M586TSC)
    M686=n (deduced from M586TSC)
    set_symbol_internal(MPENTIUMIII, n, M586TSC)
    Symbol MPENTIUMIII unchanged
    set_symbol_internal(MPENTIUM4, n, M586TSC)
    Symbol MPENTIUM4 unchanged
    set_symbol_internal(MK6, n, M586TSC)
    Symbol MK6 unchanged
    set_symbol_internal(MK7, n, M586TSC)
    Symbol MK7 unchanged
    set_symbol_internal(MCRUSOE, n, M586TSC)
    Symbol MCRUSOE unchanged
    set_symbol_internal(MWINCHIPC6, n, M586TSC)
    Symbol MWINCHIPC6 unchanged
    set_symbol_internal(MWINCHIP2, n, M586TSC)
    Symbol MWINCHIP2 unchanged
    set_symbol_internal(MWINCHIP3D, n, M586TSC)
    Symbol MWINCHIP3D unchanged
    set_symbol_internal(MCYRIXIII, n, M586TSC)
    Symbol MCYRIXIII unchanged
    Unchilling...
M686=n (deduced from M586TSC)
    Committing new bindings.
Trit flag is now y
    Skip-to-query called from x86type
    is_visible(MICROCODE) called
    MICROCODE not visible, MICROCODE guard M686 is false
    is_visible(TOSHIBA) called
    Query of TOSHIBA *not* elided
    Skip-to-query arrived at TOSHIBA
TOSHIBA: Toshiba Laptop support < > (NEW)?: 

I'm going to ship 1.1.2 in a few hours.  Would you see if you can reproduce
it in your environment?  Perhaps it's some effect of reading in your
existing config.out.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

...the Federal Judiciary...an irresponsible body, working like gravity
by night and by day, gaining a little today and a little tomorrow, and
advancing its noiseless step like a thief over the field of
jurisdiction until all shall be usurped from the States; and the
government of all be consolidated into one.
