Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWELKaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWELKaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 06:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWELKaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 06:30:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751068AbWELKaN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 06:30:13 -0400
Date: Fri, 12 May 2006 03:27:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       mochel@digitalimplant.org
Subject: Re: [PATCH/rfc] schedule /sys/device/.../power for removal
Message-Id: <20060512032702.3591289f.akpm@osdl.org>
In-Reply-To: <20060512101916.GC28232@elf.ucw.cz>
References: <20060512100544.GA29010@elf.ucw.cz>
	<20060512031151.76a9d226.akpm@osdl.org>
	<20060512101916.GC28232@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> On Pá 12-05-06 03:11:51, Andrew Morton wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > It is very ugly, and we really should use names instead.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@suse.cz>
> > > 
> > > diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> > > index 421bcff..dfcfc47 100644
> > > --- a/Documentation/feature-removal-schedule.txt
> > > +++ b/Documentation/feature-removal-schedule.txt
> > > @@ -6,6 +6,16 @@ be removed from this file.
> > >  
> > >  ---------------------------
> > >  
> > > +What:	/sys/device/.../power
> > > +When:	July 2007
> > > +Files:	
> > > +Why:	Because it takes integers, and different userland applications
> > > +	expect different numbers to mean different things.
> > > +	(Pcmcia expect 2 for off, some other code expects 3 for off).
> > > +Who:	Pavel Machek <pavel@suse.cz>
> > > +
> > > +---------------------------
> > 
> > What will be impacted by this?
> 
> Some obscure place PCMCIA utils, IIRC. There was one more user, but I
> do not remember who it was. Plus there may be few people doing echo
> manually.

What will it be replaced with, and how will we communicate the need to
migrate to the various application developers?  We can't just rip it out
next year and point at some obscure entry in a kernel file and say "but we
told you".

Some five-times-per-reboot printk which tells people they should be using
/sys/device/.../whatever-it-will-be-called might be appropriate.
