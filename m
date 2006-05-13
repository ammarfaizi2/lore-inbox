Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWEMUoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWEMUoL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWEMUoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 16:44:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26603 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751213AbWEMUoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 16:44:10 -0400
Date: Sat, 13 May 2006 22:43:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       mochel@digitalimplant.org
Subject: Re: [PATCH/rfc] schedule /sys/device/.../power for removal
Message-ID: <20060513204322.GB585@elf.ucw.cz>
References: <20060512100544.GA29010@elf.ucw.cz> <20060512031151.76a9d226.akpm@osdl.org> <20060512101916.GC28232@elf.ucw.cz> <20060512032702.3591289f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512032702.3591289f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > index 421bcff..dfcfc47 100644
> > > > --- a/Documentation/feature-removal-schedule.txt
> > > > +++ b/Documentation/feature-removal-schedule.txt
> > > > @@ -6,6 +6,16 @@ be removed from this file.
> > > >  
> > > >  ---------------------------
> > > >  
> > > > +What:	/sys/device/.../power
> > > > +When:	July 2007
> > > > +Files:	
> > > > +Why:	Because it takes integers, and different userland applications
> > > > +	expect different numbers to mean different things.
> > > > +	(Pcmcia expect 2 for off, some other code expects 3 for off).
> > > > +Who:	Pavel Machek <pavel@suse.cz>
> > > > +
> > > > +---------------------------
> > > 
> > > What will be impacted by this?
> > 
> > Some obscure place PCMCIA utils, IIRC. There was one more user, but I
> > do not remember who it was. Plus there may be few people doing echo
> > manually.
> 
> What will it be replaced with, and how will we communicate the need to
> migrate to the various application developers?  We can't just rip it out
> next year and point at some obscure entry in a kernel file and say "but we
> told you".

Ok, we do not have replacement ready, yet. Would it be feasible to
include warning now so that people are warned as early as possible,
while we are working on replacement? Ok, maybe not...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
