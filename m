Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWE0QYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWE0QYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 12:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWE0QYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 12:24:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43271 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964873AbWE0QYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 12:24:42 -0400
Date: Fri, 26 May 2006 17:53:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Dave Airlie <airlied@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060526175321.GB3361@ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605240017.45039.dhazelton@enter.net> <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com> <200605240130.14879.dhazelton@enter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605240130.14879.dhazelton@enter.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Step 1: add a layer between fbdev and DRM so that they can see each other.
> >
> > Do *NOT* merge fbdev and DRM this is the "wrong answer". They may end
> > up merged but firstly let them at least become away of each others
> > existence, perhaps a lowerlayer driver that handles PCI functionality.
> > All other Step 1s are belong to us.
> 
> Okay. This won't be simple, won't be pretty, but I should be able to handle 
> it. The problem then becomes: What exactly should this system do? A layer 
> that sits on top of the PCI/AGP stuff and mediates it for DRM/fbdev? Isn't 
> easy, isn't simple but I think it is possible.
> 
> Any other option though, would seem to require rebuilding a good deal of both 
> DRM and fbdev, if not replacing the driver model, because of difficulties you 
> have previously pointed out.
> 
> If DRM makes use of the lower-level driver, and so does fbdev, then it's 
> likely possible that the system can provide the information needed to allow 
> the kernel to composite error messages onto the framebuffer.
> 
> And, really, if there is a common PCI layer beneath the two graphics systems, 
> they could potentially have some interaction... though to retain the capacity 
> to compile DRM or fbdev out of the kernel there is no way that one could 
> depend on the other. Having them intercommunicate, it seems, would require a 
> third mechanism. Any pointers?

Well, if drm and fbdev become interdependend while cleaning up... I do
not think it is too big problem.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
