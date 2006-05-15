Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWEOVrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWEOVrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWEOVrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:47:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16277 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965245AbWEOVrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:47:39 -0400
Date: Mon, 15 May 2006 14:47:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Roland Dreier <rdreier@cisco.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       "akpm@osdl.org Linux Kernel Mailing List" 
	<linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Or Gerlitz <ogerlitz@voltaire.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] slab: Fix kmem_cache_destroy() on NUMA
In-Reply-To: <adaves7rv0j.fsf_-_@cisco.com>
Message-ID: <Pine.LNX.4.64.0605151446340.835@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org>
 <Pine.LNX.4.44.0605141306240.29880-100000@zuben> <adaves7rv0j.fsf_-_@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006, Roland Dreier wrote:

> This patch fixes this by having drain_cpu_caches() do 
> drain_alien_cache() on every node before it does drain_array() on the 
> nodes' shared array_caches.

Correct. That is the fix that I suggested earlier. The alien caches needs 
to be drained first.
