Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVEMLiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVEMLiQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 07:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVEMLiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 07:38:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12246 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262339AbVEMLiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 07:38:02 -0400
Date: Fri, 13 May 2005 04:37:49 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, shai@scalex86.org,
       steiner@sgi.com
Subject: Re: NUMA aware slab allocator V2
In-Reply-To: <20050513043311.7961e694.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0505130436380.4500@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
 <20050512000444.641f44a9.akpm@osdl.org> <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
 <20050513000648.7d341710.akpm@osdl.org> <Pine.LNX.4.58.0505130411300.4500@schroedinger.engr.sgi.com>
 <20050513043311.7961e694.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, Andrew Morton wrote:

> > The definition for the number of NUMA nodes is dependent on
> > CONFIG_FLATMEM instead of CONFIG_NUMA in mm.
> > CONFIG_FLATMEM is not set on ppc64 because CONFIG_DISCONTIG is set! And
> > consequently nodes exist in a non NUMA config.
>
> I was testing 2.6.12-rc4 base.

There we still have the notion of nodes depending on CONFIG_DISCONTIG and
not on CONFIG_NUMA. The node stuff needs to be

#ifdef CONFIG_FLATMEM

or

#ifdef CONFIG_DISCONTIG

??

