Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWGAEqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWGAEqS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 00:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWGAEqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 00:46:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:975 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932181AbWGAEqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 00:46:17 -0400
Message-ID: <44A5FE17.1000607@garzik.org>
Date: Sat, 01 Jul 2006 00:46:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ltuikov@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
References: <20060630181915.638166c2.akpm@osdl.org>	<20060701012658.14951.qmail@web31803.mail.mud.yahoo.com> <20060630183744.310f3f0d.akpm@osdl.org>
In-Reply-To: <20060630183744.310f3f0d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Luben Tuikov <ltuikov@yahoo.com> wrote:
>>> We do occasionally hit task_struct.comm[] truncation, when people use
>>> "too-long-a-name%d" for their kernel thread names.  But we seem to manage.
>> It would be especially helpful if you want to name a task thread
>> the NAA IEEE Registered name format (16 chars, globally unique), for things
>> like FC, SAS, etc.  This way you can identify the task thread with
>> the device bearing the NAA IEEE name.
>>
>> Currently just last character is cut off, since TASK_COMM_LEN is 15+1.
>>
>> I think incrementing it would be a good thing, plus other things
>> may want to represent 8 bytes as a character array to be the name
>> of a task thread.
> 
> OK, that's a reason.  Being able to map a kernel thread onto a particular
> device is useful.

But will it wind up this way, when the does-not-exist-yet-upstream code 
appears?

I would think it would make more sense to increase the size of the key 
task structure only when there are justified, merged users in the kernel.

	Jeff



