Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUBYCjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUBYCjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 21:39:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:7861 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262374AbUBYCjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 21:39:37 -0500
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040225021808.GB17390@guug.org>
References: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
	 <1077672591.978.49.camel@gaston>  <20040225021808.GB17390@guug.org>
Content-Type: text/plain
Message-Id: <1077676380.1129.55.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 13:33:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm, how does winxp and macosx get their respectives video modes,
> what is missing in fbdev for that? MacOSX always gives you valid modes
> including refresh rates per adaptor/monitor, WinXP always give you valid
> modes and valid refresh rates for the video card, you actually
> 'Apply' to test, most of the time it simply works.

They do the same as I described. As you wrote, it works most of the
time. That's the whole point. You submit a "proposed" configuration
and gets back something .... most of the time, you do get back what
you asked. But you _might_ not. In some cases, what will happen is
that the "other" head will be affected. For example, enabling
mirroring on a non-4.3 LCD laptop like a titanium powerbook while
having a 4.3 display (CRT) plugged on the second output will cause
the LCD to be resized to a 4.3 ratio in MacOS.
So in this case, you get _more_ than what you asked.

> Great! i think your idea is great, does that library will be xserver
> dependant or will be an independent lib so others projects like mine
> could benefit from it?  Any bits somewhere?  This alone could boom
> and revolutionize the graphics solutions for linux.  A step in the
> right direction for "World Domination" in the desktop field.

It's meant to be independant of anything else but the actual low
level driver model. Xserver would be one client, but others could
enter the game of course ;)

Ben.


