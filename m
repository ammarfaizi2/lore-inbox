Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUJFBC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUJFBC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUJFBC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:02:59 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:6227 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266561AbUJFBC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:02:57 -0400
Message-ID: <4163443B.8030103@yahoo.com.au>
Date: Wed, 06 Oct 2004 11:02:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Ingo Molnar'" <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410060042.i960gn631637@unix-os.sc.intel.com> <cone.1097023654.564251.26724.502@pc.kolivas.org>
In-Reply-To: <cone.1097023654.564251.26724.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Should it not be based on the cache flush time? We measure that and set 
> the cache_decay_ticks and can base it on that. What is the 
> cache_decay_ticks value reported in the dmesg of your hardware?
> 

It should be, but the cache_decay_ticks calculation is so crude that I
preferred to use a fixed value to reduce the variation between different
setups.

I once experimented with attempting to figure out memory bandwidth based
on reading an uncached page. That might be the way to go.
