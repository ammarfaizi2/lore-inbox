Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317446AbSF1OpP>; Fri, 28 Jun 2002 10:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317447AbSF1OpO>; Fri, 28 Jun 2002 10:45:14 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:58305 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S317446AbSF1OpO>;
	Fri, 28 Jun 2002 10:45:14 -0400
Subject: Re: [PATCH] compile fix for 2.5 kdev_t compatibility macros
From: Stephen Lord <lord@sgi.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1025275076.27133.131.camel@spc9.esa.lanl.gov>
References: <1025272233.1168.21.camel@n236> 
	<1025275076.27133.131.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 28 Jun 2002 09:42:42 -0500
Message-Id: <1025275551.1168.27.camel@n236>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-28 at 09:37, Steven Cole wrote:
> On Fri, 2002-06-28 at 07:50, Stephen Lord wrote:
> > 
> > 
> > Marcelo,
> > 
> > We started using these for XFS, and found a missing bracket, patch
> > against 2.4.19-rc1.
> > 
> > Steve
> > 
> > *** linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 08:40:22 2002
> > --- linux/include/linux/kdev_t.h	Fri Jun 28 07:05:32 2002
> > ***************
> > *** 81,87 ****
> >   #define minor(d)	MINOR(d)
> >   #define kdev_same(a,b)	((a) == (b))
> >   #define kdev_none(d)	(!(d))
> > ! #define kdev_val(d)	((unsigned int)(d)
> >   #define val_to_kdev(d)	((kdev_t(d))
> >   
> >   /*
> > --- 81,87 ----
> >   #define minor(d)	MINOR(d)
> >   #define kdev_same(a,b)	((a) == (b))
> >   #define kdev_none(d)	(!(d))
> > ! #define kdev_val(d)	((unsigned int)(d))
> >   #define val_to_kdev(d)	((kdev_t(d))
> >   
> >   /*
> 
> That's an odd-looking patch.  Is this what you meant?
> 
> Steven
> 
> --- linux-2.4.19-rc1/include/linux/kdev_t.h.orig	Fri Jun 28 08:31:27 2002
> +++ linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 08:32:36 2002
> @@ -81,7 +81,7 @@
>  #define minor(d)	MINOR(d)
>  #define kdev_same(a,b)	((a) == (b))
>  #define kdev_none(d)	(!(d))
> -#define kdev_val(d)	((unsigned int)(d)
> +#define kdev_val(d)	((unsigned int)(d))
>  #define val_to_kdev(d)	((kdev_t(d))
>  
>  /*
> 


Yes, do not use diff before drinking coffee in the morning.

Steve


