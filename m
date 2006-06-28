Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423224AbWF1IrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423224AbWF1IrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423227AbWF1IrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:47:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53464 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423224AbWF1IrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:47:17 -0400
Subject: Re: +
	keys-allow-in-kernel-key-requestor-to-pass-auxiliary-data-to-upcaller.patch
	added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dhowells@redhat.com, kwc@citi.umich.edu
In-Reply-To: <200606272332.k5RNWf43018630@shell0.pdx.osdl.net>
References: <200606272332.k5RNWf43018630@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 10:47:14 +0200
Message-Id: <1151484434.3153.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +/*****************************************************************************/
> +/*
> + * request a key with auxiliary data for the upcaller
> + * - search the process's keyrings
> + * - check the list of keys being created or updated
> + * - call out to userspace for a key if supplementary info was provided
> + */
> +struct key *request_key2(struct key_type *type,
> +			 const char *description,
> +			 const char *callout_info,
> +			 void *aux)
> +{
> +	return request_key_and_link(type, description, callout_info, aux,
> +				    NULL, KEY_ALLOC_IN_QUOTA);
> +
> +} /* end request_key2() */
> +
> +EXPORT_SYMBOL(request_key2);


that's a pretty dire name ..... request_key_with_data() or even
__request_key() would have been better..

and also since this is new, linux specific thing, shouldn't this be a
_GPL export?


