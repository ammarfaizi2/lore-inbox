Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVKQOPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVKQOPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 09:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVKQOPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 09:15:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34524 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750840AbVKQOPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 09:15:47 -0500
Subject: Re: [PATCH] mm: is_dma_zone
From: Dave Hansen <haveblue@us.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200511180059.51211.kernel@kolivas.org>
References: <200511180059.51211.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 15:15:43 +0100
Message-Id: <1132236943.5834.70.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 00:59 +1100, Con Kolivas wrote:
> +static inline int is_dma(struct zone *zone)
> +{
> +       return zone == zone->zone_pgdat->node_zones + ZONE_DMA;
> +}

Any reason you can't just use 'zone_idx(z) == ZONE_DMA' here, just like
the code you replaced?

-- Dave

