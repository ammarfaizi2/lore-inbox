Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267607AbTAQQ2t>; Fri, 17 Jan 2003 11:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267608AbTAQQ2t>; Fri, 17 Jan 2003 11:28:49 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:60068 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267607AbTAQQ2s>; Fri, 17 Jan 2003 11:28:48 -0500
Date: Fri, 17 Jan 2003 10:36:54 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Anders Gustafsson <andersg@0x63.nu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
In-Reply-To: <Pine.GSO.4.21.0301171326040.8910-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0301171035120.15056-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Geert Uytterhoeven wrote:

> > Unfortunately, the Makefile doesn't really know about the Kconfig files, 
> > the "source drivers/whatever/Kconfig" commands are in Kconfig, and 
> > duplicating them into the Makefile would be rather error-prone.
> 
> What about learning `make depend' a bit Kconfig syntax?

"make depend" is basically gone.

> > Even if that was done, the Makefiles also cannot know about e.g. headers 
> > included into C files, so it'd die at that point. At some point I hacked a 
> > LD_PRELOAD library which would try to exec a "get" when open(2) fails, 
> > which fixes gcc, kconfig and whatnotsoever. I suppose a better solution is 
> > "checkout: get", though.
> 
> Isn't all of this in .depend?

In 2.5 things work differently, so no.

--Kai

