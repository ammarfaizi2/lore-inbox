Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVKXJnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVKXJnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVKXJnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:43:52 -0500
Received: from witte.sonytel.be ([80.88.33.193]:39633 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751341AbVKXJnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:43:52 -0500
Date: Thu, 24 Nov 2005 10:43:20 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: Console rotation problems
In-Reply-To: <43855DBA.1050302@gmail.com>
Message-ID: <Pine.LNX.4.62.0511241042360.6400@numbat.sonytel.be>
References: <1132793150.26560.357.camel@gaston>  <1132793556.26560.361.camel@gaston>
 <1132796831.26560.392.camel@gaston> <1132801542.26560.402.camel@gaston>
 <43855DBA.1050302@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005, Antonino A. Daplas wrote:
> Benjamin Herrenschmidt wrote:
> > Remove bogus usage of test/set_bit() from fbcon rotation code and just
> > manipulate the bits directly. This fixes an oops on powerpc among others
> > and should be faster. Seems to work fine on the G5 here.
> 
> Thanks, I reached a point when my head became muddled with bit 
> manipulations, so I used arch-specific bitops but complete forgot
> that they were atomic :-)

I haven't really looked at the rotation code, but I guess it can be optimized a
lot by using similar techniques like c2p (chunky-to-planar) conversions.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
