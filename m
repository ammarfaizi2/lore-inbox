Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755475AbWKOC7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbWKOC7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 21:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755474AbWKOC7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 21:59:21 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:22514 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1755475AbWKOC7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 21:59:19 -0500
Date: Tue, 14 Nov 2006 18:58:49 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Message-Id: <20061114185849.c4da0d47.randy.dunlap@oracle.com>
In-Reply-To: <455A7E21.7020701@garzik.org>
References: <200611150059.kAF0xBTl009796@hera.kernel.org>
	<455A6EBF.7060200@garzik.org>
	<Pine.LNX.4.64.0611141747490.3349@woody.osdl.org>
	<455A7E21.7020701@garzik.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 21:40:33 -0500 Jeff Garzik wrote:

> Linus Torvalds wrote:
> > 
> > On Tue, 14 Nov 2006, Jeff Garzik wrote:
> >> :(  Like AHCI, PCI MSI has -always- worked wonderfully for HD audio AFAIK.
> > 
> > That "AFAIK" is shorthand for "As Far As I haven't read any of the 
> > bug-reports but Know", right?
> 
> None of the bug reports indicate Intel, thus following the well 
> established pattern of "it works great on Intel, but not elsewhere"
> 
> 
> >> Is a whitelist patch forthcoming?
> > 
> > Probably not. The advantages of MSI aren't all that obvious, and the 
> > disadvantages seem to be that it just doesn't work all that well for some 
> > people.
> > 
> > The fact that it works for MOST people has absolutely zero relevance. 
> > We've had too many frigging patches that have apparently been of the "this 
> > works for me, I don't care if some other motherboard has problems" kind.
> > 
> > See for example:
> > 
> > 	http://lkml.org/lkml/2006/10/7/164
> > 
> > and yes, that HDA MSI _does_ seem to be causing problems.
> 
> But not on Intel, hence the obvious whitelist question.
> 
> 
> > So don't blather about "MSI never causes problems". It's broken. Please 
> > stop living in denial.
> > 
> > When somebody can actually say what the huge advantages to MSI are that 
> > it's worth using when 
> > 
> >  (a) several motherboards are apparently known broken
> 
> several non-Intel motherboards
> 
> 
> >  (b) microsoft apparently is of the same opinion and _also_ doesn't use it
> 
> Yeah well, that's sage advice only when it's sage advice.  MS lags us by 
> years.  We do some bleeding, on the bleeding edge.
> 
> 
> >  (c) the old non-MSI code works fine
> > 
> >  (d) there is apparently no fool-proof way to tell when it works and when 
> >      it doesn't.
> > 
> > then please holler. Btw, I'm not even _interested_ in any advantages 
> > unless you also have a solution for (d). Not a "it should work". I want to 
> > hear something that is _guaranteed_ to work.
> 
> if (intel) ...
> 
> That has a track record of working.
> 
> It's nice not to have to deal with shared interrupts.

FWIW, I concur with it always working for me on my Intel motherboard and
Intel-based Lenovo ThinkPad for hdaudio, ethernet, and SATA/AHCI.

---
~Randy
