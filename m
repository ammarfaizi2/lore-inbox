Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTBACtl>; Fri, 31 Jan 2003 21:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbTBACtl>; Fri, 31 Jan 2003 21:49:41 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:43240 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264699AbTBACtk>; Fri, 31 Jan 2003 21:49:40 -0500
Date: Fri, 31 Jan 2003 20:59:05 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support.
In-Reply-To: <Pine.LNX.4.44.0302010157530.6646-100000@serv>
Message-ID: <Pine.LNX.4.44.0301312055360.16486-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Feb 2003, Roman Zippel wrote:

> > > > missing 
> > > > EXPORT_SYMBOL()s tend to go unnoticed quite often otherwise.
> > > 
> > > The problem here is that we use System.map, it's not that difficult to 
> > > extract the exported symbols:
> > > objcopy -j .kstrtab -O binary vmlinux .export.tmp
> > > tr \\0 \\n < .export.tmp > Export.map
> > 
> > What you say is right (except that it misses symbols exported from 
> > modules), but I don't see what you mean the problem is?
> 
> See above, maybe I quoted to much. The other exported symbols are 
> already extracted by depmod, so it had exactly the information it needs 
> and would give more correct warnings.

The exported symbols can be extracted just as easily from System.map as 
from vmlinux, so I think I still don't understand your point. (And chances 
are higher that System.map is in /boot than an uncompressed vmlinux). 

depmod does give correct warnings, but only at modules install time, not 
at modules build time, that's what I was trying to say.

--Kai


