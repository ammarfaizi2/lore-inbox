Return-Path: <linux-kernel-owner+w=401wt.eu-S1750945AbXAETv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbXAETv2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbXAETv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:51:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55042 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422707AbXAETv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:51:27 -0500
Date: Fri, 5 Jan 2007 11:50:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org, hch@lst.de,
       manfred@colorfullife.com, christoph@lameter.com, pj@sgi.com
Subject: Re: [PATCH] slab: cache alloc cleanups
Message-Id: <20070105115057.69d5ff11.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701051345040.20220@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0701051345040.20220@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007 13:46:45 +0200 (EET)
Pekka J Enberg <penberg@cs.helsinki.fi> wrote:

> Clean up __cache_alloc and __cache_alloc_node functions a bit.  We no 
> longer need to do NUMA_BUILD tricks and the UMA allocation path is much
> simpler. No functional changes in this patch.
> 
> Note: saves few kernel text bytes on x86 NUMA build due to using gotos in
> __cache_alloc_node() and moving __GFP_THISNODE check in to fallback_alloc().

Does this actually clean things up, or does it randomly move things around
while carefully retaining existing obscurity?  Not sure..


