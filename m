Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUKTEl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUKTEl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbUKTEkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:40:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30091 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263118AbUKTEec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:34:32 -0500
Date: Fri, 19 Nov 2004 22:34:17 -0600
From: Robin Holt <holt@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Robin Holt <holt@sgi.com>
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120043416.GA11003@lnx-holt.americas.sgi.com>
References: <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <20041120020401.GC2714@holomorphy.com> <419EA96E.9030206@yahoo.com.au> <20041120023443.GD2714@holomorphy.com> <419EAEA8.2060204@yahoo.com.au> <20041120030425.GF2714@holomorphy.com> <419EB699.4050204@yahoo.com.au> <20041120034349.GG2714@holomorphy.com> <419EC0EC.9000106@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EC0EC.9000106@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 02:58:36PM +1100, Nick Piggin wrote:
> >Please be more specific about the result, and cite the Message-Id.
> >
> 
> Start of this thread.

Part of the impact was having the page table lock, the mmap_sem, and
these two atomic counters in the same cacheline.  What about seperating
the counters from the locks?
