Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVIMAGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVIMAGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVIMAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:06:34 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:29451 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932375AbVIMAGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:06:33 -0400
Date: Mon, 12 Sep 2005 20:06:13 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com
Subject: Re: [patch 2.6.13] ia64: add EXPORT_SYMBOL_GPL for ia64_max_cacheline_size
Message-ID: <20050913000611.GI19644@tuxdriver.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	tony.luck@intel.com
References: <09122005104852.31327@bilbo.tuxdriver.com> <20050912192524.GA14360@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912192524.GA14360@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 08:25:24PM +0100, Christoph Hellwig wrote:
> On Mon, Sep 12, 2005 at 10:48:52AM -0400, John W. Linville wrote:
> > The implementation of dma_get_cache_alignment for ia64 makes reference
> > to ia64_max_cacheline_size inside of a static inline. For this to
> > work for modules, this needs to be EXPORT_SYMBOL{,_GPL}.
> 
> This is not supposed to be a _GPL api.  best just move
> dma_get_cache_alignment out of line.

You are thinking of something like the x86_64 implementation?
That seems reasonable to me.  Patch to follow...

John
-- 
John W. Linville
linville@tuxdriver.com
