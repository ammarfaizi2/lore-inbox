Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbTBETGZ>; Wed, 5 Feb 2003 14:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTBETGY>; Wed, 5 Feb 2003 14:06:24 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:7686 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S263794AbTBETGW>; Wed, 5 Feb 2003 14:06:22 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 14:23:53(EST) on February 05, 2003
X-HELO-From: rohan.arnor.net
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: Re: [Linux-fbdev-devel] Re: New logo code (fwd)
From: Torrey Hoffman <thoffman@arnor.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0302051336170.16681-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0302051336170.16681-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Feb 2003 11:17:57 -0800
Message-Id: <1044472678.1321.388.camel@rohan.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Sun, 12 Jan 2003, Geert Uytterhoeven wrote:
> > > The current logo code is messy, complex, and inflexible. So I decided to
> > > rewrite it. My goals were:
[ good list ]

This is wonderful.  I (and some co-conspirators) started a similar
project, and put up patches at www.arnor.net/linuxlogo . But yours is up
to date, and ours is not (I was waiting until the framebuffer rewrite
was done, and then I didn't have time to catch up).  

It would be great if your patch was merged.  If I may offer some
suggestions... well, feature requests :-)

It would also be nice to have an option to turn off the blinking cursor
on the framebuffer.  With a full-screen boot logo as used on embedded
systems, even with a serial console or console on tty2, you still get
the blinking cursor in the top corner of the screen. (at least in 2.4.x)

Other options that might be useful, but less important: 
- Single logo option for SMP
- A "no logo" option, while still including framebuffer support
- Logo positioning (centered horizontally, vertically, both)
- Background and foreground text color options.  

A combination of these features would make it possible to do a smaller
logo (say, 256 x 128) centered on the screen with a matching background
color that would make it look like a full-screen logo, while not
bloating the kernel image much.

Also, some simple documentation that would help beginners do a
full-screen boot logo with the console on tty2 or serial should be
included with the kernel.  Lots of people want to use Linux on
"embedded" PC-based systems like kiosks, or just do this for fun on
their home computers, and doing this is confusing for beginners.

If you like, I would be happy to write documentation like this or help
in other ways.

I hope there is little resistance to merging a patch like this.  If
anyone doubts the need, I can only say that despite our patches not
being kept up to date regularly, I get a lot of email about them.  Also,
there are patches by other people to do things like this, some better
than others.  Despite the hassle of finding and applying these patches,
people want the feature badly enough to make the effort.  I see a lot
more desire for this feature than for many other worthwhile things that
are merged into the kernel...

Torrey Hoffman
thoffman@arnor.net


On Wed, 2003-02-05 at 04:37, Geert Uytterhoeven wrote:
> On Tue, 28 Jan 2003, Geert Uytterhoeven wrote:
> > On Sun, 12 Jan 2003, Geert Uytterhoeven wrote:
> > > The current logo code is messy, complex, and inflexible. So I decided to
> > > rewrite it. My goals were:
> > >   - Logos must be accessible easily by an image editor (currently: hex C source
> > >     data must be converted to another format first)
> > >   - Logos must be stored in ASCII-form in the source tree
> > >   - Support arbitrary logo sizes (currently: fixed 80x80)
> > >   - Allow the logo to be selected statically (at compile time) and/or
> > >     dynamically (at run-time, based on machine type) (currently: at compile
> > >     time only).
> > >   - Allow simple adition of new logos
> > >   - Support grayscale logos (not used yet)
> > > 
> > > The patch achieves all of these. Logos are stored in ASCII PNM format in
> > > drivers/video/logo/, and automatically converted to hex C source arrays using
> > > scripts/pnmtologo. I chose ASCII PNM because (a) it's ASCII, (b) it's very
> > > simple to parse without an external library (XPM is more difficult to parse),
> > > and (c) it can be handled by many image manipulation programs.


