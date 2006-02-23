Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWBWTmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWBWTmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWBWTmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:42:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:20626 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751760AbWBWTmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:42:04 -0500
Date: Thu, 23 Feb 2006 11:41:51 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: alokk@calsoftinc.com, manfred@colorfullife.com, penberg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slab: Node rotor for freeing alien caches and remote per cpu
 pages.
In-Reply-To: <20060223113331.6b345e1b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602231140140.13899@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com>
 <20060223113331.6b345e1b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Andrew Morton wrote:

> Christoph Lameter <clameter@engr.sgi.com> wrote:
> >
> > The cache reaper currently tries to free all alien caches and all remote
> >  per cpu pages in each pass of cache_reap.
> 
> umm, why?  We have a reap timer per cpu - why doesn't each CPU drain its
> own stuff and its own node's stuff and leave the other nodes&cpus alone?

Each cpu has per cpu pages on remote nodes and also has alien caches 
on remote nodes. These are only accessible from the processor using them.

This is the cpus "own" stuff but this stuff is per node.


