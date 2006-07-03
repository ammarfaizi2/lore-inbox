Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWGCWRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWGCWRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWGCWRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:17:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49072 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932153AbWGCWRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:17:18 -0400
Date: Mon, 3 Jul 2006 23:17:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
Message-ID: <20060703221712.GB14273@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
	Con Kolivas <kernel@kolivas.org>,
	Marcelo Tosatti <marcelo@kvack.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 02:55:34PM -0700, Christoph Lameter wrote:
> I keep seeing zones on various platforms that are never used and wonder
> why we compile support for them into the kernel.
> 
> IA64 on SGI for example only uses ZONE_DMA other IA64 platforms can
> also use ZONE_NORMAL.

Which btw is utterly wrong.  It should have a 4GB ZONE_DMA32 and everything
else in ZONE_NORMAL.

That doesn't mean I want to discourage this patchset, quite contrary.
But please fix this oddity aswell.

