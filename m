Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319351AbSHNVPb>; Wed, 14 Aug 2002 17:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319313AbSHNVOV>; Wed, 14 Aug 2002 17:14:21 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:7644 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S319348AbSHNVNA>; Wed, 14 Aug 2002 17:13:00 -0400
Message-Id: <5.1.0.14.2.20020814141621.0b182df0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 14 Aug 2002 14:16:46 -0700
To: Andrew Morton <akpm@zip.com.au>, "H. Peter Anvin" <hpa@zytor.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [patch] __func__ -> __FUNCTION__
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D58BF90.56C75C66@zip.com.au>
References: <3D58A45F.A7F5BDD@zip.com.au>
 <ajaa5h$61f$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:13 AM 8/13/2002 -0700, Andrew Morton wrote:
>"H. Peter Anvin" wrote:
> >
> > Followup to:  <3D58A45F.A7F5BDD@zip.com.au>
> > By author:    Andrew Morton <akpm@zip.com.au>
> > In newsgroup: linux.dev.kernel
> >
> > > --- linux-2.5.31/include/linux/kernel.h       Wed Jul 24 14:31:31 2002
> > > +++ 25/include/linux/kernel.h Mon Aug 12 23:09:31 2002
> > > @@ -13,6 +13,8 @@
> > >  #include <linux/types.h>
> > >  #include <linux/compiler.h>
> > >
> > > +#define __func__ __FUNCTION__        /* For old gcc's */
> > > +
> > >  /* Optimization barrier */
> > >  /* The "volatile" is due to gcc bugs */
> > >  #define barrier() __asm__ __volatile__("": : :"memory")
> >
> > Shouldn't this be conditional on the version?
>
>Could be.  But I don't know what version to use.

#if __GNUC__ <= 2 && __GNUC_MINOR__ < 95
#define __func__ __FUNCTION__
#endif

Max

