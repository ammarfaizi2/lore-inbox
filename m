Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVLLD4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVLLD4n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 22:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVLLD4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 22:56:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:11147 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751077AbVLLD4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 22:56:42 -0500
Date: Mon, 12 Dec 2005 04:56:32 +0100
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/6] Framework
Message-ID: <20051212035631.GX11190@wotan.suse.de>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com> <439CF2A2.60105@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439CF2A2.60105@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 02:46:42PM +1100, Nick Piggin wrote:
> Christoph Lameter wrote:
> 
> >+/*
> >+ * For use when we know that interrupts are disabled.
> >+ */
> >+static inline void __mod_zone_page_state(struct zone *zone, enum 
> >zone_stat_item item, int delta)
> >+{
> 
> Before this goes through, I have a full patch to do similar for the
> rest of the statistics, and which will make names consistent with what
> you have (shouldn't be a lot of clashes though).

I also have a patch to change them all to local_t, greatly simplifying
it (e.g. the counters can be done inline then) 

-Andi
