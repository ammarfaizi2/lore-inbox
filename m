Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277102AbRJDQuP>; Thu, 4 Oct 2001 12:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277159AbRJDQuG>; Thu, 4 Oct 2001 12:50:06 -0400
Received: from www.transvirtual.com ([206.14.214.140]:18439 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S277103AbRJDQt7>; Thu, 4 Oct 2001 12:49:59 -0400
Date: Thu, 4 Oct 2001 09:49:49 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ricky Beam <jfbeam@bluetopia.net>,
        Andrew Morton <akpm@zip.com.au>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Huge console switching lags
In-Reply-To: <Pine.GSO.4.21.0110040937480.17814-100000@mullein.sonytel.be>
Message-ID: <Pine.LNX.4.10.10110040935440.32009-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > them. It draws pixel by pixel. Slow slow slow!!! I have developed a new
>             ^^^^^^^^^^^^^^^^^^^^^^^
> Where does it draw pixel by pixel?

Okay. Let me say most drivers don't take advantage of the graphics hardware 
to perform console operations. Instead they just draw directly to the
framebuffer which can be slow. 

> Yep. Vesafb started as a nice gimmick to show that it's possible, and turned
> out to be a solution for yet another
> we-don't-release-specs-to-OS/FS-people company.

I know. Same with OFfb.

> Euh, most fbcon-* drivers already do this. Grep for fb_write in e.g.
> drivers/video/fbcon-cfb8.c and count the byte accesses (=> 0).

Yep. The new code I developed came out the merging of all the fbcon-cfb*
drivers. 

