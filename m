Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270646AbUJUAwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270646AbUJUAwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270668AbUJUAwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:52:39 -0400
Received: from web40723.mail.yahoo.com ([66.218.92.61]:64849 "HELO
	web40723.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270646AbUJUAr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:47:27 -0400
Message-ID: <20041021004721.38359.qmail@web40723.mail.yahoo.com>
Date: Wed, 20 Oct 2004 17:47:21 -0700 (PDT)
From: Timothy Miller <theosib@yahoo.com>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1098318640l.25188l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- "J.A. Magallon" <jamagallon@able.es> wrote:

> 
> On 2004.10.21, Timothy Miller wrote:
> ...
> > 
> > When it comes to desktop applications, the FIRST thing you need is
> good
> > 2D acceleration.  In fact, that's really the ONLY thing. 
> OpenOffice
> > does not need to use OpenGL.  GNOME doesn't need to use OpenGL.  In
> > fact, for the most part, they don't bother.  There are some
> instances
> > where they use OpenGL, but most of what a workstation user does
> fits
> > squarely within all the functionality supplied by Xlib, which is
> > entirely 2D.
> > 
> 
> Have you looked at xorg-x11 recently ? IE, the Composite, Damage and
> Render extensions ?
> 
> OSX uses OpenGL because it is the API they have to access things like
> alpha blending, image scaling, and so on, so they can do those nice
> effects of transparencies, shadows, genie's and so on. At least until
> Panther. For me, it looks like the new Tiger implementation
> (CoreImage) is
> their own implementation of the OpenGL pixel pipeline, talking
> directly
> to drivers instead of using OpenGL as intermediary.
> 
> Probably desktop systems would not need the T&L part of 3D, but be
> sure
> they will need at least managing windows at different depths,
> blending them,
> anti-aliasing them an so on.
> 
> So, as I see it, for an appealing 2D card, you need to program a 2
> 1/2
> graphics engine, with really _fast_ alpha blending and antialiasing.
> You can only kill the matrix part. I do not know if you will be able
> to
> get rid completely of floating point, for those alpha mixes and
> assorted
> candy...


Alright.  Excellent points.  If I don't have to do any scaling or
rotation, alpha-blending won't be that big of a deal.  I already would
have to read the destination of applying a raster-op or a planemask, so
alpha-blend would become just another part of the merge at the end of
the pipeline.  

Of course, with only 8 significant bits, you could get noticable
cumulative round-off error.

As you start to add 3D features to the 2D pipeline, the point in
keeping them separate diminishes.


Oh, and there's antialiasing... now, sometimes, it just LOOKS like
antialiasing, like with the font server used by X11.  When it renders
characters, it produces an 8-bit grayscale bitmap which is
pre-antialiased, which you then have to color while rendering.  If you
want to do other things, then you get back into scaling, which is just
a special case of texture-mapping.



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
