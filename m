Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264065AbTJ1SAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTJ1SAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:00:40 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:46607 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264065AbTJ1SAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:00:39 -0500
Date: Tue, 28 Oct 2003 18:00:38 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: Multiple drivers for same hardware:, was: DRM and pci_driver
 conversion
In-Reply-To: <Pine.LNX.4.44.0310232132410.4894-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0310281752390.5142-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Since they have to co-operate some way on the resources _anyway_, they'll 
> just need to work it out amongst themselves.
> 
> One common case is to have a "arbitration driver" that tends to do the
> actual low-level accesses and is one level of abstraction over the
> hardware (papers over trivial differences in hardware). An example of this
> would be the old-style ISA DMA infrastructure (now happily pretty much
> dead), where the "DMA driver" was just a trivial layer that had some basic
> allocation/deallocation and had somewhat nicer access routines than the
> raw IO accesses, but didn't do much more.

I already have thought ahead about this issue. That is why one of the 
major changes to the framebuffer layer was to seperate the driver data 
into struct fb_info and a struct xxx_par. The idea was the data in struct 
fb_info was for the framebuffer layer and the data in struct xxx_par could 
be shared with other interfaces like DRI. The par idea can be extended 
further and we could use a common structure between a low level text mode
console driver and a graphics driver. For example mdacon and hgafb. 



