Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbWHIFwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbWHIFwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 01:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWHIFwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 01:52:53 -0400
Received: from smtp-out.google.com ([216.239.45.12]:11594 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030493AbWHIFwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 01:52:51 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=Elltw1Y9Z57nMBmdCMfkByk6gEEyoLmUWFG/aCz12YiqaCStP1/shoIpxMGgkwRrN
	EmGYQEFffEhwx1FWAWM4w==
Message-ID: <44D97822.5010007@google.com>
Date: Tue, 08 Aug 2006 22:52:34 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060809054648.GD17446@2ka.mipt.ru>
In-Reply-To: <20060809054648.GD17446@2ka.mipt.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Tue, Aug 08, 2006 at 09:33:25PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> 
>>   http://lwn.net/Articles/144273/
>>   "Kernel Summit 2005: Convergence of network and storage paths"
>>
>>We believe that an approach very much like today's patch set is
>>necessary for NBD, iSCSI, AoE or the like ever to work reliably. 
>>We further believe that a properly working version of at least one of
>>these subsystems is critical to the viability of Linux as a modern
>>storage platform.
> 
> There is another approach for that - do not use slab allocator for
> network dataflow at all. It automatically has all you pros amd if
> implemented correctly can have a lot of additional usefull and
> high-performance features like full zero-copy and total fragmentation
> avoidance.

Agreed.  But probably more intrusive than davem would be happy with
at this point.

Regards,

Daniel
