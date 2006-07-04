Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWGDMCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWGDMCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWGDMCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:02:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41367 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932229AbWGDMCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:02:47 -0400
Date: Tue, 4 Jul 2006 13:02:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
Message-ID: <20060704120242.GA3386@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
	Con Kolivas <kernel@kolivas.org>,
	Marcelo Tosatti <marcelo@kvack.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com> <20060703221712.GB14273@infradead.org> <Pine.LNX.4.64.0607031624210.8547@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607031624210.8547@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 04:26:57PM -0700, Christoph Lameter wrote:
> > Which btw is utterly wrong.  It should have a 4GB ZONE_DMA32 and everything
> > else in ZONE_NORMAL.
> 
> So we want to change the definition of ZONE_DMA to refer to the first 16MB 
> only? ZONE_DMA32 is always a 4GB border?

The definition of ZONE_DMA32 is to be te 32bit border.  I think we should
implement it wherever possible but at least on all architectures that
maybe have non-iommu implementations.  ZONE_DMA should be an arch-specific
low memory zone.

