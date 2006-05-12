Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWELKT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWELKT6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWELKT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:19:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52161 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751138AbWELKT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:19:57 -0400
Date: Fri, 12 May 2006 12:19:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       mochel@digitalimplant.org
Subject: Re: [PATCH/rfc] schedule /sys/device/.../power for removal
Message-ID: <20060512101916.GC28232@elf.ucw.cz>
References: <20060512100544.GA29010@elf.ucw.cz> <20060512031151.76a9d226.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060512031151.76a9d226.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 12-05-06 03:11:51, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > It is very ugly, and we really should use names instead.
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > 
> > diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> > index 421bcff..dfcfc47 100644
> > --- a/Documentation/feature-removal-schedule.txt
> > +++ b/Documentation/feature-removal-schedule.txt
> > @@ -6,6 +6,16 @@ be removed from this file.
> >  
> >  ---------------------------
> >  
> > +What:	/sys/device/.../power
> > +When:	July 2007
> > +Files:	
> > +Why:	Because it takes integers, and different userland applications
> > +	expect different numbers to mean different things.
> > +	(Pcmcia expect 2 for off, some other code expects 3 for off).
> > +Who:	Pavel Machek <pavel@suse.cz>
> > +
> > +---------------------------
> 
> What will be impacted by this?

Some obscure place PCMCIA utils, IIRC. There was one more user, but I
do not remember who it was. Plus there may be few people doing echo
manually.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
