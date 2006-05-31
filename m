Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWEaNM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWEaNM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWEaNMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:12:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:57640 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965011AbWEaNMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:12:55 -0400
Message-ID: <447D95DE.1080903@sw.ru>
Date: Wed, 31 May 2006 17:10:54 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au>
In-Reply-To: <44781167.6060700@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Using a timer for releasing tasks from their sinbin sounds like a  bit
>> of an overhead. Given that there could be 10s of thousands of tasks.
> 
> 
> The more runnable tasks there are the less likely it is that any of them 
> is exceeding its hard cap due to normal competition for the CPUs.  So I 
> think that it's unlikely that there will ever be a very large number of 
> tasks in the sinbin at the same time.
for containers this can be untrue... :( actually even for 1000 tasks (I 
suppose this is the maximum in your case) it can slowdown significantly 
as well.

>> Is it possible to use the scheduler_tick() function take a look at all
>> deactivated tasks (as efficiently as possible) and activate them when
>> its time to activate them or just fold the functionality by defining a
>> time quantum after which everyone is worken up. This time quantum
>> could be the same as the time over which limits are honoured.
agree with it.

Kirill

