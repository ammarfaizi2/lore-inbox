Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291168AbSAaR0f>; Thu, 31 Jan 2002 12:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291169AbSAaR01>; Thu, 31 Jan 2002 12:26:27 -0500
Received: from Expansa.sns.it ([192.167.206.189]:14597 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291168AbSAaR0R>;
	Thu, 31 Jan 2002 12:26:17 -0500
Date: Thu, 31 Jan 2002 18:26:18 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Patrick Mochel <mochel@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 does not compile on sparc64
In-Reply-To: <Pine.LNX.4.33.0201310845320.800-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.44.0201311823570.21203-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, but the error do persist also with this patch,
probably my english was unclear.
I changes the include, because otherway I was getting
a no such file message, after the change I got this error
message.
I should add that gcc for sparc64 to compile a 64 bit kernel is just egcs
1.1.2, because gcc 2.95 and following have problems to compile at 64 bit
of sparc.

Luigi

On Thu, 31 Jan 2002, Patrick Mochel wrote:

>
> Hi there.
>
> > Of course I had to correct dome
> > #include <malloc.h>
> > in
> > #include <slab.h> (this is the case).
>
> That's right. I've sent a patch to Linus, but here it is for everyone else
> while waiting for 2.5.4-pre1.
>
> 	-pat
>
> --- linux-2.5.3/drivers/base/core.c.1	Wed Jan 30 14:20:25 2002
> +++ linux-2.5.3/drivers/base/core.c	Wed Jan 30 14:20:33 2002
> @@ -7,7 +7,7 @@
>
>  #include <linux/device.h>
>  #include <linux/module.h>
> -#include <linux/malloc.h>
> +#include <linux/slab.h>
>
>  #undef DEBUG
>
> --- linux-2.5.3/drivers/base/fs.c.0	Wed Jan 30 14:20:44 2002
> +++ linux-2.5.3/drivers/base/fs.c	Wed Jan 30 14:20:52 2002
> @@ -8,7 +8,7 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/string.h>
> -#include <linux/malloc.h>
> +#include <linux/slab.h>
>
>  extern struct driver_file_entry * device_default_files[];
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

