Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVBAStY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVBAStY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVBAStY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:49:24 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:49028 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261399AbVBASs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:48:26 -0500
Date: Tue, 1 Feb 2005 10:47:30 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock in
 handle_mm_fault
In-Reply-To: <41FF00CE.8060904@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0502011044350.3205@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au> <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
 <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de> <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
 <20050113180205.GA17600@muc.de> <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
 <20050114043944.GB41559@muc.de> <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
 <20050114170140.GB4634@muc.de> <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
 <41FF00CE.8060904@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Nick Piggin wrote:

> Slightly OT: are you still planning to move the update_mem_hiwater and
> friends crud out of these fastpaths? It looks like at least that function
> is unsafe to be lockless.

Yes. I have a patch pending and the author of the CSA patches is a
cowoerker of mine. The patch will be resubmitted once certain aspects
of the timer subsystem are stabilized and/or when he gets back from his
vacation. The statistics are not critical to system operation.
