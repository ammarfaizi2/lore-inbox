Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269272AbUJQUyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269272AbUJQUyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJQUyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:54:18 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24989 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269272AbUJQUyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:54:02 -0400
Date: Sun, 17 Oct 2004 22:52:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thomas Weber <l_linux-kernel@mail2news.4t2.com>
cc: Tonnerre <tonnerre@thundrix.ch>, Josh Boyer <jdub@us.ibm.com>,
       root@chaos.analogic.com, gene.heskett@verizon.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <20041017201832.GA28859@4t2.com>
Message-ID: <Pine.GSO.4.61.0410172249400.27743@waterleaf.sonytel.be>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
 <1097843492.29988.6.camel@weaponx.rchland.ibm.com> <200410151153.08527.gene.heskett@verizon.net>
 <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
 <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
 <1097862366.29988.51.camel@weaponx.rchland.ibm.com> <20041015201147.GA23355@thundrix.ch>
 <20041017201832.GA28859@4t2.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004, Thomas Weber wrote:
> On Fri, Oct 15, 2004 at 10:11:47PM +0200, Tonnerre wrote:
> > What trusted computing revealed is that there is at least amongst some
> > companies  a desire  to be  able to  dictate what's  going on  on your
> > computer. Think Disney here.
> 
> 
> > 			    Tonnerre
> > 
> > PS. I did a module signing patch  some years ago. I did a framework. I
> >     did tests. I got scared of its power. All I say is, take care.
> 
> Think about companies deploing binary only drivers for their hardware.
> I guess they'd be happy to have a 'feature' like this in the kernel.
> We might end up with hardware companies deploying binary only signed 
> modules for the major distributions (with which they have deals).
> We might end up with weird patches from those companies to get their key
> into the kernel source in order to be able to load their signed module.
> 
> Once a module itself requires this feature in the kernel you don't have
> the choice of saying 'No' to this option of compile time and you can't
> simply revert this patch anymore as others have suggested.
> 
> This patch would give power to those who make binary distributions and
> (binary only) modules not to the admin who runs the system.
> Only allowing modules to be loaded from a secured area (read only
> device, signed 'container' of modules...) and leaving it to the
> admin which modules he puts into this area would address all the reasons
> for this patch without taking power away from the owner of the system.

Solution: the module loader refuses to load signed modules that are not GPLed?
I.e. a combination of MODULE_LICENSE() and signed modules.

Opens up interesting legal actions if the signature owner signs modules that
claim to be GPL, but aren't. Digital signatures are starting to become valid
signatures in many countries...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
