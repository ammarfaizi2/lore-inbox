Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUDNSK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUDNSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:10:57 -0400
Received: from mail.tmr.com ([216.238.38.203]:32516 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261505AbUDNSKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:10:55 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Benchmarking objrmap under memory pressure
Date: Wed, 14 Apr 2004 14:11:34 -0400
Organization: TMR Associates, Inc
Message-ID: <c5jumv$men$1@gatekeeper.tmr.com>
References: <1130000.1081841981@[10.10.2.4]> <20040413005111.71c7716d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1081966111 22999 192.168.12.100 (14 Apr 2004 18:08:31 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20040413005111.71c7716d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> 
>>UP Athlon 2100+ with 512Mb of RAM. Rebooted clean before each test
>>then did "make clean; make vmlinux; make clean". Then I timed a
>>"make -j 256 vmlinux" to get some testing under mem pressure. 
>>
>>I was trying to test the overhead of objrmap under memory pressure,
>>but it seems it's actually distinctly negative overhead - rather pleasing
>>really ;-) 
>>
>>2.6.5
>>225.18user 30.05system 6:33.72elapsed 64%CPU (0avgtext+0avgdata 0maxresident)k
>>0inputs+0outputs (37590major+2604444minor)pagefaults 0swaps
>>
>>2.6.5-anon_mm
>>224.53user 26.00system 5:29.08elapsed 76%CPU (0avgtext+0avgdata 0maxresident)k
>>0inputs+0outputs (29127major+2577211minor)pagefaults 0swaps
> 
> 
> A four second reduction in system time caused a one minute reduction in
> runtime?  Pull the other one ;)

I was looking at the pagefault counts, myself. I'd like to see disk io 
counts for each run, that sometimes brings enlightenment. Maybe do 20 
sec counts with diorate or some such.
(http://pages.prodigy.net/davidsen/ if you don't have your own favorite 
tool)
> 
> Average of five runs, please...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
