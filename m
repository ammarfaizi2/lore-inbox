Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbTCGK7B>; Fri, 7 Mar 2003 05:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbTCGK6e>; Fri, 7 Mar 2003 05:58:34 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261505AbTCGK5U>;
	Fri, 7 Mar 2003 05:57:20 -0500
Date: Thu, 6 Mar 2003 20:58:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Norbert Kiesel <nkiesel@tbdnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.4.20
Message-ID: <20030306195812.GH2781@zaurus.ucw.cz>
References: <20030302121425.GA27040@defiant> <3E6247F7.8060301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6247F7.8060301@redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  
> > -	if (!urb->status & !acm->throttle)  {
> > +	if (!urb->status && !acm->throttle)  {
> >  		for (i = 0; i < urb->actual_length && !acm->throttle; i++) {

> To summarize, I'd probably not be amused if you would change any of my
> code which takes advantage of such programming finess.  I would probably
> have added appropriate comments to explain the code but nevertheless,
> replacing the more efficient code with some which is easier to
> understand should probably be considered on a case by case basis.

Actually I feel co-responsible for acm.c,
and this *is* typo. acm is for modems,
thats *not* performance critical, and certainly
not worth code obfuscation.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

