Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUBHBX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUBHBW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:22:29 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:30089 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261872AbUBHBWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:22:11 -0500
Message-ID: <40258F21.30209@cyberone.com.au>
Date: Sun, 08 Feb 2004 12:21:37 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <20040207095057.GS19011@krispykreme> <200402080040.i180eY811893@owlet.beaverton.ibm.com> <20040208011221.GV19011@krispykreme>
In-Reply-To: <20040208011221.GV19011@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anton Blanchard wrote:

> 
>Hi,
>
>
>>The current imbalance code rounds up to 1, meaning that we'll often
>>see an "imbalance" of 1 even when it's 1 to 0 and just been moved.
>>Did you see these results even with Martin's patch to not round up to 1?
>>
>
>Indeed Martins patch does fix the problem:
>
>cpu    user  system    idle             cpu    user  system    idle
>cpu0      0       0     100             cpu1      0       0     100
>cpu2      0       0     100             cpu3      0       0     100
>cpu4      0       0     100             cpu5      0       0     100
>cpu6      0       0     100             cpu7      0       0     100
>cpu8      0       0     100             cpu9      0       0     100
>cpu10     0       0     100             cpu11     0       0     100
>cpu12     0       0     100             cpu13   100       0       0
>cpu14     0       0     100             cpu15     0       0     100
>
>My current tree has your patch and Martins patch. So far its looking
>good.
>
>

Rick's being the one I sent you?

Does active balancing still work? Ie. get two processes running on the
same physical CPU and see if one is migrated away.

