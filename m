Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUBZAUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUBZAUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:20:32 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:9479 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261490AbUBZAUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:20:24 -0500
Date: Thu, 26 Feb 2004 00:20:20 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <1077752759.22397.62.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402260014130.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >    I think this is a bad idea. This has been tried before. In the 
> > opensource community there is no such a thing as a standard library. 
> 
> On the other hand, things like dbus are low-level and slowly getting
> used by everyone... we also have the libc :)

Well now that we have one input api that can happen. Of course with 
graphics its much more diverse with what you can do. That is one of the 
reasons for so many graphics libraries. It would be really hard to write
a one size fits all library when it comes to graphics.

> >     The kernel really needs to be the only state machine for the hardware. 
> > Library developers will usually use the kernel standard interfaces. 
> 
> I don't fully agree. The kernel will do the actual HW banging, but
> we want things like EDID overrides per monitor models, persistent
> configuration saved to storage etc... all of that beeing pretty
> nasty to do in the kernel.

By state machine I mean the physical hardware state. If it's hardware 
access then it should be in the kernel. Note I'm refering to mode setting 
not acceleration. Now EDID overrides per monitor model and saving the 
state to disk is different. That should be userland. 

> I have mixed feeling on that. Keith Packard seem to prefer the library
> approach. I don't know for sure what Linus prefers here. Currently, I
> feel we are trying to do too much in the kernel, and that will become
> increasingly painful to manage as we get multiple head & geometry stuff
> getting in the picture.

I think we are fine for whats in the kernel. As for multiple head and 
geometry stuff its not that hard if done right. I have been using 
multi-head systems for years. I have multip desktop systems for years!!!



