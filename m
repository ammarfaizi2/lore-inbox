Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319621AbSIMMuW>; Fri, 13 Sep 2002 08:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319628AbSIMMuW>; Fri, 13 Sep 2002 08:50:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28184 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S319621AbSIMMuV>; Fri, 13 Sep 2002 08:50:21 -0400
Date: Fri, 13 Sep 2002 14:53:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Samuel Flory <sflory@rackable.com>
Cc: Stephen Lord <lord@sgi.com>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020913125345.GO11605@dualathlon.random>
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com> <20020913002316.GG11605@dualathlon.random> <1031878070.1236.29.camel@snafu> <20020913005440.GJ11605@dualathlon.random> <3D8149F6.9060702@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8149F6.9060702@rackable.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 07:14:14PM -0700, Samuel Flory wrote:
> include/asm-i386/page.h:#define __VMALLOC_RESERVE       (128 << 20)
> include/asm/page.h:#define __VMALLOC_RESERVE    (128 << 20)
> 
> 
> Andrea Arcangeli wrote:
> 
> >On Thu, Sep 12, 2002 at 07:47:48PM -0500, Stephen Lord wrote:
> > 
> >
> >>How much memory is in the machine by the way? And Andrea, is the
> >>vmalloc space size reduced in the 3G user space configuration?
> >>   
> >>
> >
> >it's not reduced, it's the usual 128m.
> >
> >BTW, I forgot to say that to really take advantage of CONFIG_2G one
> >should increase __VMALLOC_RESERVE too, it's not directly in function of
> >the CONFIG_2G.
> >
> 
> So how much do you recommend increasing it?   Currently it's:
> include/asm-i386/page.h:#define __VMALLOC_RESERVE       (128 << 20)
> include/asm/page.h:#define __VMALLOC_RESERVE    (128 << 20)

you can try to compile with CONFIG_3G and to set __VMALLOC_RESERVE to
(512 << 20) and see if it helps. If it only happens a bit later then
it's most probably an address space leak, should be easy to track down
some debugging instrumentation.

Andrea
