Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUDMH4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 03:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUDMH4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 03:56:14 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:42116 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263164AbUDMH4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 03:56:09 -0400
Message-ID: <407B9D15.2010804@yahoo.com.au>
Date: Tue, 13 Apr 2004 17:56:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Fitzner <kfitzner@excelcia.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm5
References: <20040412221717.782a4b97.akpm@osdl.org> <407B990A.8050407@excelcia.org>
In-Reply-To: <407B990A.8050407@excelcia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Fitzner wrote:
> Andrew Morton wrote:
> 
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm5/ 
>>
>>
>> - More CPU scheduler work.  Hopefully this kernel will now address the
>>   regressions that a few people have noted on certain workloads.  We 
>> appear to
>>   be getting close.
> 
> 
> Regressions... from the context, I'm assuming you're not talking
> regression errors here?  I'm assuming these are performance issues?  I
> see a 3.5% drop in compiling speed between 2.4.24 and 2.6.5 on a dual
> Athlon workstation.  I'll test this kernel happily if the scheduler
> tweaks are intended to address this.
> 

Hi Kurt,
The context was actually sched-domains regressions vs numasched,
which might possibly arise in any SMP (even simple dual) system.
So in this case we are interested in -mm regressions compared to
the official 2.6 tree.

2.6 regressions versus 2.4 are still interesting, but a 3.5% drop
in kernel compiling is probably due to HZ=1000 and rmap, although
I think you can expect improvements in rmap overhead soon... try
2.6.5-aa5 if you are interested.
