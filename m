Return-Path: <linux-kernel-owner+w=401wt.eu-S932336AbXAISSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbXAISSS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbXAISSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:18:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43499 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932336AbXAISSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:18:17 -0500
Date: Tue, 9 Jan 2007 10:18:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: [PATCH] slab: cache_grow cleanup
In-Reply-To: <Pine.LNX.4.64.0701091539160.10824@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0701091017350.15631@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0701091539160.10824@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007, Pekka J Enberg wrote:

> The current implementation of cache_grow() has to either (1) use pre-allocated
> memory for the slab or (2) allocate the memory itself which makes the error
> paths messy. Move __GFP_NO_GROW and __GFP_WAIT processing to kmem_getpages()
> and introduce a new __cache_grow() variant that expects the memory for a new
> slab to always be handed over in the 'objp' parameter.

I am loosing track of these. What is the difference to earlier versions?
