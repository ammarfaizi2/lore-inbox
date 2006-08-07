Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWHGH2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWHGH2k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 03:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWHGH2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 03:28:40 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:12315 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751131AbWHGH2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:28:39 -0400
Message-ID: <44D6EBEF.9010804@sw.ru>
Date: Mon, 07 Aug 2006 11:29:51 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, mingo@elte.hu,
       nickpiggin@yahoo.com.au, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with Resource
 Management - A cpu  controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <44D35794.2040003@sw.ru> <44D367F3.8060108@watson.ibm.com>
In-Reply-To: <44D367F3.8060108@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>3. I also don't understand why normal binary interface like system call
>>is not used.
>>  We have set_uid, sys_setrlimit and it works pretty good, does it?
> 
> 
> If there are no hierarchies, a syscall interface is fine since the namespace
> for the task-group is flat (so one can export to userspace either a number or a
> string as a handle to that task-group for operations like create, delete,
> set limit, get usage, etc)
syscalls work fine here as well. you need to specify parent_id and new_id for creation.
that's all. we have such an interfaces for heirarchical CPU scheduler.

> A filesystem based interface is useful when you have hierarchies (as resource
> groups and cpusets do) since it naturally defines a convenient to use
> hierarchical namespace.
but it is not much convinient for applications then.

Thanks,
Kirill

