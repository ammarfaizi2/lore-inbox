Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272131AbTHNCTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 22:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272132AbTHNCTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 22:19:44 -0400
Received: from almesberger.net ([63.105.73.239]:5644 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S272131AbTHNCTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 22:19:41 -0400
Date: Wed, 13 Aug 2003 23:19:26 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Nufarul Alb <nufarul.alb@home.ro>
Cc: Jim Carter <jimc@math.ucla.edu>, linux-kernel@vger.kernel.org
Subject: Re: multibooting the linux kernel
Message-ID: <20030813231926.B8269@almesberger.net>
References: <3F396C04.90608@home.ro> <20030813072053.A25803@infradead.org> <3F3A2DB9.7030601@home.ro> <Pine.LNX.4.53.0308130904140.3016@xena.cft.ca.us> <3F3A9302.5000806@home.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3A9302.5000806@home.ro>; from nufarul.alb@home.ro on Wed, Aug 13, 2003 at 10:35:30PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nufarul Alb wrote:
> the use of initrd is a real pain in the butt.

It's mainly a packaging issue. So far, it seems that nobody has
written a useful set of generic tools to build an initrd. But
the ingredients are there.

> with multibooting GRUB 
> loads the modules into memory and the kernel can take them from there. 

A solution that depends on GRUB and that only works for
modules ? That's not so nice. What if a driver also needs some
setup script, a user-space demon, or has to download a non-GPL
firmware binary ?

If you envision a use where someone would load a set of drivers
from removable media to bring up the system, it would be more
flexible to allow for multiple initrds/initramfs, which then
contain whatever code or data is needed.

And please don't stop there, but also specify what these
additional file systems should contain (e.g. a script
"initializeme" in the top-level directory, or such).

> The MAIN THING  that a multiboot kernel will solve is the problem of 
> module portability. I think that the reason why hardware producers are 
> not making drivers for linux is that they have to make them open source 
> in order to be compiled by every user.

So we're just hallucinating all those binary-only drivers ? :-)

> With multibooting it become 
> possible to make a standard type of the main image of the kernel and all 
> the modules will be built for it.

A developer's dream - the immutable standard kernel with
internal data structures frozen for all eternity ;-))

> AND besides all that you can do many operations before mounting the 
> actual root like, for example, make a module that encapsulates a nice 
> boot animation,

Once kexec makes into the mainstream kernel, I'm sure we won't
have to wait long for such things to show up.

> a progress bar, show the services start in a nice 
> graphical way on top of the framebuffer.

That's entirely a user-space issue.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
