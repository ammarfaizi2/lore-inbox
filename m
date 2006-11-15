Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWKODKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWKODKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 22:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWKODKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 22:10:55 -0500
Received: from mail.enter.net ([216.193.128.40]:15802 "EHLO mmail.enter.net")
	by vger.kernel.org with ESMTP id S932490AbWKODKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 22:10:54 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Tue, 14 Nov 2006 22:10:50 -0500
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
References: <200611150059.kAF0xBTl009796@hera.kernel.org> <Pine.LNX.4.64.0611141747490.3349@woody.osdl.org> <455A7E21.7020701@garzik.org>
In-Reply-To: <455A7E21.7020701@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611142210.51162.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 21:40, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > On Tue, 14 Nov 2006, Jeff Garzik wrote:
> >> :(  Like AHCI, PCI MSI has -always- worked wonderfully for HD audio
> >> : AFAIK.
> >
> > That "AFAIK" is shorthand for "As Far As I haven't read any of the
> > bug-reports but Know", right?
>
> None of the bug reports indicate Intel, thus following the well
> established pattern of "it works great on Intel, but not elsewhere"

Since when does INTEL make policy about Linux?
It'd be better to just follow Linus' suggestion and *NOT* use it.

> >> Is a whitelist patch forthcoming?
> >
> > Probably not. The advantages of MSI aren't all that obvious, and the
> > disadvantages seem to be that it just doesn't work all that well for some
> > people.
> >
> > The fact that it works for MOST people has absolutely zero relevance.
> > We've had too many frigging patches that have apparently been of the
> > "this works for me, I don't care if some other motherboard has problems"
> > kind.
> >
> > See for example:
> >
> > 	http://lkml.org/lkml/2006/10/7/164
> >
> > and yes, that HDA MSI _does_ seem to be causing problems.
>
> But not on Intel, hence the obvious whitelist question.

AFAICT that is the problem. You are fixated on the fact that MSI for the Intel 
HD Audio works on INTEL motherboards. Pardon the language but - BIG FUCKING 
SURPRISE THERE! The systems I'm running right now might be Intel chipset 
boards, but that is simply a fluke. (They were given to me)

As a simple fact the only reason I see Linux users moving to systems with 
Intel chipsets is that Intel is actually making a lot of its driver code open 
source. Other than that... Well, let me just point out that not one of the 
Linux users I personally know have a system with an Intel chipset.

> > So don't blather about "MSI never causes problems". It's broken. Please
> > stop living in denial.
> > 
> > When somebody can actually say what the huge advantages to MSI are that
> > it's worth using when
> >
> >  (a) several motherboards are apparently known broken
>
> several non-Intel motherboards

Again you focus on Intel. Give it up already. You've proved that you have no 
real argument *FOR* having MSI in the driver.

> >  (b) microsoft apparently is of the same opinion and _also_ doesn't use
> > it
>
> Yeah well, that's sage advice only when it's sage advice.  MS lags us by
> years.  We do some bleeding, on the bleeding edge.

and is light years ahead in some parts. Have you seen the "usermode driver" 
system released as part of Vista and as a patch for XP? I, personally, cannot 
see how it could work or be secure while doing so, but it does have an 
advantage... Namely that a driver cannot bring the kernel down.

That Linux is ahead of Windows in a lot of cases is due more to the fact that 
it is extremely easy to get new technology implemented and working in Linux 
(and accepted into the kernel) than it is for the Windows. (Due more to the 
*MASSIVE* size of the windows code base and the fact that its a closed 
corporate project than anything)

But anyway...

> >  (c) the old non-MSI code works fine
> >
> >  (d) there is apparently no fool-proof way to tell when it works and when
> >      it doesn't.
> >
> > then please holler. Btw, I'm not even _interested_ in any advantages
> > unless you also have a solution for (d). Not a "it should work". I want
> > to hear something that is _guaranteed_ to work.
>
> if (intel) ...

Again crowing about how something works on ONE (1) (Uno, Eins, Un, Ichi) 
platform. A single working platform is no reason to complicate code with a 
whitelist.

>
> That has a track record of working.
>
> It's nice not to have to deal with shared interrupts.
>
> 	Jeff

Yes, I'm sure it is. But until it starts working on more than one platform 
it'd be stupid to add the code for a whitelist. Be easier to just *OFFER* MSI 
to people as a build option.  Then the people who *KNOW* it won't fubar their 
system can activate it.

(BTW, as Linus pointed out, MSI isn't really needed until you get to a system 
so large it has someone (or someones) there whose sole job is to make sure 
that the best and fastest ways of doing things are used and are fully 
functional)

DRH
