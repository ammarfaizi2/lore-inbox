Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWACS7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWACS7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWACS7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:59:01 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64471 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932460AbWACS7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:59:01 -0500
Date: Tue, 3 Jan 2006 10:57:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: kus Kusche Klaus <kus@keba.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, mpm@selenic.com
Subject: RE: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
In-Reply-To: <Pine.LNX.4.58.0512291637220.25709@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.62.0601031056350.20913@schroedinger.engr.sgi.com>
References: <AAD6DA242BC63C488511C611BD51F367323305@MAILIT.keba.co.at>
 <Pine.LNX.4.58.0512291637220.25709@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Pekka J Enberg wrote:

> > You're right again, this one-liner makes slab work.
> > (by the way, line numbers differ by miles?)
> 
> Yes, the bug is not -rt related. The patch was against vanilla. Christoph, 
> do you know who did the ARM bits for NUMA-aware page allocator?

I was not aware that ARM supports NUMA. alloc_pages_node essentially dumbs 
down to a call to __alloc_pages. See include/linux/gfp.h.

This could mean that the NODE_DATA() macro does not correctly work on ARM.

