Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTIIIzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 04:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263477AbTIIIzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 04:55:36 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:22506 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263453AbTIIIzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 04:55:35 -0400
Date: Tue, 9 Sep 2003 10:54:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       cheapisp@sensewave.com,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: hi-res fb console with 2.6.0-testX ?
In-Reply-To: <20030908223814.GA4495@vana.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0309091005370.3617-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Petr Vandrovec wrote:
> On Mon, Sep 08, 2003 at 10:57:34PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 8 Sep 2003, Petr Vandrovec wrote:
> > > And whole fb subsystem changed semantic, so do not build both
> > > vesafb & matroxfb into the kernel - either one or another, or
> > > you'll be definitely surprised what will happen (and I'm almost
> > > sure that blank screen is not what you want).
> > 
> > What's wrong with the resource system that prevents this from working?
> 
> vesafb ignore failures... for framebuffer it just prints warning only, and
> for 0x3C0 region it just completely ignores warning (due to vgacon
> clash). But it should not be serious, user should just get console 
> on matroxfb, and vesafb on /dev/fb1 doing nothing.

OK.

> Main thing which prevents this from working as users expects is that
> modular fbdevs cannot be used by fbcon. So people cannot create
> initrd scripts which load proper fbdev driver anymore, after detecting
> hardware and making sure that hardware & user wishes & driver are
> compatible. They now have to build fbdevs to the kernel, and hope for
> the best...

Ugh, didn't know that...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


