Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267293AbSLKUVS>; Wed, 11 Dec 2002 15:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267296AbSLKUVS>; Wed, 11 Dec 2002 15:21:18 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:30696 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267293AbSLKUVQ>; Wed, 11 Dec 2002 15:21:16 -0500
Date: Wed, 11 Dec 2002 14:28:53 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Jeff Garzik <jgarzik@pobox.com>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Changes doc update.
In-Reply-To: <20021211181337.GD2612@gtf.org>
Message-ID: <Pine.LNX.4.44.0212111421190.28286-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002, Jeff Garzik wrote:

> On Wed, Dec 11, 2002 at 06:07:19PM +0000, Dave Jones wrote:
> > On Wed, Dec 11, 2002 at 12:58:10PM -0500, Jeff Garzik wrote:
> >  > I think the coolest things (to me) of the new build system need to be
> >  > noted too,
> >  > 
> >  > - "make" is now the preferred target; it does <arch-zimage> and modules.
> >  > - "make -jN" is now the preferred parallel-make execution.  Do not
> >  >   bother to provide "MAKE=xxx".
> > 
> > Yup. Added. Thanks.
> > Something else that I've noticed (but not found documented) is that
> > make dep seems to be automagickly done somewhen. An explicit make dep
> > takes about a second, and doesn't seem to do much at all.
> 
> I would check with Kai on that... IIRC there _is_ a purpose to "make
> dep", creating some file that's needed before the build process begins.
> Maybe that's fixed now...

There's really only one reason why "make dep" is still there, i.e. the 
future of modversions isn't quite figured out yet. - When modversions was 
still working, "make dep" did regenerate the versioning checksums, it was 
run automatically the first time, but to rerun it, one had to manually do
"make dep".

Currently, it really isn't necessary to run "make dep" at all, but as I 
said, it's not impossible that this changes again.

When Rusty's plans w.r.t modversions work out, "make dep" should be 
history by 2.6, though.

Additional points to consider for davej's document:

- Try "make KBUILD_VERBOSE=0 <whatever target". If you like it,
  put KBUILD_VERBOSE=0 into your environment.
- "make kernel/mm.o" will build the named file, provided a
  corresponding source exists. This also works for (non-composite)
  modules.

--Kai

