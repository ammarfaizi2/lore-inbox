Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWDTRWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWDTRWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWDTRWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:22:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13184 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751075AbWDTRWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:22:09 -0400
Date: Thu, 20 Apr 2006 18:22:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 1/5] mm: remap_vmalloc_range
Message-ID: <20060420172205.GC21659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Hugh Dickins <hugh@veritas.com>
References: <20060228202202.14172.60409.sendpatchset@linux.site> <20060228202212.14172.59536.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060228202212.14172.59536.sendpatchset@linux.site>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 07:06:18PM +0200, Nick Piggin wrote:
> Add a remap_vmalloc_range and get rid of as many remap_pfn_range and
> vm_insert_page loops as possible.
> 
> remap_vmalloc_range can do a whole lot of nice range checking even
> if the caller gets it wrong (which it looks like one or two do).

This looks very nice, thanks!  Although it might be better to split it
into one patch to introduce remap_vmalloc_range and various patches to
switch over one susbsyetm for merging purposes.

