Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318733AbSH1GRM>; Wed, 28 Aug 2002 02:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318734AbSH1GRM>; Wed, 28 Aug 2002 02:17:12 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:31934 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S318733AbSH1GRL>; Wed, 28 Aug 2002 02:17:11 -0400
Date: Tue, 27 Aug 2002 23:15:24 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Bill Currie <bill@taniwha.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: radeonfb compile errors in 2.5.32
In-Reply-To: <20020827215710.GA6905@taniwha.org>
Message-ID: <Pine.LNX.4.33.0208272313580.2973-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is with radeonfb compiled into the kernel. I'm not on the list, so please
> CC any replies to me.
>
> radeonfb.c:605: unknown field `fb_get_fix' specified in initializer
> radeonfb.c:605: warning: initialization from incompatible pointer type
> radeonfb.c:606: unknown field `fb_get_var' specified in initializer
> radeonfb.c:606: warning: initialization from incompatible pointer type
> radeonfb.c: In function `radeon_set_dispsw':
> radeonfb.c:1385: structure has no member named `type'
> radeonfb.c:1386: structure has no member named `type_aux'
> radeonfb.c:1387: structure has no member named `ypanstep'
> radeonfb.c:1388: structure has no member named `ywrapstep'
> radeonfb.c:1397: structure has no member named `visual'
> radeonfb.c:1398: structure has no member named `line_length'
> [snip repeats]
> radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
> radeonfb.c:598: warning: `radeon_read_OF' declared `static' but never defined
> radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but not used
> make[2]: *** [radeonfb.o] Error 1
> make[1]: *** [video] Error 2
> make: *** [drivers] Error 2

This is normal. The framebuffer layer is moving to a new api. The next set
of changes will finish the port over to this new api. Unfortunely it will
break most drivers. It is up to the driver maintainters to update there
drivers.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net


