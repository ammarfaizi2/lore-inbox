Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbVKKSDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbVKKSDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbVKKSDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:03:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1238 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750980AbVKKSDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:03:39 -0500
Date: Fri, 11 Nov 2005 10:03:33 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] mm: atomic64 page counts
In-Reply-To: <Pine.LNX.4.61.0511111502560.16832@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0511111002520.20360@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
 <20051109181641.4b627eee.akpm@osdl.org> <Pine.LNX.4.61.0511100224030.6215@goblin.wat.veritas.com>
 <20051109190135.45e59298.akpm@osdl.org> <Pine.LNX.4.62.0511101342340.16283@schroedinger.engr.sgi.com>
 <20051110135336.24d04b86.akpm@osdl.org> <Pine.LNX.4.61.0511111502560.16832@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Hugh Dickins wrote:

> I've nothing against zero page refcounting avoidance, just wanted
> numbers to show it's more worth doing than not doing.  And I'm not
> the only one to have wondered, if it is an issue, wouldn't big NUMA
> benefit more from per-node zero pages anyway?  (Though of course
> the pages themselves should stay clean, so won't be bouncing.)

Per-node zero pages sound good. The page structs are placed on the 
respective nodes and therefore would not bounce.
