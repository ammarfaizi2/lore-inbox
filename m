Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbTAHMsG>; Wed, 8 Jan 2003 07:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267133AbTAHMsG>; Wed, 8 Jan 2003 07:48:06 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:10962 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267119AbTAHMsF>; Wed, 8 Jan 2003 07:48:05 -0500
Date: Wed, 8 Jan 2003 13:55:30 +0100
To: John Bradford <john@grabjohn.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       luther@dpt-info.u-strasbg.fr, geert@linux-m68k.org,
       jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] Re: rotation.
Message-ID: <20030108125530.GC11138@iliana>
References: <yw1xu1gj51ep.fsf@tiptop.e.kth.se> <200301081205.h08C5mPv000776@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301081205.h08C5mPv000776@darkstar.example.net>
User-Agent: Mutt/1.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 12:05:48PM +0000, John Bradford wrote:
> > > > > I'm about to implement rotation which is needed for devices
> > > > > like the ipaq.
> > > > > The question is do we flip the xres and yres values depending
> > > > > on the rotation or do we just alter the data that will be
> > > > > drawn to make the screen appear to rotate. How does hardware
> > > > > rotate view the x and y axis?  Are they rotated or does just
> > > > > the data get rotated?
> > > > 
> > > > Where are you going to implement the rotation? At the fbcon or
> > > > fbdev level? 
> > > > 
> > > > Fbcon has the advantage that it'll work for all frame buffer
> > > > devices.
> > > 
> > > But you could also provide driver hooks for the chips which have
> > > such a rotation feature included (don't know if such exist, but i
> > > suppose they do, or may in the future).
> 
> It would be nice to have an option to be able to do the rotation
> entirely in software - some desktop users might prefer to have a
> portait-orientated display, when their graphics card doesn't have any
> hardware rotation facilities at all.

Well, that is James plan. I suppose that for hardware that can do
hardware rotation, it will be faster to do it instead of having the
software do it though, and thus it would be nice to have a driver hook
or something.

This way, if rotation is asked, then if the driver supports hardware
rotation, do it, and if not, do it in software.

At first, no driver will support hardware rotation anyway, so it would
be done in software.

And then, you reuse the same stuff to drive a chinese console or
something such.

Friendly,

Sven Luther
