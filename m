Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUCUUtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUCUUtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:49:40 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:13317 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261292AbUCUUtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:49:36 -0500
Date: Sun, 21 Mar 2004 20:49:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, rmk@arm.linux.org.uk,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040321204931.A11519@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>, rmk@arm.linux.org.uk,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320121345.2a80e6a0.akpm@osdl.org> <20040320205053.GJ2045@holomorphy.com> <20040320222639.K6726@flint.arm.linux.org.uk> <20040320224500.GP2045@holomorphy.com> <1079901914.17681.317.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1079901914.17681.317.camel@imladris.demon.co.uk>; from dwmw2@infradead.org on Sun, Mar 21, 2004 at 08:45:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 08:45:14PM +0000, David Woodhouse wrote:
> There are machines where DMA to/from main memory _cannot_ be coherent
> but we have some memory elsewhere, perhaps some SRAM which itself is
> hanging off an I/O bus somewhere, which can be used. One of my toys is
> currently running with dma_alloc_coherent() giving out memory from a PCI
> video card, in fact.
> 
> Using a PFN should be OK.

And what exactly is a PFN without associated struct page supposed to mean?

