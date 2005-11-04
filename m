Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVKDXxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKDXxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVKDXxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:53:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41919 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750802AbVKDXxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:53:03 -0500
Date: Fri, 4 Nov 2005 23:52:57 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export ia64_max_cacheline_size
Message-ID: <20051104235257.GA21674@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, davej@redhat.com,
	linux-kernel@vger.kernel.org
References: <20051104220737.GA16551@redhat.com> <20051104223441.GA16285@infradead.org> <20051104145534.17e913f2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104145534.17e913f2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 02:55:34PM -0800, Andrew Morton wrote:
> > Can we please move dma_get_cache_alignment() out of line instead?
> 
> It's a single statement!  It wants to be inlined.
> 
> > Always export sane APIs instead of random internals.
> 
> The exported API is dma_get_cache_alignment().  For internal implementation
> reasons we need to export an ia64 symbol to modules to support it.  That
> kinda sucks, but I don't think that we need to compromise kernel size and
> performance because of it.

It's an API used only in slow pathes.  It's much better to enforce modularity
in that case.
