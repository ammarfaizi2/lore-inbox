Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290301AbSAPAir>; Tue, 15 Jan 2002 19:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290300AbSAPAii>; Tue, 15 Jan 2002 19:38:38 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:28860 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290299AbSAPAiT>;
	Tue, 15 Jan 2002 19:38:19 -0500
Date: Wed, 16 Jan 2002 01:38:11 +0100
From: David Weinehall <tao@acc.umu.se>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, John Weber <weber@nyc.rr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020116013811.E5235@khan.acc.umu.se>
In-Reply-To: <20020115192048.G17477@redhat.com> <Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 15, 2002 at 04:29:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 04:29:38PM -0800, Linus Torvalds wrote:
> 
> On Tue, 15 Jan 2002, Benjamin LaHaise wrote:
> >
> > Hmm, this should fix that.
> 
> probably will, BUT..
> 
> > +#ifndef __ASM__ATOMIC_H
> > +#include <asm/atomic.h>
> > +#endif
> 
> Please do not assume knowdledge of what the different header files use to
> define their re-entrancy.
> 
> Just do
> 
> 	#include <asm/atomic.h>
> 
> and be done with it.

The lines below say:

#ifndef _LINUX_POSIX_TYPES_H   /* __FD_CLR */
#include <linux/posix_types.h>
#endif


Maybe fix this while at it?!


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
