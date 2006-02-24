Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWBXQRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWBXQRk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWBXQRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:17:40 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29632 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932312AbWBXQRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:17:39 -0500
Date: Fri, 24 Feb 2006 08:16:43 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, clameter@sgi.com,
       manfred@colorfullife.com, mark.fasheh@oracle.com,
       alok.kataria@calsoftinc.com, kiran@scalex86.org
Subject: Re: [PATCH] slab: Don't scan cache_cache
In-Reply-To: <Pine.LNX.4.58.0602240950050.16521@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0602240815010.20760@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0602240950050.16521@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Pekka J Enberg wrote:

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> The cache_cache object cache is used for bootstrapping, but the cache is
> essentially static. It is unlikely that we ever have more than one page
> allocated for it. As SLAB_NO_REAP is gone now, fix a regression by skipping
> cache_cache explicitly in cache_reap().

There are other essentially static caches as well. Could we have something 
more general?

Are you really seeing any measurable regression?
