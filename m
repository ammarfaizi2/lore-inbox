Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314338AbSEBKjC>; Thu, 2 May 2002 06:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSEBKjB>; Thu, 2 May 2002 06:39:01 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:38919 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314338AbSEBKjB>; Thu, 2 May 2002 06:39:01 -0400
Date: Thu, 2 May 2002 12:38:10 +0200
From: tomas szepe <kala@pinerecords.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020502103810.GA7937@louise.pinerecords.com>
In-Reply-To: <20507.1020263013@ocs3.intra.ocs.com.au> <200205021014.g42AEmX06448@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 10 days, 5:06)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
> > It is faster, better documented, easier to write build rules in, has
> > better install facilities, allows separate source and object trees, can
> > do concurrent builds from the same source tree and is significantly
> > more accurate than the existing kernel build system.
> 
> I never used kbuild 2.5 (sorry Keith), but I am tired of
> 'make mrproper' bug in existing kernel build system.
> Whenever my new kernel does not boot, I have to do
> full build just to make sure I wasn't bitten
> by it again.
> 
> I gather there is no such bug in kbuild 2.5.
> That's good.

Yeah, I have to say, kbuild 2.5 is definitely a nice thing..
Looking fw to seeing it included in mainline.

Btw, Keith, how's the bug (if it is a bug at all) w/ CONFIG_MODVERSIONS?
Whenever I built a kernel with it set using kbuild 2.5 everything went fine
up to the moment I tried to load a module into the new kernel -- not one would
actually work, complaining about unresolved symbols (at the same time, though,
depmod -ae had nothing to report). Since I couldn't find any info on this
I concluded it might be that CONFIG_MODVERSIONS was considered obsolete and
as such would no longer be supported?

Another question I'd like to ask (soooorry :D) -- would there be a little
cunning target in Makefile-2.5 that'd create the asm-$arch symlink for me
in include/ like kbuild 2.4 does? Whenever I run "make -f Makefile-2.5 clean"
followed by "make -f Makefile-2.5 menuconfig" I get some serious whipping
from kbuild 2.5, cos the asm-$arch symlink gets deleted in the cleaning,
and I have to resurrect it by hand.

cheers,
t.

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
