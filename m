Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbULIK3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbULIK3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 05:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbULIK3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 05:29:34 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:17558 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261494AbULIK3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 05:29:33 -0500
Message-ID: <41B82909.4040302@cyberone.com.au>
Date: Thu, 09 Dec 2004 21:29:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
CC: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
References: <20041202231837.GB15185@mail.muni.cz> <20041202161839.736352c2.akpm@osdl.org> <20041203121129.GC27716@mail.muni.cz> <41B6343A.9060601@cyberone.com.au> <20041207225932.GB12030@mail.muni.cz> <41B63738.2010305@cyberone.com.au> <20041208111832.GA13592@mail.muni.cz> <41B6E415.4000602@cyberone.com.au> <20041208131442.GF13592@mail.muni.cz> <41B81254.4040107@cyberone.com.au> <20041209090245.GB15537@mail.muni.cz>
In-Reply-To: <20041209090245.GB15537@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lukas Hejtmanek wrote:

>On Thu, Dec 09, 2004 at 07:52:36PM +1100, Nick Piggin wrote:
>
>>>32MB seems to be ok but it will require further testing to be sure.
>>>
>>>
>>>
>>Seems pretty excessive - although maybe your increased socket buffers and
>>txqueuelen are contributing?
>>
>
>Yes they are. Without increasing it is just ok. But increasing is ok in 2.6.6.
>
>

Perhaps they weren't working properly in 2.6.6, or something else is 
buggy in
2.6.9. 16MB in 2.6.9 should definitely give a a larger atomic reserve 
than 900K
in 2.6.6... so if it isn't an issue with network buffer behaviour, then the
only other possibility AFAIKS is that page reclaim latency or efficiency has
got much worse. This would be unlikely as it should cause problems and
regressions on other workloads.

