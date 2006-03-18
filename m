Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWCRGZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWCRGZI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 01:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbWCRGZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 01:25:08 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:42663 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S1751997AbWCRGZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 01:25:05 -0500
Message-ID: <441BA74E.7090407@myrealbox.com>
Date: Fri, 17 Mar 2006 22:23:10 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: puting task to TASK_INTERRUPTIBLE before adding it to an wait
   queue
References: <e7aeb7c60603161431m6d873520r2b6754e115e26f80@mail.gmail.com> <1142582503.7973.15.camel@homer>
In-Reply-To: <1142582503.7973.15.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Fri, 2006-03-17 at 00:31 +0200, Yitzchak Eidus wrote:
> 
>>the function worker_thread in kernel 2.6.15.6  first put the task to
>>TASK_INTERRUPTIBLE and only then add itself to an wait queue:
>>	set_current_state(TASK_INTERRUPTIBLE);
>>	while (!kthread_should_stop()) {
>>		add_wait_queue(&cwq->more_work, &wait);
> 
> 
> See dusty old archives...

Also, preempted tasks get rescheduled regardless of state:

http://www.cs.helsinki.fi/linux/linux-kernel/2003-15/0402.html

--Andy
