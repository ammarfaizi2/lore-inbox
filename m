Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUJOKvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUJOKvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 06:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUJOKvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 06:51:06 -0400
Received: from holomorphy.com ([207.189.100.168]:49800 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267607AbUJOKvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 06:51:03 -0400
Date: Fri, 15 Oct 2004 03:51:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: per-process shared information
Message-ID: <20041015105101.GF5607@holomorphy.com>
References: <20041013231042.GQ17849@dualathlon.random> <Pine.LNX.4.44.0410142205450.2702-100000@localhost.localdomain> <20041014223730.GI17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014223730.GI17849@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 10:49:28PM +0100, Hugh Dickins wrote:
>> shouldn't change that now, but add your statm_phys_shared; whatever,

On Fri, Oct 15, 2004 at 12:37:30AM +0200, Andrea Arcangeli wrote:
> the only reason to add statm_phys_shared was to keep ps xav fast, if you
> don't slowdown pa xav you can add another field at the end of statm.
> Ideally shared should have been set to 0 and it should have been moved
> to statm_phys_shared. It's slow but not so horrid thanks to the mapcount
> which makes it really strightforward (it's just a vma + pgtable walk,
> the only tricky bit is the signal catch and need_resched).

I'd be rather loath to endorse reintroducing the problematic pagetable
and vma walks I spent so much effort eliminating. Will Hugh's patch
suffice for you? If not, what else is needed?


-- wli
