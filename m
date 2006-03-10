Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWCJOws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWCJOws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 09:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWCJOws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 09:52:48 -0500
Received: from networks.syneticon.net ([213.239.212.131]:12450 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP
	id S1751499AbWCJOwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 09:52:47 -0500
Message-ID: <441192AC.2050008@wpkg.org>
Date: Fri, 10 Mar 2006 15:52:28 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mail/News 1.5 (X11/20060225)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
References: <441180DD.3020206@wpkg.org> <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Subject: can I bring Linux down by running "renice -20 cpu_intensive_process"?
>>
> Depends on what the cpu_intensive_process does. If it tries to allocate 
> lots of memory, maybe. If it's _just_ CPU (as in `perl -e '1 while 1'`), 
> you get a chance that you can input some commands on a terminal to kill it.
> SCHED_FIFO'ing or SCHED_RR'ing such a process is sudden death of course.
> 
>> I have a Linux server (kernel 2.6.8.1 + Linux RAID1) which is a "backup"
>> machine: it gets the files from other servers, compresses it, writes to the
>> tape, checks md5sums etc.
>>
>> It's been running for quite a bit, no problems with stability so far.
>>
> Why would you need it to run at -20 anyway?

Hmm, I hoped md5sum 30_gig would finish before I finish work to start 
writing new data on tape...


>> As I restarted the machine, I saw that the logging ends few minutes after I
>> changed the priority of md5sum to -20.
>>
>> So here is my question: is it possible to bring down the machine by simply
>> doing "renice -20 cpu_intensive_process"?
>>
> In case of md5sum: it should not be. At least you should have been able to 
> unblank the console pressing any key, or have sysrq available.

So in my case it just died for some reason (the console didn't unblank; 
the md5sum process should have ended long time ago).
On the other hand, the machine was responding to pings, and the ports 
were open, so it wasn't totally dead.

Hmm, so we can just speculate what it was.


-- 
Tomasz Chmielewski
