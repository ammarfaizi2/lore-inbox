Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUCANa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 08:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbUCANa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 08:30:28 -0500
Received: from post.tau.ac.il ([132.66.16.11]:44166 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S261257AbUCANa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 08:30:26 -0500
Date: Mon, 1 Mar 2004 14:34:36 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301123436.GA16691@pc-math-vis1>
Mail-Followup-To: Software suspend <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1ulUA-33w-3@gated-at.bofh.it> <20040229161721.GA16688@hell.org.pl> <20040229162317.GC283@elf.ucw.cz> <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th> <20040229213302.GA23719@luna.mooo.com> <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston> <20040301113528.GA21778@hell.org.pl> <1078140515.21578.76.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078140515.21578.76.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.5; VDF: 6.24.0.29; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 10:28:36PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2004-03-01 at 22:35, Karol Kozimor wrote:
> > Thus wrote Benjamin Herrenschmidt:
> > > > - that 2.4 style PM got depreciated and let die before the
> > > >    "new-driver-model" PM is workin
> > > Except that it never worked
> > > > - that perfectly good drivers were rewritten from scratch,
> > > >    but without functioning PM support
> > > Please, give names.
> > 
> > USB UHCI driver could be a fine example of a regression -- it could survive
> > suspend in 2.4 under certain conditions, this is no longer true for 2.6.
> 
> Well, it may have survived by mere luck... the fact is that 2.4 never
> had an infrastructure allowing anything remotely safe for
> suspend/resume.
> 
> > There's also a great deal of people, who can't resume when AGP is being 
> > used -- that is again a regression over 2.4.
> >
> > The above are major showstoppers for most laptop users that already got
> > used to stable and reliable swsusp and hence prefer to stick with 2.4.
> 
> There haven't been a regression in the AGP drivers themselves afaik.

The suspend/resume calls have been removed from the drm drivers and
returning them doesn't solve the resume problems (I guess either agp
isn't woken up properly or something is happening in the wrong order. I
haven't had time to investigate further). And I have a simple mach64
(rage mobility m1) card which is relatively easy to wake up since not
much needs to be done (the agp bus is via).

> 
> Ben.
> 
