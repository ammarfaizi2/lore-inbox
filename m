Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271383AbTHRKPZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 06:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271384AbTHRKPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 06:15:25 -0400
Received: from dp.samba.org ([66.70.73.150]:12210 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271383AbTHRKPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 06:15:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use simple_strtoul for unsigned kernel parameters 
In-reply-to: Your message of "Mon, 18 Aug 2003 01:46:18 +0100."
             <20030818004618.GA5094@mail.jlokier.co.uk> 
Date: Mon, 18 Aug 2003 20:13:33 +1000
Message-Id: <20030818101524.5B12D2C019@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030818004618.GA5094@mail.jlokier.co.uk> you write:
> The largest "unsigned int" value doesn't fit in a "long", on many machines.
> So we should use simple_strtoul, not simple_strtol, to decode these values.

Half right.  The second part is fine, the first part is redundant
AFAICT.

Rusty.

> Enjoy,
> -- Jamie
> 
> --- orig-2.5.75/kernel/params.c	2003-07-08 21:44:26.000000000 +0100
> +++ laptop-2.5.75/kernel/params.c	2003-08-17 03:17:40.116594605 +0100
> @@ -165,9 +165,9 @@
>  	}
>  
>  STANDARD_PARAM_DEF(short, short, "%hi", long, simple_strtol);
> -STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", long, simple_strtol);
> +STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", unsigned long, simple_strtoul);
>  STANDARD_PARAM_DEF(int, int, "%i", long, simple_strtol);
> -STANDARD_PARAM_DEF(uint, unsigned int, "%u", long, simple_strtol);
> +STANDARD_PARAM_DEF(uint, unsigned int, "%u", unsigned long, simple_strtoul);
>  STANDARD_PARAM_DEF(long, long, "%li", long, simple_strtol);
>  STANDARD_PARAM_DEF(ulong, unsigned long, "%lu", unsigned long, simple_strtoul);
>  

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
