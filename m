Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbSKPImK>; Sat, 16 Nov 2002 03:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbSKPImK>; Sat, 16 Nov 2002 03:42:10 -0500
Received: from miranda.axis.se ([193.13.178.2]:21438 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S267245AbSKPImJ>;
	Sat, 16 Nov 2002 03:42:09 -0500
Message-ID: <BA5F894454FFF542A3C0B3F41024D8BD244A93@mailse02.axis.se>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Olaf Dietsche'" <olaf.dietsche#list.linux-kernel@t-online.de>,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.5.47: strdup()
Date: Sat, 16 Nov 2002 09:48:57 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Olaf Dietsche 
> [mailto:olaf.dietsche#list.linux-kernel@t-online.de] 
> Sent: Saturday, November 16, 2002 07:21
> To: linux-kernel@vger.kernel.org
> Cc: trivial@rustcorp.com.au
> Subject: [PATCH] 2.5.47: strdup()
> 
> This *untested* patch adds strdup(). There are about five or six
> different strdup() implementations in various parts of the kernel.
> 
> Regards, Olaf.

[snip]

> +#ifndef __HAVE_ARCH_STRDUP
> +/**
> + * strdup - allocate memory and duplicate a string
> + */
> +char *strdup(const char *s)
> +{
> +	char *p = kmalloc(strlen(s) + 1, GFP_KERNEL);
> +	if (p)
> +		strcpy(p, s);
> +
> +	return p;
>  }
>  #endif

You should make sure s != NULL before doing anything else.

//Peter
