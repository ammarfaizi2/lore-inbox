Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132569AbRDAVhh>; Sun, 1 Apr 2001 17:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132568AbRDAVh2>; Sun, 1 Apr 2001 17:37:28 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:52742 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132574AbRDAVhL>;
	Sun, 1 Apr 2001 17:37:11 -0400
Date: Sun, 1 Apr 2001 23:35:53 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010401233553.A15813@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.31.0104010752420.736-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104010752420.736-100000@linux.local>; from jsimmons@linux-fbdev.org on Sun, Apr 01, 2001 at 07:54:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> >No, it's the Trident Cyber9525
> 
> Sorry. I only have a early driver for trident 9750 and 9850. Their is a
> gropup working on trident framebuffers.

Is it possible that "jump scroll" would provide more performance benefit
than an accelerated driver anyway?

Seeing as you bring up this topic of writing a 9525 driver.  It seems to
me rather wasteful that you (collectively linux framebuffer authors),
XFree86 and Berlin are all writing drivers for the same, hugely diverse
class of hardware, to support more or less the same ops on the hardware.

Isn't possible to pool the development effort of video drivers?  Doesn't
X require basically the same set of operations as the kernel?  I.e.,
initialise the card and video mode (usually the very complex part); do
some rendering ops (usually fairly simple).  Sure, X provides a few more
kinds of rendering op, but that part of the code is usually much simpler
and smaller than the initialisation code.

Sorry if this sounds insulting -- it isn't intended that way.  I don't
really know what is involved in writing video drivers.  All I am seeing
is an _apparent_ reinventing of a rather complex wheel, when it's hard
enough as it is to keep up with all the different cards.

thanks,
-- Jamie
