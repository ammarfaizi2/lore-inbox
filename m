Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUHFR25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUHFR25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUHFRS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:18:59 -0400
Received: from web14928.mail.yahoo.com ([216.136.225.87]:9836 "HELO
	web14928.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268199AbUHFRQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:16:42 -0400
Message-ID: <20040806171641.14189.qmail@web14928.mail.yahoo.com>
Date: Fri, 6 Aug 2004 10:16:41 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: DRM function pointer work..
To: Keith Whitwell <keith@tungstengraphics.com>, Ian Romanick <idr@us.ibm.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4113B7DC.6000000@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Keith Whitwell <keith@tungstengraphics.com> wrote:
> Ian Romanick wrote:
> > Jon Smirl wrote:
> > 
> >> The only case I see a problem is when drm-core is compiled into
> >> the kernel. Why don't we just change the Makefile to default to
> >> copying the CVS code into the kernel source tree and tell the 
> >> user to rebuild his kernel? 
> > 
> > 
> > I don't think that will fly with Joe-user that just wants to
> > upgrade his graphics driver.  The other problem case is if the 
> > user has two graphics cards in his system.  He wants to upgrade
> > the driver for one of them (or install a new driver for a new 
> > card), but the interface between the device-independent 
> > (in-kernel) layer and the device-dependent (in-kernel) layer 
> > has changed.

fbdev is in exactly this model and it isn't causing anyone problems.
The simple rule is that if you want to upgrade fbdev past the current
version you have to do it in entirety. You do that for fbdev but
pulling bk://fbdev.bkbits.net/. But Joe user doesn't do that, that is
something only developers do.

Distributions release new kernels all of the time. If Joe wants to
upgrade he graphics driver he should wait until we push it into the
kernel and it arrives via his distribution. If he really wants to be
bleeding edge he can copy the entirety of the DRM CVS into his kernel
tree. 

Linux doesn't have a stable driver binary interface. It isn't meant for
you to be able to upgrade one module while keeping the core and an
older module.

The key here is that distributions release new kernels at a rapid pace.
This is not X where we get a new release every five years. The standard
mechanism for upgrading device drivers in Linux is to add them to the
kernel and wait for a release.  If DRM uses that mechanism for
distribution we won't have problems.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
