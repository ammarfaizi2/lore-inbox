Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUBYX50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbUBYXyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:54:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:38583 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262550AbUBYXx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:53:27 -0500
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402252109030.24952-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402252109030.24952-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077752759.22397.62.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 10:46:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    I think this is a bad idea. This has been tried before. In the 
> opensource community there is no such a thing as a standard library. 

On the other hand, things like dbus are low-level and slowly getting
used by everyone... we also have the libc :)

>  ..../....

>     The kernel really needs to be the only state machine for the hardware. 
> Library developers will usually use the kernel standard interfaces. 

I don't fully agree. The kernel will do the actual HW banging, but
we want things like EDID overrides per monitor models, persistent
configuration saved to storage etc... all of that beeing pretty
nasty to do in the kernel.

> > Probably moving 
> > some of the higher level mode management out of the kernel driver
> > down to this userland library.
> 
> Bad idea.

I have mixed feeling on that. Keith Packard seem to prefer the library
approach. I don't know for sure what Linus prefers here. Currently, I
feel we are trying to do too much in the kernel, and that will become
increasingly painful to manage as we get multiple head & geometry stuff
getting in the picture.

Ben.


