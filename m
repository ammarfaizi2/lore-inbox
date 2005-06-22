Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVFVP4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVFVP4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFVP4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:56:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261504AbVFVPxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:53:54 -0400
Date: Wed, 22 Jun 2005 08:52:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "Richard B. Johnson" <linux-os@analogic.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH] fix remap_pte_range BUG
Message-ID: <20050622155242.GL9046@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0506221348540.13520@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506221348540.13520@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins (hugh@veritas.com) wrote:
> Out-of-tree user of remap_pfn_range hit kernel BUG at mm/memory.c:1112!
> It passes an unrounded size to remap_pfn_range, which was okay before
> 2.6.12, but misses remap_pte_range's new end condition.  An audit of
> all the other ptwalks confirms that this is the only one so exposed.

Thanks Hugh, queued to -stable.
-chris
