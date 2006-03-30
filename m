Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWC3UVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWC3UVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWC3UVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:21:24 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:15062 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750809AbWC3UVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:21:23 -0500
In-Reply-To: <200603302217.55435.ak@suse.de>
References: <20060330164120.GJ13590@parisc-linux.org> <200603302150.05357.ak@suse.de> <20060330201435.GM13590@parisc-linux.org> <200603302217.55435.ak@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D3AB1B22-E33B-409F-BF54-2F6FD071337A@kernel.crashing.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ioremap_cached()
Date: Thu, 30 Mar 2006 14:21:32 -0600
To: Andi Kleen <ak@suse.de>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 30, 2006, at 2:17 PM, Andi Kleen wrote:

> On Thursday 30 March 2006 22:14, Matthew Wilcox wrote:
>
>> I think you misunderstood.  The right interface to call, that should
>> work everywhere, should be the simple, obvious one.  ioremap().  That
>> effectively is what everyone gets anyway (since they test on x86).
>> So change the *definition* of ioremap() to be uncached.  Then we  
>> can add
>> ioremap_wc() and ioremap_cached() for these special purpose mappings.
>
> That would break all the current users who do ioremap on memory
> and want it cached.

What's an example of this?  I ask since on powerpc ioremap() is  
always _PAGE_NO_CACHE.

- kumar
