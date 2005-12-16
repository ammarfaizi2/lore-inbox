Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVLPMk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVLPMk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVLPMk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:40:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50313 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932244AbVLPMk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:40:56 -0500
Date: Fri, 16 Dec 2005 13:40:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: documentation fixes
Message-ID: <20051216124039.GA9269@elf.ucw.cz>
References: <20051216105852.GJ8476@elf.ucw.cz> <1134735769.21103.1136.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134735769.21103.1136.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > @@ -328,4 +326,10 @@ init=/bin/bash, then swapon and starting
> >  usually does the trick. Then it is good idea to try with latest
> >  vanilla kernel.
> >  
> > +Q: How can RH ship a swsusp-supporting kernel with modular SATA
> > +drivers?
> >  
> > +A: Well, it can be done, load the drivers, then do echo into resume
> > +file from initrd. Be sure not to mount anything, not even read-only
> > +mount, or you are going to loose your filesystem same way Dave Jones
> > +did.
> 
> Quick solution to this - store the root filesystem's dev_t in the image
> header. If it's mounted when doing the sanity check, refuse to resume.

Yep, we could do that. But it is not 100% solution (you could have
some non-root filesystem mounted, and corrupt that one), anyway, and
I'd rather keep people from using it than complicating swsusp even
more. u-swsusp is going to make this obsolete, anyway, and can do any
sanity checks it wants to.
								Pavel
-- 
Thanks, Sharp!
