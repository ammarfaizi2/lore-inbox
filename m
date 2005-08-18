Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVHRPOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVHRPOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHRPOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:14:05 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:5564 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932236AbVHRPOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:14:04 -0400
X-ORBL: [64.108.208.122]
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC0830FE03@cof110avexu4.global.avaya.com>
References: <21FFE0795C0F654FAD783094A9AE1DFC0830FE03@cof110avexu4.global.avaya.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <39eeb491a777cbc24b6406595b21fb15@mindspring.com>
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, "Mike Galbraith" <efault@gmx.de>
From: Hal Wigoda <hwigoda@mindspring.com>
Subject: Re: Debugging kernel semaphore contention and priority  inversion
Date: Thu, 18 Aug 2005 10:13:50 -0500
To: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

will netconsole install on mandriva?


On Aug 18, 2005, at 9:50 AM, Davda, Bhavesh P ((Bhavesh)) wrote:

>> -----Original Message-----
>> From: Mike Galbraith [mailto:efault@gmx.de]
>> Sent: Wednesday, August 17, 2005 11:10 PM
>> At 09:43 PM 8/17/2005 -0600, you wrote:
>>>>
>>>> Have you tried sysrq t?  See the Documentation/sysrq.txt file.
>>>
>>> This is a headless system.
>>
>> You could try netconsole.
>
> Haven't heard of it before. Will look into it. But I doubt it will help
> pinpoint the semaphore holder, if all I can do is sysrq stuff.
>
>>
>>>>
>>>> How stuck is the system?
>>>>
>>>> Keith
>>>
>>> Very. Only pingable, but can't login via
>> telnet/ssh/anything. Reason is
>>> the same reason the low priority mystery task is unable to run and
>>> release the held semaphore.
>>
>> (hmm.  I'm obviously missing some original context here)
>>
>> Sounds like there must be another player who is RT prio + spinning.
>>
>>          -Mike
>
> Very good! Yes, I left out that piece of detail in my original posting.
> There is a real low priority (4) SCHED_FIFO (hence still higher than 
> any
> SCHED_OTHER) task spinning. But it is not the semaphore holder. I am
> trying to identify which kernel thread (because that's most likely)
> running at SCHED_OTHER real low priority (too nice) is holding the
> semaphore, locking out a priority 50 SCHED_FIFO task in its sys_write()
> as a result.
>
> Thanks
>
> - Bhavesh
>
> Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
> 1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
> Voice/Fax: 303.538.4438 | bhavesh@avaya.com
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

