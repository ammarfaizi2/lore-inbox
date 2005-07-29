Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVG2UXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVG2UXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVG2UVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:21:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13698 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262763AbVG2UUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:20:39 -0400
Date: Fri, 29 Jul 2005 21:20:21 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
In-Reply-To: <9e47339105072814505b6fe4f8@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0507292119340.17988@pentafluge.infradead.org>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>  <42E8F0CD.6070500@gmail.com>
  <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be> 
 <9e473391050728092936794718@mail.gmail.com>  <9e47339105072811183ac0f008@mail.gmail.com>
  <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be> 
 <9e4733910507281315419c3c12@mail.gmail.com>  <9e47339105072813213db7cee4@mail.gmail.com>
  <9e47339105072813507c00687e@mail.gmail.com>  <Pine.LNX.4.62.0507282337410.29876@numbat.sonytel.be>
 <9e47339105072814505b6fe4f8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > No, bits_per_pixel can be (much) larger than the color map size. E.g. a simple
> > ARGB8888 directcolor mode has bits_per_pixel = 32 and color map size = 256.
> 
> So I have the bits_per_pixel attribute wrong in sysfs. It needs to be
> bits_per_color and then let the driver sort it out.  Otherwise there
> is no way to set ARGB8888 versus ARGB2101010. With bits per color you
> would set 8 or 10.

You would need bits_per_read, bit_per_green. This doesn't event count the 
other color spaces avaliable like YUV.

