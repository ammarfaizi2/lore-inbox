Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWCVIpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWCVIpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWCVIpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:45:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36270 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751113AbWCVIpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:45:17 -0500
Subject: Re: [RFC PATCH 31/35] Add Xen grant table support
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063806.220039000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063806.220039000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:45:14 +0100
Message-Id: <1143017114.2955.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> + * This file may be distributed separately from the Linux kernel, or
> + * incorporated into other software packages, subject to the following license:

please again fix the license



> +EXPORT_SYMBOL(gnttab_grant_foreign_access);
> +EXPORT_SYMBOL(gnttab_end_foreign_access_ref);
> +EXPORT_SYMBOL(gnttab_end_foreign_access);
> +EXPORT_SYMBOL(gnttab_query_foreign_access);
> +EXPORT_SYMBOL(gnttab_grant_foreign_transfer);
> +EXPORT_SYMBOL(gnttab_end_foreign_transfer_ref);
> +EXPORT_SYMBOL(gnttab_end_foreign_transfer);
> +EXPORT_SYMBOL(gnttab_alloc_grant_references);
> +EXPORT_SYMBOL(gnttab_free_grant_references);
> +EXPORT_SYMBOL(gnttab_free_grant_reference);
> +EXPORT_SYMBOL(gnttab_claim_grant_reference);
> +EXPORT_SYMBOL(gnttab_release_grant_reference);
> +EXPORT_SYMBOL(gnttab_request_free_callback);
> +EXPORT_SYMBOL(gnttab_grant_foreign_access_ref);
> +EXPORT_SYMBOL(gnttab_grant_foreign_transfer_ref);

and consider these as _GPL exports


> +#ifndef __ia64__
> +static int map_pte_fn(pte_t *pte, struct page *pte_page,
> +		      unsigned long addr, void *data)
> +{
> +	unsigned long **frames = (unsigned long **)data;
> +
> +	set_pte_at(&init_mm, addr, pte, pfn_pte((*frames)[0], PAGE_KERNEL));
> +	(*frames)++;
> +	return 0;
> +}

looks to me the wrong ifdef for a file in arch/i386... please fix



