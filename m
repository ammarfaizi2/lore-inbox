Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUHLJWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUHLJWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268477AbUHLJWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:22:15 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:19215 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268495AbUHLJUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:20:10 -0400
Date: Thu, 12 Aug 2004 10:20:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: Altix I/O code reorganization - 14 of 21
Message-ID: <20040812102009.G5988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408112333.i7BNXMXH163770@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408112333.i7BNXMXH163770@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Aug 11, 2004 at 06:33:22PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 06:33:22PM -0500, Pat Gefre wrote:
> > 007-io-hub-provider:
> >    tio_provider and hub_provider have exactly the same methods, no need to
> >    keep the xtalk_provider_t abstraction at all
> > 
> 
> The abstraction was done for future expansion.  We have removed it 
> and in the future if we do need to abstract these 2 providers, we will 
> submit another patch.

> +xtalk_provider_t hub_provider = {
> +
> +	(xtalk_intr_alloc_f *) sal_xtalk_intr_alloc,
> +	(xtalk_intr_free_f *) sal_xtalk_intr_free,
> +
> +};
> +
> +xtalk_provider_t tio_provider = {
> +
> +	(xtalk_intr_alloc_f *) sal_xtalk_intr_alloc,
> +	(xtalk_intr_free_f *) sal_xtalk_intr_free,
> +
> +};

you still have it in this patch.

