Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754595AbWKHRLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbWKHRLS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbWKHRLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:11:18 -0500
Received: from amsfep19-int.chello.nl ([62.179.120.14]:11732 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1754593AbWKHRLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:11:17 -0500
Subject: Re: Avoid allocating during interleave from almost full nodes
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Paul Jackson <pj@sgi.com>
Cc: clameter@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061108090644.f23d37de.pj@sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	 <20061103134633.a815c7b3.akpm@osdl.org>
	 <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	 <20061103143145.85a9c63f.akpm@osdl.org>
	 <20061103172605.e646352a.pj@sgi.com>
	 <20061103174206.53f2c49e.akpm@osdl.org>
	 <20061104025128.ca3c9859.pj@sgi.com>
	 <Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
	 <20061108022136.3b9b0748.pj@sgi.com> <1162999085.14238.17.camel@twins>
	 <20061108090644.f23d37de.pj@sgi.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 18:09:10 +0100
Message-Id: <1163005750.14238.19.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 09:06 -0800, Paul Jackson wrote:
> Peter wrote:
> > global fault counter
> 
> I hope we avoid frequently updated, widely accessed global
> counters.  They tend to create hot cache lines on big NUMA
> boxes.
> 
> Christoph said that the counters he was suggesting were
> node or cpu local.  That sounds good to me.

Very true indeed, I was just hoping we could come up with 1 vm-time; but
perhaps the local vs global thing will keep us from that.


