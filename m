Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318929AbSHMH7C>; Tue, 13 Aug 2002 03:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318964AbSHMH7C>; Tue, 13 Aug 2002 03:59:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318929AbSHMH7C>;
	Tue, 13 Aug 2002 03:59:02 -0400
Message-ID: <3D58BF90.56C75C66@zip.com.au>
Date: Tue, 13 Aug 2002 01:13:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] __func__ -> __FUNCTION__
References: <3D58A45F.A7F5BDD@zip.com.au> <ajaa5h$61f$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Followup to:  <3D58A45F.A7F5BDD@zip.com.au>
> By author:    Andrew Morton <akpm@zip.com.au>
> In newsgroup: linux.dev.kernel
> 
> > --- linux-2.5.31/include/linux/kernel.h       Wed Jul 24 14:31:31 2002
> > +++ 25/include/linux/kernel.h Mon Aug 12 23:09:31 2002
> > @@ -13,6 +13,8 @@
> >  #include <linux/types.h>
> >  #include <linux/compiler.h>
> >
> > +#define __func__ __FUNCTION__        /* For old gcc's */
> > +
> >  /* Optimization barrier */
> >  /* The "volatile" is due to gcc bugs */
> >  #define barrier() __asm__ __volatile__("": : :"memory")
> 
> Shouldn't this be conditional on the version?

Could be.  But I don't know what version to use.
