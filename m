Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUFIVCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUFIVCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUFIVBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:01:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:15083 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266176AbUFIVBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:01:00 -0400
Date: Wed, 9 Jun 2004 14:00:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: arjanv@redhat.com, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
Message-ID: <20040609140056.E21045@build.pdx.osdl.net>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi> <20040609113455.U22989@build.pdx.osdl.net> <1086812001.13026.63.camel@cherry> <1086812486.2810.21.camel@laptop.fenrus.com> <1086814663.13026.70.camel@cherry>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1086814663.13026.70.camel@cherry>; from penberg@cs.helsinki.fi on Wed, Jun 09, 2004 at 11:57:43PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pekka Enberg (penberg@cs.helsinki.fi) wrote:
> +void *kcalloc(size_t n, size_t size, int flags)
> +{
> +	if (n != 0 && size > INT_MAX / n)
> +		return NULL;

Yup, I forgot to add divide by zero check.

> +	void *ret = kmalloc(n * size, flags);

This is only C99, and will make some compilers spit up warning.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
