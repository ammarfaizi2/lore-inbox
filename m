Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbUBZUKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUBZUKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:10:21 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:38275 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262836AbUBZUKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:10:16 -0500
Message-ID: <403E53C3.9090106@tmr.com>
Date: Thu, 26 Feb 2004 15:14:59 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <1tfy0-7ly-29@gated-at.bofh.it> <1thzJ-A5-13@gated-at.bofh.it> <1tjrN-2m5-1@gated-at.bofh.it> <1tjLa-2Ab-9@gated-at.bofh.it> <1tlaf-3OY-11@gated-at.bofh.it> <1tljX-3Wf-5@gated-at.bofh.it> <1tznd-CP-35@gated-at.bofh.it> <1tzQe-10s-25@gated-at.bofh.it>
In-Reply-To: <1tzQe-10s-25@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Shailabh Nagar wrote:
> 
>>>> Mike Fedyk wrote:
>>>>
>>>>> Better would be to have the kernel tell the daemon whenever a 
>>>>> process in exec-ed, and you have simplicity in the kernel, and 
>>>>> policy in user space.
>>
>>
>>
>>
>> As it turns out, one can still use a fairly simple in-kernel module 
>> which provides a *mechanism* for effectively changing a process' 
>> entitlement while retaining the policy component in userland.
> 
> 
> How much code could be removed if CKRM triggered a userspace process to 
> perform the operations required?

One other interesting question is what would happen if the userspace 
program didn't run, died, etc. Or set some ill-behaved other user 
program to a higher priority and the other program did a DoS 
(intentional or not)?

I don't like the whole idea, but I like it even less with a user program 
requiring context switches on scheduling.

