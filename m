Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131500AbRBNUs0>; Wed, 14 Feb 2001 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131533AbRBNUsQ>; Wed, 14 Feb 2001 15:48:16 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:56333 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S131500AbRBNUsE>;
	Wed, 14 Feb 2001 15:48:04 -0500
Subject: Re: Video drivers and the kernel
From: Brad Douglas <brad@neruo.com>
To: Albert "D." Cahalan <acahalan@cs.uml.edu>
Cc: Louis Garcia <louisg00@bellsouth.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200102140609.f1E69Bc346946@saturn.cs.uml.edu>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 14 Feb 2001 12:46:21 -0800
Mime-Version: 1.0
Message-Id: <20010214204811Z131500-513+6393@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Feb 2001 01:09:10 -0500, Albert D. Cahalan wrote:
> > I was wondering why video drivers are not part of the kernel like every 
> > other piece of hardware. I would think if video drivers were part of the 
> > kernel and had a nice API for X or any other windowing system, would not 
> > only improve performance but would allow competing windowing systems 
> > without having to develop drivers for each. Has anyone thought or 
> > rejected this idea.
> 
> Yes.
> 
> So then what, split X, with only the hardware access in the kernel?
> This can actually reduce performance, by a small or great amount
> depending on how it is done. Stability would improve a bit, assuming
> the new drivers have Linux quality rather than XFree86 quality.
> The gain is tiny, while the difficulty is large. At least we'd get
> a safe and reliable way to print an oops though.

This isn't an x86 world.  For most other architectures, there *must* be
a kernel driver.  Check out linux/drivers/video.  But what X is doing at
this point is taking over access to the video card and using it's own
driver.  So see, there needs to be no split of X.  I could also argue
that if video was moved into the kernel in that manner, stability would
decrease, but performance could be dramatically increased.

> Both options cause political troubles. Currently the X server is
> shared with OS/2 and other crummy systems. If the Linux kernel had
> serious video drivers for PC hardware, then driver support for the
> other operating systems would mostly go away. Linux would become
> a better desktop OS, at the expense of various crummy systems.

I find this to be a flawed argument.

> Both options cause more work for Linus. This totally kills the idea.
> See his past postings flaming the GGI/KGI developers.

I think GGI/KGI were overkill -- especially at the time.  But with the
advent of embedded systems, you simply just can't say "use X" anymore.
I believe that there needs to be basic 2D acceleration available in
kernel space.  They already have to be there for non-BIOS architectures,
so why not take advantage of them?

> If you ever write this, go ahead and throw in the rest. I mean the
> window manager, xterm, and a GDK system call even. My hardware can
> spare the memory, but CPU cycles are way too scarce. Clean design
> can go screw itself when it eats CPU time. Don't worry about being
> accepted into the main kernel, because that won't happen no matter
> what you do. Have fun hacking, and whip XFree86's ass.

Check out GTKFb and Embedded QT.  Whip XFree86's ass?  But the author
was talking about writing kernel drivers *for* Xfree86...  You are
correct in the fact that this will never happen.  But as far as video in
the kernel, you are wrong.

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org


