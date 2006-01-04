Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWADLTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWADLTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWADLTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:19:22 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:45233 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751699AbWADLTV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:19:21 -0500
Message-ID: <43BBAF37.3060108@cosmosbay.com>
Date: Wed, 04 Jan 2006 12:19:19 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
References: <20051108185349.6e86cec3.akpm@osdl.org> <p733bk4z2z0.fsf@verdi.suse.de> <43BBADD5.3070706@cosmosbay.com> <200601041215.36627.ak@suse.de>
In-Reply-To: <200601041215.36627.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 04 Jan 2006 12:19:20 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> On Wednesday 04 January 2006 12:13, Eric Dumazet wrote:
>> Andi Kleen a écrit :
>>> Eric Dumazet <dada1@cosmosbay.com> writes:
>>>> 1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits
>>>> platforms, lowering kmalloc() allocated space by 50%.
>>> It should be probably a kmem_cache_alloc() instead of a kmalloc
>>> in the first place anyways. This would reduce fragmentation.
>> Well in theory yes, if you really expect thousand of tasks running...
>> But for most machines, number of concurrent tasks is < 200, and using a 
>> special cache for this is not a win.
> 
> It is because it avoids fragmentation because objects with similar livetimes
> are clustered together. In general caches are a win
> if the data is nearly a page or more.

I dont undertand your last sentence. Do you mean 'if the object size is near 
PAGE_SIZE' ?

Eric
