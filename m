Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbRGNShE>; Sat, 14 Jul 2001 14:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbRGNSgy>; Sat, 14 Jul 2001 14:36:54 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:56647 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264754AbRGNSgr>; Sat, 14 Jul 2001 14:36:47 -0400
Date: Sat, 14 Jul 2001 14:36:42 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107141836.f6EIagB30800@devserv.devel.redhat.com>
To: dwmw2@infradead.org, Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
In-Reply-To: <mailman.995129400.8760.linux-kernel2news@redhat.com>
In-Reply-To: <20010715031815.D6722@weta.f00f.org>  <200107141414.f6EEEjQ05792@ns.caldera.de> <mailman.995129400.8760.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, you wrote:
> cw@f00f.org said:
> >  Linus, please consider applying the following patch. 
> > 
> > --- linux-2.4.7-pre6/include/linux/malloc.h	Thu Jul 12 03:53:53 2001
> > +++ linux-2.4.7-pre6+mallocRIP/include/linux/malloc.h	Thu Jan  1 12:00:00 1970
> > @@ -1,5 +0,0 @@
> > -#ifndef _LINUX_MALLOC_H
> > -#define _LINUX_MALLOC_H
> > -
> > -#include <linux/slab.h>
> > -#endif /* _LINUX_MALLOC_H */
> 
> Doing that in the middle of a supposedly stable series, even if it wasn't a 
> fundamentally stupid thing to do in the first place, isn't really very 
> sensible.
> 
> --
> dwmw2

It would be much better to add something like this:

#warning "Please use slab.h instead"

The patch above should be put off until the 2.5.

-- Pete
