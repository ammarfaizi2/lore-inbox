Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbTLKOEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTLKOEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:04:12 -0500
Received: from witte.sonytel.be ([80.88.33.193]:49360 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264912AbTLKOEK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:04:10 -0500
Date: Thu, 11 Dec 2003 15:03:23 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rob Landley <rob@landley.net>
cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <200312110132.06286.rob@landley.net>
Message-ID: <Pine.GSO.4.21.0312111439350.7575-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Rob Landley wrote:
> On Wednesday 10 December 2003 10:34, Larry McVoy wrote:
> > On Wed, Dec 10, 2003 at 08:21:52AM -0800, Linus Torvalds wrote:
> > > There's a fundamental difference between "plugins" and "kernel modules":
> > > intent.
> >
> > Which is?  How is it that you can spend a page of text saying a judge
> > doesn't care about technicalities and then base the rest of your argument
> > on the distinction between a "plugin" and a "kernel module"?
> 
> Because there are distinctions that aren't technicalities?
> 
> Strange but true...

Let's take a fresh look, from a historical perspective...

We had a GPLed kernel with (lots of) GPLed drivers. Even too many drivers,
since a kernel with all drivers enabled is too large to fit in 640 KiB! (of
course we elitist m68k users didn't suffer from that limitation ;-)

So someone solved this problem and found a way to reduce the kernel image size
below the magical limit by moving driver code to `loadable kernel modules'. A
nice side-effect was that people (read: distributors) now no longer needed a
bloated kernel that took ages to start during device probe. They could provide
a small kernel instead, with separate driver modules for all possible hardware,
to be loaded at boot time or on demand.

Hence technically loadable kernel modules are just a work-around to allow
larger kernels, and all loadable kernel code should be treated the same as
in-kernel code. So they are clearly derived from the kernel.

Later people started to realize that:
  (a) They can build out-of-tree modules, i.e. drivers that can't even be built
      in,
  (b) They can build out-of-tree modules and make them non-GPL.

And (b) is where the problem started...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

