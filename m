Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751751AbWBWRVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbWBWRVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWBWRVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:21:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57300 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751751AbWBWRVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:21:37 -0500
Date: Thu, 23 Feb 2006 09:20:35 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: Andrew Morton <akpm@osdl.org>, Alok Kataria <alok.kataria@calsoftinc.com>,
       clameter@engr.sgi.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
In-Reply-To: <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
 <20060223020957.478d4cc1.akpm@osdl.org> <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Pekka J Enberg wrote:

> We need _something_ to avoid excessive scanning of cache_cache. It takes a 
> hell of a lot insmod/rmmod to actually free a full page. Maybe something 
> like this (totally untested) patch?

What excessive scanning of cache_cache? If the per cpu cache of 
cache_cache has been drained then there will be no scanning just an 
inspection if there are zero elements.

