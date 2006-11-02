Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752538AbWKBNpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbWKBNpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbWKBNpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:45:04 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:61850 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1752538AbWKBNpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:45:01 -0500
Message-ID: <4549F633.9010902@in.ibm.com>
Date: Thu, 02 Nov 2006 19:14:19 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Andrew Morton <akpm@osdl.org>, Thomas Graf <tgraf@suug.ch>,
       Shailabh Nagar <nagar@watson.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] taskstats: factor out reply assembling
References: <20061101182611.GA447@oleg> <45497E75.6050401@in.ibm.com> <20061102132252.GB3387@oleg>
In-Reply-To: <20061102132252.GB3387@oleg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> On 11/02, Balbir Singh wrote:
>> Oleg Nesterov wrote:
>>> +
>>> +	aggr = TASKSTATS_TYPE_AGGR_TGID;
>>> +	if (type == TASKSTATS_TYPE_PID)
>>> +		aggr = TASKSTATS_TYPE_AGGR_PID;
>> How about using
>>
>> aggr = (type == TASKSTATS_TYPE_PID) ? TASKSTATS_TYPE_AGGR_PID  :
>> 				TASKSTATS_TYPE_AGGR_TGID;
> 
> I personally think this is much better. In fact, i did exactly same, but
> then changed it because (I think) CodingStyle police doesn't like '?:'.
> 
> Or it does?
> 
> Oleg.
> 

There is an issue with double assignment if the type is TASKSTATS_TYPE_PID most
of the time. I see the '?' operator in several places in the code.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
