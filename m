Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUH0WpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUH0WpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUH0Wm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:42:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:45710 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264726AbUH0W1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:27:30 -0400
Date: Sat, 28 Aug 2004 00:26:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Linus Torvalds <torvalds@osdl.org>, Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Craig Milo Rogers <rogers@isi.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <Pine.LNX.4.60.0408272241090.9310@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.GSO.4.58.0408280020170.15692@waterleaf.sonytel.be>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org>
 <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <20040827094346.B29407@infradead.org>
 <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales>
 <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org>
 <Pine.LNX.4.60.0408272225140.9310@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408272241090.9310@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Anton Altaparmakov wrote:
> On Fri, 27 Aug 2004, Anton Altaparmakov wrote:
> > On Fri, 27 Aug 2004, Linus Torvalds wrote:
> > > But Greg is right - we don't keep hooks that are there purely for binary
> > > drivers. If somebody wants a binary driver, it had better be a whole
> > > independent thing - and it won't be distributed with the kernel.
> >
> > So how come we allow drivers which load binary firmware into the kernel?
> > And there are plenty of them...
> >
> > There isn't very much difference between binary firmware and the binary
> > module in this case.  Lets see what each of these does:
> >
> > - binary firmware: protects the intellectual rights of the people who
> > designed the chips by not showing anyone how they work by not showing the
> > original program code that drives the chips
> >
> > - binary module at hand: protects the intellectual rights of the people
> > who designed the chips by not showing anyone how they work by not
> > showing the original program code that drives the extended functionality
> > of the chips
> >
> > Sound simillar?
> >
> > IMHO they are identical except that the firmware is downloaded to the
> > hardware and executed by a different cpu while the binary module is
> > executed by the host cpu.
>
> I was a bit fast, there is the issue of different arhitectures for the
> host cpu but if the producers of the binary code care they would produce
> the appropriate binary code for each architecture.  I do not know if this
> is done in this case or not but it certainly is doable...

Not just the different architectures: also different CONFIG options (e.g. SMP
vs. UP).

Open Source drivers with binary firmware are `automatically'[*] supported on
whatever Linux kernel you want.

Binary-only drivers are supported on one architecture, for one specific kernel
version, for one combination of config options.

Although Open Source firmware would be very nice, hardware + firmware can more
or less be considered equivalent to ordinary hardware, i.e. the manufacturer
_could_ have done everything in hardware. That's similar to CPUs with hardwired
logic and CPUs with (programmable) microcode. The firmware has the advantage
that you can fix `hardware' bugs without running a new generation of the actual
hardware.

Gr{oetje,eeting}s,

						Geert

[*] Within reasonable constraints.

P.S. Perhaps I sound a bit more permissive than usual, but it's getting late
     ;-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
