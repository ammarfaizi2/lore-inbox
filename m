Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRKGUPU>; Wed, 7 Nov 2001 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280824AbRKGUPL>; Wed, 7 Nov 2001 15:15:11 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:45840 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S274757AbRKGUOy>; Wed, 7 Nov 2001 15:14:54 -0500
Date: Wed, 7 Nov 2001 21:14:45 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jonas Diemer <diemer@gmx.de>
Cc: Linux Kermel ML <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686 timer bugfix incomplete
Message-ID: <20011107211445.A2286@suse.cz>
In-Reply-To: <20011107125012.6b1fbdc3.diemer@gmx.de> <E161RcS-0003x8-00@the-village.bc.nu> <20011107202546.A1939@suse.cz> <20011107204800.70b91985.diemer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107204800.70b91985.diemer@gmx.de>; from diemer@gmx.de on Wed, Nov 07, 2001 at 08:48:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 08:48:00PM +0100, Jonas Diemer wrote:
> On Wed, 7 Nov 2001 20:25:46 +0100
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> ...
> > The bug #2 can trigger the test for #1, because the timer is read just
> > after the timer interrupt happens and thus the value is usually around
> > 11920, which, plus 256 is larger than 11920.
> > 
> 
> so why don't you simply add a new option to the config file, that says "work
> around Via 686a bug"? that way, only ppl who have the bug need the fix.
> 
> ...
> > Only timer.c and apic.c do proper locking.
> > 
> 
> well, but as I said, the workaround in arch/i386/kernel/time.c is incomplete, at
> least in linus' kernel tree!
> 
> > The problem is how to work around the bugs 1) and 2) reliably and
> > without too much performance impact. I haven't found a feasible way to
> > do that yet.
> 
> well, just use the option described above. that way, ppl that need the fix can
> choose to use it (at a cost of performance), others simply don't need checking.
> 
> -jonas
> 
> PS: CC me in your answers plz, I am not subscribed to the list.

The VIA bug isn't a problem: The fix doesn't cause performance problems
to people unaffected by the bug, it just prints an annoying message to
people who see it triggered by bug #2 (Neptune).

The Neptune bug (which seems much more widespread than expected) is a
much larger problem - it's hard to detect without performance
degradation and currently it isn't known which chipsets are affected. It
is known that Intel Mercury and Intel Neptune (old P6 chipsets) are. But
how about others ... ?

-- 
Vojtech Pavlik
SuSE Labs
