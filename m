Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbTFBX50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 19:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbTFBX50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 19:57:26 -0400
Received: from dyn-ctb-210-9-244-45.webone.com.au ([210.9.244.45]:4613 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264222AbTFBX5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 19:57:25 -0400
Message-ID: <3EDBE776.2020806@cyberone.com.au>
Date: Tue, 03 Jun 2003 10:10:30 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: [PATCH][CFT] blk-fair-batches vs 2.4.20-rc6
References: <Pine.LNX.4.44.0306020919530.29823-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0306020919530.29823-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:

> On Mon, 2 Jun 2003, Nick Piggin wrote:
>
>> Previously:
>> * request queue fills up
>> * process 1 calls get_request, sleeps
>> * a couple of requests are freed
>> * process 2 calls get_request, proceeds
>> * a couple of requests are freed
>> * process 2 calls get_request, proceeds
>> ...
>
>
> In an early 2.4 kernel I've caught a few processes sleeping
> in get_request_wait for 5 minutes or so, while other processes
> were allocating new requests at exactly the speed they were
> processed.
>
> Of course, a patch to fix the problem was shot down due to
> lower dbench performance ... good thing Andrew Morton has
> more sense than that.

Mmm... unfortunately nearly everywhere >1 threads compete for
a resource, it comes down to throughput vs latency.

I think this patch is valid. It does not seem to be the sole
cause of the hangs though... err, and its against 21-rc6,
sorry :P

