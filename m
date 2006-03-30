Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWC3QYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWC3QYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWC3QYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:24:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:62928 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932194AbWC3QYl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:24:41 -0500
Message-ID: <442C0646.3090308@watson.ibm.com>
Date: Thu, 30 Mar 2006 11:24:38 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, tgraf@suug.ch, hadi@cyberus.ca
Subject: Re: [Patch 5/8] generic netlink interface for delay accounting
References: <442B271D.10208@watson.ibm.com> <442B2BB6.9020309@watson.ibm.com> <20060329210406.08d1c929.akpm@osdl.org> <20060330061005.GA18387@in.ibm.com>
In-Reply-To: <20060330061005.GA18387@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

>Hi, Andrew
>
>
>On Wed, Mar 29, 2006 at 09:04:06PM -0800, Andrew Morton wrote:
>  
>
>>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>    
>>
>>>delayacct-genetlink.patch
>>>
>>>Create a generic netlink interface (NETLINK_GENERIC family),
>>>called "taskstats", for getting delay and cpu statistics of
>>>tasks and thread groups during their lifetime and when they exit.
>>>
>>>
>>>
>>>      
>>>
<snip>

>>>+
>>>+static int __init taskstats_init(void)
>>>+{
>>>+	if (genl_register_family(&family))
>>>+		return -EFAULT;
>>>      
>>>
>>EFAULT?
>>    
>>
>
>It shouldn't be (Shailabh please comment). We will fix it.
>  
>
Sorry, it should return the  value returned by genl_register_family.

I copied the code from net/tipc/netlink.c
where a similarly erroneous errno is being used. We'll submit a fix
for that as well.

--Shailabh
