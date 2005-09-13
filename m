Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbVIMM0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbVIMM0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVIMM0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:26:46 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:40915 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S932414AbVIMM0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:26:45 -0400
From: Lion Vollnhals <lion.vollnhals@web.de>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 2.6.13] ia64: re-implement dma_get_cache_alignment to avoid EXPORT_SYMBOL
Date: Tue, 13 Sep 2005 14:25:23 +0200
User-Agent: KMail/1.8.1
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com
References: <09122005104852.31327@bilbo.tuxdriver.com> <20050913000611.GI19644@tuxdriver.com> <20050913001429.GJ19644@tuxdriver.com>
In-Reply-To: <20050913001429.GJ19644@tuxdriver.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509131425.23950.lion.vollnhals@web.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  unsigned long ia64_max_cacheline_size;
> +
> +int dma_get_cache_alignment(void)
> +{
> +        return ia64_max_cacheline_size;
> +}
> +EXPORT_SYMBOL(dma_get_cache_alignment);
> +

Are you intentionally returning an "int" instead of an "unsigned long"?

-- 
Lion Vollnhals
