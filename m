Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWH3VqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWH3VqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWH3VqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:46:23 -0400
Received: from mailhub1.otago.ac.nz ([139.80.64.218]:9632 "EHLO
	mailhub1.otago.ac.nz") by vger.kernel.org with ESMTP
	id S932117AbWH3VqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:46:22 -0400
In-Reply-To: <17653.20935.117426.731854@alkaid.it.uu.se>
References: <A2A6BFA6-28FA-4525-8705-31555B5327D2@cs.otago.ac.nz> <17653.20935.117426.731854@alkaid.it.uu.se>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0B111904-6CD0-40D4-85D7-F13CCCA06FAB@cs.otago.ac.nz>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: zhiyi huang <hzy@cs.otago.ac.nz>
Subject: Re: Ultra Sparc T1 port
Date: Thu, 31 Aug 2006 09:46:00 +1200
To: Mikael Pettersson <mikpe@it.uu.se>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> zhiyi huang writes:
>> Hello,
>> I am using a Ubuntu port on Ultra Sparc T1.
>> Linux version 2.6.15-21-sparc64-smp (buildd@artigas) (gcc version
>> 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP Fri Apr 21 17:04:05 UTC 2006
>> I have installed a module in the kernel. It is a RAM device driver.
>> When my application calls ioctl on the device (/dev/dsm), I got the
>> following log message:
>>
>> Aug 29 11:13:20 info-sf-03 kernel: [    3.603348] ioctl32(manager:
>> 18821): Unknown cmd fd(3) cmd(80047f00){00} arg(fffc3934) on /dev/dsm
>>
>> I check my module and found the control has not reached my module
>> yet. I haven't got much clue why it happened and how to fix the
>> problem. It works fine on Linux 2.6.8/i386, by the way.
>> Thanks for help:)
>
> There's a separate mailing list for SPARC Linux.

Thanks. Can anyone direct me to the list address?

>
> In this case, you probably just forgot to set up a ->compat_ioctl()
> method in your device's file ops.
>

Yes, indeed. I don't have that method. Now the control is in my ioctl  
function. My new problem is that I don't know much about  
compat_ioctl. Is there any document about it? The only doc I use is  
Linux Device Driver (online version).
Thanks a lot, Mikael:)

