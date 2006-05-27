Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932779AbWE0BAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbWE0BAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 21:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWE0BAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 21:00:45 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:47097 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932779AbWE0BAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 21:00:44 -0400
Message-ID: <4477A4B9.6040702@bigpond.net.au>
Date: Sat, 27 May 2006 11:00:41 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <5du07dclws.fsf@attruh.keh.iki.fi>
In-Reply-To: <5du07dclws.fsf@attruh.keh.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 27 May 2006 01:00:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kari Hurtta wrote:
> Peter Williams <pwil3058@bigpond.net.au> writes in gmane.linux.kernel:
> 
>> This patch implements hard CPU rate caps per task as a proportion of a
>> single CPU's capacity expressed in parts per thousand.
> 
>> + * Require: 1 <= new_cap <= 1000
>> + */
>> +int set_cpu_rate_hard_cap(struct task_struct *p, unsigned int new_cap)
>> +{
>> +	int is_allowed;
>> +	unsigned long flags;
>> +	struct runqueue *rq;
>> +	int delta;
>> +
>> +	if (new_cap > 1000 && new_cap > 0)
>> +		return -EINVAL;
> 
> That condition looks wrong.

It certainly does.

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
