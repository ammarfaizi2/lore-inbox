Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUKTCLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUKTCLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbUKTCFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:05:55 -0500
Received: from holomorphy.com ([207.189.100.168]:28544 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262823AbUKTCEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:04:09 -0500
Date: Fri, 19 Nov 2004 18:04:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120020401.GC2714@holomorphy.com>
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain> <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> <419D581F.2080302@yahoo.com.au> <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:42:39AM -0800, Christoph Lameter wrote:
> A. make_rss_atomic. The earlier releases contained that patch but
> then another variable (such as anon_rss) was introduced that would
>    have required additional atomic operations. Atomic rss operations
>    are also causing slowdowns on machines with a high number of cpus
>    due to memory contention.
> B. remove_rss. Replace rss with a periodic scan over the vm to
>    determine rss and additional numbers. This was also discussed on
>    linux-mm and linux-ia64. The scans while displaying /proc data
>    were undesirable.

Split counters easily resolve the issues with both these approaches
(and apparently your co-workers are suggesting it too, and have
performance results backing it).


-- wli
