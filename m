Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTEASWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbTEASWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:22:04 -0400
Received: from dyn-ctb-210-9-246-153.webone.com.au ([210.9.246.153]:56848 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261193AbTEASWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:22:03 -0400
Message-ID: <3EB168A3.4060207@cyberone.com.au>
Date: Fri, 02 May 2003 04:34:11 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: tomlins@cam.org
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68-mm3 with contest
References: <fa.i2rq9k6.40evjg@ifi.uio.no> <fa.hp8a369.1t0qqpt@ifi.uio.no> <20030501115221.A85BC11B0B@oscar.casa.dyndns.org>
In-Reply-To: <20030501115221.A85BC11B0B@oscar.casa.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:

>Andrew Morton wrote:
>
>
>>Con Kolivas <kernel@kolivas.org> wrote:
>>
>>>All the io-write based loads were affected.
>>>
>>Yup.  Mainly because the large queue increases truncate latencies.
>>
>
>Are there loads that do benefit from large queues?  If so, does it make
>sense to use truncate impact (something like a decaying average of truncate
>time per interval) to control the size of the queues on the fly?
>
I'll post some more benchmarks, but I have found that loads with
lots of IO streams. Those with more than about 1/2 as many IO streams
as request slots start to show improvements. I don't think changing
the size of the queues on the fly would be any good. They can be
made runtime tunable quite easily now, which is a good bad solution.

