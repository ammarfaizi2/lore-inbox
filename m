Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbUKWFGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbUKWFGm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbUKWFBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 00:01:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:51943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262223AbUKWE6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 23:58:49 -0500
Message-ID: <41A2C2F7.8080003@osdl.org>
Date: Mon, 22 Nov 2004 20:56:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Darren Hart <darren@dvhart.com>
CC: =?ISO-8859-1?Q?C=EDcero?= <cicero.mota@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Information about move_tasks return
References: <ce70c49041122041623155a@mail.gmail.com> <1101139344.21252.65.camel@farah.beaverton.ibm.com>
In-Reply-To: <1101139344.21252.65.camel@farah.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart wrote:
> On Mon, 2004-11-22 at 08:16 -0400, Cícero wrote:
> 
>>hi
>>
>>I am looking for the result of the function  move_task in
>>
>>kernel/sched.c , I have observed that it returns an int value and as I
>>print it with printk.
>>
>>I have created a int variable 'results_move_task' which capture the result of
>>
>>move_task and I print it with printk("%d",results_move_task); I
>>observed that it often returns the value '1' and sometimes it returns
>>'2' or more. Is it really correct?
> 
> 
> /*
>  * move_tasks tries to move up to max_nr_move tasks from busiest to this_rq,
>  * as part of a balancing operation within "domain". Returns the number of
>  * tasks moved.
>  *
>  * Called with both runqueues locked.
>  */
> static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
>                       unsigned long max_nr_move, struct sched_domain *sd,
>                       enum idle_type idle)
> {
> ...
> 
> 
> So as the "documentation" states, it returns the number of tasks
> actually moved.  For instance, The balancing code may request 4 tasks be
> moved, but for various reasons, only 2 were actually moved to other
> CPUs, move_tasks() would return 2.

and there are a few cases/places where the move target count
is limited to only 1.

-- 
~Randy
