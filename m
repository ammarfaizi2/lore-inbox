Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTHVSOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbTHVSOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:14:54 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:17669 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263158AbTHVSOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:14:53 -0400
Date: Fri, 22 Aug 2003 19:14:45 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
In-Reply-To: <Pine.LNX.4.44.0308220947010.3258-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0308221858370.19303-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > There's really no point in forcing in support for all kinds of
> > optional input devices unless CONFIG_EMBEDDED.
> 
> I disagree. We've had too many totally unnecessary bug-reports from 
> people, and it's just not worth it not having the keyboard and mouse 
> controller driver.
> 
> However, we can certainly improve on it, and the "select INPUT if VT" part 
> makes fine sense.

   One thing I like to ask is that you removed the if EMBEDDED | !X86 from 
VGA_CONSOLE. To my knowledge no one had problems with enabling vga console 
before the EMBEDDED changes. The reason I ask is because as it stands the 
configuration is forcing everyone on intel to enable the vga console. Even 
when you want to just run framebuffer console. Most newbie users will not 
know that they have to go back and enable "Embedded" support on a desktop 
machine just to disable vgacon. 
   This is important because on the intel platform people are moving to 
framebuffer console. Also it would not shock me to see in one or two 
generations graphics card not supporting VGA cores anymore. For example I 
have several newer graphics cards for intel with DVI ports instead of VGA.
Once the market is flooded with DVI monitors and graphics cards there is no
need for VGA core support anymore.

