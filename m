Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315531AbSECBjy>; Thu, 2 May 2002 21:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSECBjx>; Thu, 2 May 2002 21:39:53 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:16656 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315531AbSECBjw>; Thu, 2 May 2002 21:39:52 -0400
Date: Fri, 3 May 2002 03:39:41 +0200
From: tomas szepe <kala@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020503013941.GH10617@louise.pinerecords.com>
In-Reply-To: <Pine.LNX.4.40.0205022117350.17239-100000@ccs.covici.com> <3319.1020389607@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 10 days, 16:19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >So what should it point to?  I have had more trouble when some Debian
> >package made it not a symlink and if I tried to compile something
> >which needed correct headers for the version I am using I get very
> >strange errors which are hard to diagnose.
> 
> Linus has spoken.  /usr/include/{linux,asm} must not be a symlink that
> points to kernel code that is updated.  glibc must contain the linux
> and asm files that were used to build glibc and those files must not
> change until you change glibc.  glibc must take a copy of the kernel
> headers at glibc build time or (much less desirable) it can symlink to
> a set of kernel headers that are guaranteed to never change.
> 
> Having glibc linking to some random set of kernel headers is a recipe
> for disaster.  kbuild 2.5 deliberately handles the asm symlink
> differently from the old kbuild system, to detect and correct broken
> installations.

Fair enough. I suggest, though, that you put a similar explanation
into kbuild 2.5 documentation.

T.

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
