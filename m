Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTIGG3f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 02:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbTIGG3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 02:29:35 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:44294
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262245AbTIGG3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 02:29:33 -0400
Message-ID: <3F5AD03E.5070506@cyberone.com.au>
Date: Sun, 07 Sep 2003 16:29:18 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rml@tech9.net, jyau_kernel_dev@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>	<1062878664.3754.12.camel@boobies.awol.org>	<3F5ABD3A.7060709@cyberone.com.au> <20030906231856.6282cd44.akpm@osdl.org>
In-Reply-To: <20030906231856.6282cd44.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>So it is quite sad that the scheduler in 2.6 is
>> sitting there doing nothing but waiting to be obsoleted, while Con's
>> good (and begnin) scheduler patches are waiting around and getting
>> less than 1% of the testing they need.
>>
>
>My concern is the (large) performance regression with specjbb and
>volanomark, due to increased idle time.
>
>We cannot just jam all this code into Linus's tree while crossing our
>fingers and hoping that something will turn up to fix this problem. 
>Because we don't know what causes it, nor whether we even _can_ fix it.
>
>So this is the problem which everyone who is working on the CPU scheduler
>should be concentrating on, please.
>

IIRC my (equivalent to Andrew's CAN_MIGRATE) patch fixed this. There was 
still a small (~8%?) performance regression, but idle times were on par 
with -linus. I don't have easy access to a largeish NUMA box, so I
can't do much more.


