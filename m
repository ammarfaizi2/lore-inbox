Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281021AbRKGWWh>; Wed, 7 Nov 2001 17:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281022AbRKGWW1>; Wed, 7 Nov 2001 17:22:27 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:4168 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S281021AbRKGWWR>; Wed, 7 Nov 2001 17:22:17 -0500
Date: Thu, 8 Nov 2001 09:32:30 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jonas Diemer <diemer@gmx.de>,
        Linux Kermel ML <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686 timer bugfix incomplete
In-Reply-To: <20011107211445.A2286@suse.cz>
Message-ID: <Pine.LNX.4.05.10111080917140.19515-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Vojtech Pavlik wrote:

[...]
> On Wed, Nov 07, 2001 at 08:48:00PM +0100, Jonas Diemer wrote:
[...]
> > well, just use the option described above. that way, ppl that need the fix can
> > choose to use it (at a cost of performance), others simply don't need checking.
> > 
> > -jonas
> > 
> > PS: CC me in your answers plz, I am not subscribed to the list.
> 
> The VIA bug isn't a problem: The fix doesn't cause performance problems
> to people unaffected by the bug, it just prints an annoying message to
> people who see it triggered by bug #2 (Neptune).
[snip]

Maybe not performance problems, but my tired-but-otherwise-reliable
AcerNote-950C (which definitely does not have a VIA686a - it's a Pentium)
doesn't seem to like this VIA686a fix (but only sometimes {:-( ).

Prior to 2.2.19, on going to sleep due to low battery, I could reliably
wake it up.  with 2.2.19 (being where this fix entered 2.2) this isn't the
case - sometimes I just get the "probable bug" message, sometimes also a
diag re hda (sorry, can't quote right now) and on one occasion serious
file system corruption (OK, maybe it was a co-incidence, or maybe not).

Yes, I probably have a bug in the timer department, but I strongly suspect
that the fix for the 686a is not appropriate for my chipset.

If the current VIA686a "probable bug" fix is going to remain as default,
then I for one would like to see a knob to disable it.

For 2.2, I'm happy to have a go at making and alpha-testing a patch for a
kernel command-line switch to disable this - but I'd very much like to
hear from the custodians of consistency in such matters as to an
appropriate/best attribute=value to use for this.  Some sugestions:

	chips=novia686a
	via_hacks=no686a
	via_hacks=none
	timer=no686a

Regards,
Neale.

