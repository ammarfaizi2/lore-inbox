Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVBYUYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVBYUYA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 15:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVBYUYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 15:24:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46864 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261307AbVBYUXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 15:23:53 -0500
Date: Fri, 25 Feb 2005 20:23:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050225202349.C27842@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk> <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk> <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk> <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk> <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org>; from torvalds@osdl.org on Fri, Feb 25, 2005 at 11:59:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 11:59:01AM -0800, Linus Torvalds wrote:
> On Fri, 25 Feb 2005, Russell King wrote:
> > So, what's happening about this?
> 
> Btw, is there any real reason why the ARM _tools_ can't just be fixed? I 
> don't see why this isn't a tools bug?

It is a tools bug.  But the issue is that *all* versions of binutils
currently available which are kernel-capable (since the inclusion of
the kbuild .incbin requirement on binutils) have this bug, with the
exception of maybe CVS versions.

We can't say "you must use the current CVS binutils to build the
kernel" because that's not a sane toolchain base to build products
on.

I've been wanting to see a version of binutils released pretty damn
quick so I can say "kernel only builds with latest toolchain" but
I suspect even that's going to be seen as being unreasonable.

So, my only option is to ensure that the problem with current toolchains
*is* detectable, rather than having what appears to be a perfectly good
kernel built, which may appear to run fine for the most part, but may
randomly fail due to wrongly built assembly code.

And yes, the toolchain peoples point of view is "fix the kernel".

Sorry, I'm stuck between a rock and a hard place, much like everything
else I'm faced with at the moment... ARMv6 cache patch for example.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
