Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312142AbSCTKCt>; Wed, 20 Mar 2002 05:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312143AbSCTKCj>; Wed, 20 Mar 2002 05:02:39 -0500
Received: from imladris.infradead.org ([194.205.184.45]:4361 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S312142AbSCTKC1>;
	Wed, 20 Mar 2002 05:02:27 -0500
Date: Wed, 20 Mar 2002 10:02:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-110-zone_accounting
Message-ID: <20020320100221.B1730@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>, Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9808EE.B5C38E84@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +void delta_nr_active_pages(struct page *page, long delta)
> +{
> +	pg_data_t * __pgdat;
> +	zone_t * __classzone, * __overflow;
> +
> +	__classzone = page_zone(page);
> +	__pgdat = __classzone->zone_pgdat;
> +	__overflow = __pgdat->node_zones + __pgdat->nr_zones;

Double-underscroes for local variables are very bad style.
Could you change this?

