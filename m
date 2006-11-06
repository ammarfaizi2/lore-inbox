Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753441AbWKFQ4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbWKFQ4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbWKFQ4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:56:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:51881 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753441AbWKFQ4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:56:19 -0500
Date: Mon, 6 Nov 2006 08:56:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061104025128.ca3c9859.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0611060854000.25351@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org> <20061103172605.e646352a.pj@sgi.com>
 <20061103174206.53f2c49e.akpm@osdl.org> <20061104025128.ca3c9859.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2006, Paul Jackson wrote:

>   Do you know of any existing counters that we could use like this?
> 
> Adding a system wide count of pages allocated or scanned, just for
> these fullnode hint caches, bothers me.

There are already such counters. PGALLOC_* and PGSCAN_*. See 
include/linux/vmstat.h

> Perhaps best if we used a node or cpu local counter.

The counters are per cpu and are cpu local.
