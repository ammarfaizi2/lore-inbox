Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUFSJ2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUFSJ2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 05:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbUFSJ2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 05:28:11 -0400
Received: from witte.sonytel.be ([80.88.33.193]:25080 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265305AbUFSJ2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 05:28:09 -0400
Date: Sat, 19 Jun 2004 11:28:00 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Jakub Bogusz <qboosh@pld-linux.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       pld-kernel@pld-linux.org
Subject: Re: [Linux-fbdev-devel] 2.6.7 fbcon: set_con2fb on current console
 = crash
In-Reply-To: <200406191413.44439.adaplas@hotpop.com>
Message-ID: <Pine.GSO.4.58.0406191127250.23356@waterleaf.sonytel.be>
References: <20040618215047.GA4723@satan.blackhosts> <200406191413.44439.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Antonino A. Daplas wrote:
> Thanks.  Actually there's still a critical flaw in the set_con2fbmap code.
> For one, con2fb_map is never initialized.  It's just fortunate that this
> array happens to be  filled with zeroes so con2fb_map[n] will always return
> zero and registered_fb[0] happens to contain a valid info.  So it works, by
> accident.

According to the C standard, global variables are initialized to zero, unless
specified otherwise.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
