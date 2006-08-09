Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWHIFrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWHIFrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 01:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWHIFrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 01:47:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:23432 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965077AbWHIFrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 01:47:37 -0400
Date: Wed, 9 Aug 2006 09:46:48 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060809054648.GD17446@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060808193325.1396.58813.sendpatchset@lappy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 09 Aug 2006 09:46:50 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 09:33:25PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
>    http://lwn.net/Articles/144273/
>    "Kernel Summit 2005: Convergence of network and storage paths"
> 
> We believe that an approach very much like today's patch set is
> necessary for NBD, iSCSI, AoE or the like ever to work reliably. 
> We further believe that a properly working version of at least one of
> these subsystems is critical to the viability of Linux as a modern
> storage platform.

There is another approach for that - do not use slab allocator for
network dataflow at all. It automatically has all you pros amd if
implemented correctly can have a lot of additional usefull and
high-performance features like full zero-copy and total fragmentation
avoidance.

-- 
	Evgeniy Polyakov
