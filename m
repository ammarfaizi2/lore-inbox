Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSF1Oh6>; Fri, 28 Jun 2002 10:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317444AbSF1Oh5>; Fri, 28 Jun 2002 10:37:57 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:42438 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S317440AbSF1Oh4>; Fri, 28 Jun 2002 10:37:56 -0400
Subject: Re: [PATCH] compile fix for 2.5 kdev_t compatibility macros
From: Steven Cole <elenstev@mesatop.com>
To: Stephen Lord <lord@sgi.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1025272233.1168.21.camel@n236>
References: <1025272233.1168.21.camel@n236>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 28 Jun 2002 08:37:56 -0600
Message-Id: <1025275076.27133.131.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-28 at 07:50, Stephen Lord wrote:
> 
> 
> Marcelo,
> 
> We started using these for XFS, and found a missing bracket, patch
> against 2.4.19-rc1.
> 
> Steve
> 
> *** linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 08:40:22 2002
> --- linux/include/linux/kdev_t.h	Fri Jun 28 07:05:32 2002
> ***************
> *** 81,87 ****
>   #define minor(d)	MINOR(d)
>   #define kdev_same(a,b)	((a) == (b))
>   #define kdev_none(d)	(!(d))
> ! #define kdev_val(d)	((unsigned int)(d)
>   #define val_to_kdev(d)	((kdev_t(d))
>   
>   /*
> --- 81,87 ----
>   #define minor(d)	MINOR(d)
>   #define kdev_same(a,b)	((a) == (b))
>   #define kdev_none(d)	(!(d))
> ! #define kdev_val(d)	((unsigned int)(d))
>   #define val_to_kdev(d)	((kdev_t(d))
>   
>   /*

That's an odd-looking patch.  Is this what you meant?

Steven

--- linux-2.4.19-rc1/include/linux/kdev_t.h.orig	Fri Jun 28 08:31:27 2002
+++ linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 08:32:36 2002
@@ -81,7 +81,7 @@
 #define minor(d)	MINOR(d)
 #define kdev_same(a,b)	((a) == (b))
 #define kdev_none(d)	(!(d))
-#define kdev_val(d)	((unsigned int)(d)
+#define kdev_val(d)	((unsigned int)(d))
 #define val_to_kdev(d)	((kdev_t(d))
 
 /*


