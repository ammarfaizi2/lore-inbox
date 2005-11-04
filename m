Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVKDWem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVKDWem (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVKDWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:34:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17071 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751080AbVKDWem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:34:42 -0500
Date: Fri, 4 Nov 2005 22:34:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] export ia64_max_cacheline_size
Message-ID: <20051104223441.GA16285@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20051104220737.GA16551@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104220737.GA16551@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 05:07:37PM -0500, Dave Jones wrote:
> on ia64, dma_get_cache_alignment() needs ia64_max_cacheline_size,
> which isn't exported. This breaks modular compilation of the b44
> network driver (and possibly others).

Can we please move dma_get_cache_alignment() out of line instead?
Always export sane APIs instead of random internals.

