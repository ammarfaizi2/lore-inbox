Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265377AbSJRSDQ>; Fri, 18 Oct 2002 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265378AbSJRSDQ>; Fri, 18 Oct 2002 14:03:16 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:21719 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265377AbSJRSDN>; Fri, 18 Oct 2002 14:03:13 -0400
Date: Fri, 18 Oct 2002 11:02:35 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbdev changes.
In-Reply-To: <Pine.GSO.4.21.0210141020550.9580-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.33.0210181059450.10832-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > And what is meaning of image when mask is 1? For b&w cursors
> > we need 0, 1, transparent and inverse.
>
> Note that not all hardware supports inverse.

Hm. The best solution to this is support the flag but we need to know if
the hardware supports it. The best thing to do is use the a GETCURSOR
ioctl call that returns what we can do.

> And on some hardware the cursor palette is shared with the screen palette,
> that's why I had fb_fix_cursorinfo.crsr_color[12] in the original cursor API.

In this case the provided cursor function would use puedopalette in
fb_info then.

> Yes, it can be difficult to find a _good_ API ;-)

We can but we need to provide a way to say we can't do that.

