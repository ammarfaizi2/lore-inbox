Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWFFJck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWFFJck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWFFJck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:32:40 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:65432 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932097AbWFFJcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:32:39 -0400
Message-ID: <44854ADB.4040006@sw.ru>
Date: Tue, 06 Jun 2006 13:28:59 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Sam Vilain <sam@vilain.net>,
       Kirill Korotaev <dev@openvz.org>,
       Peter Williams <pwil3058@bigpond.net.au>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, Srivatsa <vatsa@in.ibm.com>,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <4484ABF9.50503@vilain.net> <44853BCA.4010009@sw.ru> <200606061913.35340.kernel@kolivas.org>
In-Reply-To: <200606061913.35340.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Yes but interactive admin processes will still get a large bonus
>>>relative to the apache processes so you can still log in and kill the
>>>apache storm off even with very large loads.
>>
>>And how do you plan to manage it: to log in every time when apache works
>>too much and kill processes? The managabiliy of such solutions sucks..
> 
> What a strange discussion. I simply impose limits on processes and connections 
> on my grossly underpowered server.
this works when you are an administrator of a single linux machine. Now 
imagine, you can run Virtual Environments (VE) each with it's own root 
and users. You can't and don't want to control what and how people are 
running. Sure, you limit the number of processes, but usually this won't 
be less then 50-100 processes per VE, so a single VE can lead to 50 
tasks in a running state and the total number of tasks in the system can 
be as high as 10,000. People can run setiathome or any other sh$t which 
consumes CPU, but the result is always the same - huge amount of running 
tasks leads to overall slowdown. So this is the case when you want to 
limits _users_ or VE, not _single_ tasks. I don't think you will succeed 
in managing 10,000 tasks when 100 active users change the load on the 
day basis.

Hope, it become more clear.

Thanks,
Kirill
