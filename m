Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVKSMFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVKSMFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVKSMFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:05:05 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:62402 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751089AbVKSMFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:05:03 -0500
Subject: Re: [PATCH 1/5] slab: rename obj_reallen to obj_size
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
In-Reply-To: <437F1333.5010308@colorfullife.com>
References: <iq5uu1.87bo1s.3tcvszwr6pjjr4ngr04pw358p.beaver@cs.helsinki.fi>
	 <437F1333.5010308@colorfullife.com>
Date: Sat, 19 Nov 2005 14:04:56 +0200
Message-Id: <1132401896.17963.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred,

On Sat, 2005-11-19 at 12:57 +0100, Manfred Spraul wrote:
> With your change, cachep->objsize is the internal allocation and 
> obj_size(cachep) is the user visible part. This reduces the readability.
> I agree that the names obj_size and reallen are bad. What about the 
> attached patch?

I like your patch a lot. Some comments below.

> +	/*
> +	 * If debugging is enabled, then the allocator can add additional
> +	 * fields and/or padding to every object. objsize contains the total
> +	 * object size including these internal fields, the following two
> +	 * variables contain the offset to the user object and its size.
> +	 */
> +	int			user_off;

user_offset is more readable.

> +	int			user_size;

>  #endif
>  };
> -static int obj_dbghead(kmem_cache_t *cachep)
> +static int obj_user_off(kmem_cache_t *cachep)

So why not call the above obj_offset() ?

> -static int obj_reallen(kmem_cache_t *cachep)
> +static int obj_user_size(kmem_cache_t *cachep)

and this one obj_size() ?

Other than that looks good.

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>

				Pekka

