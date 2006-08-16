Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWHPPHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWHPPHG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWHPPHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:07:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6309 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751214AbWHPPHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:07:04 -0400
Date: Wed, 16 Aug 2006 08:06:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: David Chinner <dgc@sgi.com>
cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
In-Reply-To: <20060816081208.GL51703024@melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0608160806050.16619@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816081208.GL51703024@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, David Chinner wrote:

> Also, some slab users probably want their own pool of objects that
> nobody else can use - mempools are a good example of this - so there
> needs to a way of indicating slabs should not be merged into the
> kmalloc array.

slabs are only merged if they are compatible with the kmalloc array. If a 
slab uses a memory pool then that would prohibit the merging.

