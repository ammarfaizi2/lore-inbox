Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbVIBV0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbVIBV0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbVIBV0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:26:15 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:63054 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161054AbVIBV0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:26:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5foVIg+WQzS/ktGU70KaGqtVRIzeoGcWdh0e3bCBjFs6skdCF3Nvs1kz7KCqQXvPOkIdzkU0MnYjcz9vAMhFg+YeUvFRqJiBZ3a8x5Bfm+UniV1RYhJlfw5qubSIj60h9Gic8sZhl5Ie+l9/kH2E9Irqh8YCL9lJc2LGvVO8NxI=  ;
Message-ID: <4318C395.1080203@yahoo.com.au>
Date: Sat, 03 Sep 2005 07:26:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 2/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au> <4317F136.4040601@yahoo.com.au> <Pine.LNX.4.62.0509021123290.15836@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509021123290.15836@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Fri, 2 Sep 2005, Nick Piggin wrote:
> 
> 
>>Implement atomic_cmpxchg for i386 and ppc64. Is there any
>>architecture that won't be able to implement such an operation?
> 
> 
> Something like that used to be part of the page fault scalability 
> patchset. You contributed to it last year. Here is the latest version of 
> that. May need some work though.
> 

Thanks Christoph, I think this will be required to support 386.
In the worst case, we could provide a fallback path and take
->tree_lock in pagecache lookups if there is no atomic_cmpxchg,
however I would much prefer all architectures get an atomic_cmpxchg,
and I think it should turn out to be a generally useful primitive.

I may trim this down to only provide what is needed for atomic_cmpxchg
if that is OK?

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
