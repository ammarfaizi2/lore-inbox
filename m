Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVLaBPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLaBPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVLaBPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:15:24 -0500
Received: from hera.kernel.org ([140.211.167.34]:42406 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932069AbVLaBPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:15:23 -0500
Date: Fri, 30 Dec 2005 23:15:07 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 14/14] page-replace-kswapd-incmin.patch
Message-ID: <20051231011507.GC4913@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet> <20051230224212.765.38527.sendpatchset@twins.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230224212.765.38527.sendpatchset@twins.localnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 11:42:34PM +0100, Peter Zijlstra wrote:
> 
> From: Nick Piggin <npiggin@suse.de>
> 
> Explicitly teach kswapd about the incremental min logic instead of just scanning
> all zones under the first low zone. This should keep more even pressure applied
> on the zones.
> 
> The new shrink_zone() logic exposes the very worst side of the current
> balance_pgdat() function. Without this patch reclaim is limited to ZONE_DMA.

Can you please describe the issue with over protection of DMA zone you experienced?

I'll see if I can reproduce it with Nick's standalone patch on top of vanilla, what
load was that?

