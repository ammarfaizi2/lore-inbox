Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWHNFVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWHNFVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 01:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbWHNFVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 01:21:12 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:3733 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751776AbWHNFVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 01:21:11 -0400
Date: Mon, 14 Aug 2006 09:20:16 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Daniel Phillips <phillips@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Indan Zupancic <indan@nul.nu>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 0/4] VM deadlock prevention -v4
Message-ID: <20060814052015.GB1335@2ka.mipt.ru>
References: <20060812141415.30842.78695.sendpatchset@lappy> <33471.81.207.0.53.1155401489.squirrel@81.207.0.53> <1155404014.13508.72.camel@lappy> <47227.81.207.0.53.1155406611.squirrel@81.207.0.53> <1155408846.13508.115.camel@lappy> <44DFC707.7000404@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44DFC707.7000404@google.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 14 Aug 2006 09:20:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 05:42:47PM -0700, Daniel Phillips (phillips@google.com) wrote:
> High order allocations are just way too undependable without active
> defragmentation, which isn't even on the horizon at the moment.  We
> just need to treat any network hardware that can't scatter/gather into
> single pages as too broken to use for network block io.

A bit of network tree allocator free advertisement - per-CPU self 
defragmentation works reliably in that allocator, one could even find a
graphs of memory usage for NTA and SLAB-like allocator.

> As for sk_buff cow break, we need to look at which network paths do it
> (netfilter obviously, probably others) and decide whether we just want
> to declare that the feature breaks network block IO, or fix the feature
> so it plays well with reserve accounting.

I would suggest to consider skb cow (cloning) as a must.


> Regards,
> 
> Daniel

-- 
	Evgeniy Polyakov
