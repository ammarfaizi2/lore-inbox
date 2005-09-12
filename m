Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVILTZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVILTZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVILTZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:25:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7912 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932098AbVILTZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:25:26 -0400
Date: Mon, 12 Sep 2005 20:25:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       tony.luck@intel.com
Subject: Re: [patch 2.6.13] ia64: add EXPORT_SYMBOL_GPL for ia64_max_cacheline_size
Message-ID: <20050912192524.GA14360@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	tony.luck@intel.com
References: <09122005104852.31327@bilbo.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09122005104852.31327@bilbo.tuxdriver.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 10:48:52AM -0400, John W. Linville wrote:
> The implementation of dma_get_cache_alignment for ia64 makes reference
> to ia64_max_cacheline_size inside of a static inline. For this to
> work for modules, this needs to be EXPORT_SYMBOL{,_GPL}.

This is not supposed to be a _GPL api.  best just move
dma_get_cache_alignment out of line.

