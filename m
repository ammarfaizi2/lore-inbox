Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263933AbTIIEQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 00:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTIIEQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 00:16:09 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:51972
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263933AbTIIEQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 00:16:03 -0400
Message-ID: <3F5D53B9.8050004@cyberone.com.au>
Date: Tue, 09 Sep 2003 14:14:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Steven Pratt <slpratt@austin.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <3F5D023A.5090405@austin.ibm.com> <200309091210.06333.kernel@kolivas.org> <200309091216.32964.kernel@kolivas.org> <200309091231.48709.kernel@kolivas.org>
In-Reply-To: <200309091231.48709.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Tue, 9 Sep 2003 12:16, Con Kolivas wrote:
>
>>On Tue, 9 Sep 2003 12:10, Con Kolivas wrote:
>>
>>>On Tue, 9 Sep 2003 08:56, Andrew Morton wrote:
>>>
>>>>Steven Pratt <slpratt@austin.ibm.com> wrote:
>>>>
>>>>>For specjbb things are looking good from a throughput point of view.
>>>>>...
>>>>>Volanomark, on the other hand is still off by quite a bit from test4
>>>>>stock
>>>>>
>>>>hmm, thanks.
>>>>
>>>>I'm not sure that volanomark is very representative of any real-world
>>>>thing.
>>>>
>>>>
>>>>>...
>>>>>If thre is any particular patch/tree combination you would like me to
>>>>>try out, please let me know and I will see if I can get the results
>>>>>for you.
>>>>>
>>>>Could we please see test5 versus test5 plus Andrew's patch?
>>>>
>>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-tes
>>>>t4 /2 .6.0-test4-mm6/broken-out/sched-CAN_MIGRATE_TASK-fix.patch
>>>>
>>>>and if you have time, also test5 plus sched-CAN_MIGRATE_TASK-fix.patch
>>>>plus
>>>>
>>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-tes
>>>>t4 /2
>>>>.6.0-test4-mm6/broken-out/sched-balance-fix-2.6.0-test3-mm3-A0.patch
>>>>
>>>Interestingly enough this drops the volano results the same proportion as
>>>Ingo's A3 patch. 11000 ->10400 throughput with same idle, but more
>>>schedule().
>>>
>>>I've posted some results for test5 volano and test5-A0 here:
>>>http://kernel.kolivas.org/2.5/volano
>>>
>>>More testing underway.
>>>
>>Correction sorry: These changes were due to
>>sched-CAN_MIGRATE_TASK-fix.patch and the test results say
>>volano-results-2.6.0-test5-A0-*
>>
>
>Further testing shows the patch: sched-balance-fix-2.6.0-test3-mm3-A0.patch to 
>have no effect on volano results by itself. 
>

Hi Con,
Any chance you could give this
http://www.kerneltrap.org/~npiggin/v14/sched-rollup-nopolicy-v14.gz
a try? It should apply against test5.


