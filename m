Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265839AbUFISfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUFISfK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUFISfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:35:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:9602 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265839AbUFISfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:35:02 -0400
Date: Wed, 9 Jun 2004 11:34:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
Message-ID: <20040609113455.U22989@build.pdx.osdl.net>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi>; from penberg@cs.helsinki.fi on Wed, Jun 09, 2004 at 12:24:56AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pekka J Enberg (penberg@cs.helsinki.fi) wrote:
>  /**
> + * kcalloc - allocate memory. The memory is set to zero.
> + * @size: how many bytes of memory are required.
> + * @flags: the type of memory to allocate.
> + */
> +void *kcalloc(size_t size, int flags)
> +{
> +	void *ret = kmalloc(size, flags);
> +	if (ret)
> +		memset(ret, 0, size);
> +	return ret;
> +}

This looks more like the kzalloc() that pops up every now and then.
Wouldn't it make more sense to give kcalloc() a true calloc() style
interface?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
