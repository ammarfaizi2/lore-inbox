Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317450AbSF1O7z>; Fri, 28 Jun 2002 10:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317451AbSF1O7y>; Fri, 28 Jun 2002 10:59:54 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:46132 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S317450AbSF1O7x>;
	Fri, 28 Jun 2002 10:59:53 -0400
Date: Fri, 28 Jun 2002 17:02:13 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Stephen Lord <lord@sgi.com>
Cc: Steven Cole <elenstev@mesatop.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] compile fix for 2.5 kdev_t compatibility macros
Message-ID: <20020628150213.GA20534@win.tue.nl>
References: <1025272233.1168.21.camel@n236> <1025275076.27133.131.camel@spc9.esa.lanl.gov> <1025275551.1168.27.camel@n236>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025275551.1168.27.camel@n236>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2002 at 09:42:42AM -0500, Stephen Lord wrote:
> On Fri, 2002-06-28 at 09:37, Steven Cole wrote:
> > On Fri, 2002-06-28 at 07:50, Stephen Lord wrote:
> > > 
> > > 
> > > Marcelo,
> > > 
> > > We started using these for XFS, and found a missing bracket, patch
> > > against 2.4.19-rc1.

> > --- linux-2.4.19-rc1/include/linux/kdev_t.h.orig	Fri Jun 28 08:31:27 2002
> > +++ linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 08:32:36 2002
> > @@ -81,7 +81,7 @@
> >  #define minor(d)	MINOR(d)
> >  #define kdev_same(a,b)	((a) == (b))
> >  #define kdev_none(d)	(!(d))
> > -#define kdev_val(d)	((unsigned int)(d)
> > +#define kdev_val(d)	((unsigned int)(d))
> >  #define val_to_kdev(d)	((kdev_t(d))
> >  
> >  /*

But what about the next line?
