Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVJEQwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVJEQwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVJEQwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:52:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47505 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030240AbVJEQwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:52:06 -0400
Subject: Re: [PATCH 5/7] Fragmentation Avoidance V16: 005_fallback
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	 <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 09:51:55 -0700
Message-Id: <1128531115.26009.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 15:46 +0100, Mel Gorman wrote:
> 
> + */
> +static inline struct free_area *
> +fallback_buddy_reserve(int start_alloctype, struct zone *zone,
> +                       unsigned int current_order, struct page *page,
> +                       struct free_area *area)
> +{
> +       if (start_alloctype != RCLM_NORCLM)
> +               return area;
> +
> +       area = &(zone->free_area_lists[RCLM_NORCLM][current_order]);
> +
> +       /* Reserve the whole block if this is a large split */
> +       if (current_order >= MAX_ORDER / 2) {
> +               int reserve_type=RCLM_NORCLM;

-EBADCODINGSTYLE.

-- Dave

