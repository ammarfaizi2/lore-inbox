Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbTIHU6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTIHU6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:58:37 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:17066 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263601AbTIHU6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:58:35 -0400
Date: Mon, 8 Sep 2003 22:57:34 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       cheapisp@sensewave.com,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: hi-res fb console with 2.6.0-testX ?
In-Reply-To: <C71CD161531@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0309082255570.3273-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Petr Vandrovec wrote:
> On  7 Sep 03 at 22:58, Dave Jones wrote:
> > On Sun, Sep 07, 2003 at 09:51:51PM +0200, cheapisp@sensewave.com wrote:
> >  > The kernel command lines which work with vesafb and matroxfb in 2.4 do not 
> >  > work for me in 2.6.0-testX.                                                
> >  >                                    
> >  > kernel (hd0,0)/bz-2.6.0-t4mm3 root=/dev/hdc2 video=matrox:vesa:0x11A       
> >  > kernel (hd0,0)/bz-2.6.0-t4mm3 root=/dev/hdc2 vga=794                       
> > vga= seems to have changed semantics. (Which is a polite way of saying
> > "has regressed" IMO), this has been reported several times before, but
> > it doesn't seem to be too high on peoples 'must fix' list.
> > 
> >  > Doing fbset "vesa11A" causes the monitor to lose the sync.                 
> > 
> > last I looked, fbset needed updates for the changes in 2.6
> 
> video= changed sematic too. Now you have to do
> video=matroxfb:...., not video=matrox:....
> 
> And /dev/fb* changed semantic too, so forget about using fbset on your
> box.

I really like to see this fixed. IMHO fbcon should be build on top of fbdev,
not vice-versa.

> And whole fb subsystem changed semantic, so do not build both
> vesafb & matroxfb into the kernel - either one or another, or
> you'll be definitely surprised what will happen (and I'm almost
> sure that blank screen is not what you want).

What's wrong with the resource system that prevents this from working?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

