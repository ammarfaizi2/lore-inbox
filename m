Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWAFDBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWAFDBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWAFDBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:01:44 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:12796 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932611AbWAFDBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:01:44 -0500
Date: Thu, 5 Jan 2006 19:01:15 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
In-Reply-To: <43BBADD5.3070706@cosmosbay.com>
Message-ID: <Pine.LNX.4.62.0601051900440.973@qynat.qvtvafvgr.pbz>
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com>
 <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com>
 <43BB1178.7020409@cosmosbay.com> <p733bk4z2z0.fsf@verdi.suse.de>
 <43BBADD5.3070706@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Eric Dumazet wrote:

> Date: Wed, 04 Jan 2006 12:13:25 +0100
> From: Eric Dumazet <dada1@cosmosbay.com>
> To: Andi Kleen <ak@suse.de>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
> 
> Andi Kleen a écrit :
>> Eric Dumazet <dada1@cosmosbay.com> writes:
>>> 1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits
>>> platforms, lowering kmalloc() allocated space by 50%.
>> 
>> It should be probably a kmem_cache_alloc() instead of a kmalloc
>> in the first place anyways. This would reduce fragmentation.
>
> Well in theory yes, if you really expect thousand of tasks running...
> But for most machines, number of concurrent tasks is < 200, and using a 
> special cache for this is not a win.

is it enough of a win on machines with thousands of concurrent tasks that 
it would be a useful config option?

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

