Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317453AbSF1PH4>; Fri, 28 Jun 2002 11:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317454AbSF1PHz>; Fri, 28 Jun 2002 11:07:55 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:1669 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S317453AbSF1PHz>;
	Fri, 28 Jun 2002 11:07:55 -0400
Subject: Re: [PATCH] compile fix for 2.5 kdev_t compatibility macros
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Steven Cole <elenstev@mesatop.com>
Cc: Stephen Lord <lord@sgi.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1025275076.27133.131.camel@spc9.esa.lanl.gov>
References: <1025272233.1168.21.camel@n236> 
	<1025275076.27133.131.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 28 Jun 2002 17:10:08 +0200
Message-Id: <1025277008.1643.6.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-28 at 16:37, Steven Cole wrote:

[snip]
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

And here's one more...

--- linux-2.4.19-rc1/include/linux/kdev_t.h.orig	Fri Jun 28 16:59:48 2002
+++ linux-2.4.19-rc1/include/linux/kdev_t.h	Fri Jun 28 17:01:12 2002
@@ -82,7 +82,7 @@
 #define kdev_same(a,b)	((a) == (b))
 #define kdev_none(d)	(!(d))
 #define kdev_val(d)	((unsigned int)(d))
-#define val_to_kdev(d)	((kdev_t(d))
+#define val_to_kdev(d)	(kdev_t(d))
 
 /*
 As long as device numbers in the outside world have 16 bits only,

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
