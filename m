Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTIHWic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTIHWib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:38:31 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:52096 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263631AbTIHWiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:38:25 -0400
Date: Tue, 9 Sep 2003 00:38:14 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       cheapisp@sensewave.com,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: hi-res fb console with 2.6.0-testX ?
Message-ID: <20030908223814.GA4495@vana.vc.cvut.cz>
References: <C71CD161531@vcnet.vc.cvut.cz> <Pine.GSO.4.21.0309082255570.3273-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309082255570.3273-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 10:57:34PM +0200, Geert Uytterhoeven wrote:
> On Mon, 8 Sep 2003, Petr Vandrovec wrote:
> 
> > And whole fb subsystem changed semantic, so do not build both
> > vesafb & matroxfb into the kernel - either one or another, or
> > you'll be definitely surprised what will happen (and I'm almost
> > sure that blank screen is not what you want).
> 
> What's wrong with the resource system that prevents this from working?

vesafb ignore failures... for framebuffer it just prints warning only, and
for 0x3C0 region it just completely ignores warning (due to vgacon
clash). But it should not be serious, user should just get console 
on matroxfb, and vesafb on /dev/fb1 doing nothing.

Main thing which prevents this from working as users expects is that
modular fbdevs cannot be used by fbcon. So people cannot create
initrd scripts which load proper fbdev driver anymore, after detecting
hardware and making sure that hardware & user wishes & driver are
compatible. They now have to build fbdevs to the kernel, and hope for
the best...
					Best regards,
						Petr Vandrovec

