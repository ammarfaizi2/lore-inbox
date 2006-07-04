Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWGDMEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWGDMEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWGDMEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:04:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7617 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932230AbWGDMEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:04:33 -0400
Date: Tue, 4 Jul 2006 13:04:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
Message-ID: <20060704120429.GB3386@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
	Marcelo Tosatti <marcelo@kvack.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com> <20060703221712.GB14273@infradead.org> <Pine.LNX.4.64.0607031624210.8547@schroedinger.engr.sgi.com> <200607040147.10995.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607040147.10995.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 01:47:10AM +0200, Andi Kleen wrote:
> It's really architecture dependent. The portable interfaces are 
> dma_alloc_* and suitable device masks and the architecture should sort
> out then what zone to use.

Well, there's some cases where you don't want coherent mappings but
rather alloc_page + dma_map_*.  And having a ZONE_DMA32 that is valid
on all architectures is very valueable for that.

I remember James promised a kmalloc_mask a last Kernel Summit that would
many things easier, but even than having predictable memory zone layouts
overy different architectures is a win.
