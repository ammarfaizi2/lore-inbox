Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWA0ITm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWA0ITm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 03:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbWA0ITm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 03:19:42 -0500
Received: from highlandsun.propagation.net ([66.221.212.168]:3595 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1030292AbWA0ITl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 03:19:41 -0500
Message-ID: <43D9D79D.9000402@symas.com>
Date: Fri, 27 Jan 2006 00:19:41 -0800
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9a1) Gecko/20060115 SeaMonkey/1.5a Mnenhy/0.7.3.0
MIME-Version: 1.0
To: davids@webmaster.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKOEBHJLAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOEBHJLAB.davids@webmaster.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
>>> 	Third, there's the ambiguity of the standard. It says the "sceduling
>>> policy" shall decide, not that the scheduler shall decide. If
>>> the policy is
>>> to make a conditional or delayed decision, that is still perfectly valid
>>> policy. "Whichever thread requests it first" is a valid
>>> scheduler policy.
>>>       

>> I am not debating what the policy can decide. Merely the set of choices
>> from which it may decide.
>>     
>
> 	Which is a restriction not found in the standard. A "policy" is a way of
> deciding, not a decision. Scheduling policy can be to let whoever asks first
> get it.
>   

If we just went with "whoever asks first" then clearly one of the 
blocked threads asked before the unlocker made its new request. You're 
arguing for my point, then.

Other ambiguities aside, one thing is clear - a decision is triggered by 
the unlock. What you seem to be arguing is the equivalent of saying that 
the decision is made based on the next lock operation. The spec doesn't 
say that mutex_lock is to behave this way. Why do you suppose that is? 
Perhaps you should raise this question with the Open Group.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

