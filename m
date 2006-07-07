Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWGGFWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWGGFWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 01:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWGGFWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 01:22:12 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:50340 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S1750925AbWGGFWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 01:22:11 -0400
Message-ID: <2513.203.217.29.133.1152250423.squirrel@203.217.29.133>
In-Reply-To: <20060706210805.b9e952ca.rdunlap@xenotime.net>
References: <3306.58.105.227.226.1152244539.squirrel@58.105.227.226>
    <20060706210805.b9e952ca.rdunlap@xenotime.net>
Date: Fri, 7 Jul 2006 15:33:43 +1000 (EST)
Subject: Re: Module link
From: yh@bizmail.com.au
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy. Let me clarify it.

I have a driver module (NewSerialModule.ko) and I build it for module
load. This driver module uses i2c functions. It was fine to init this
module in kernel 2.4 as the i2c functions are exported in i2c Makefile.

In kernel 2.6, I loaded this module and got NULL point exception. I
checked the module map, all i2c functions are not linked. I also checked
i2c, there is no export for i2c in kernel 2.6. So, my question is how can
I link the dirvers/i2c to my driver module in drivers/char directory? How
to export a directory to be a library such as i2c? In general, how to link
another directory functions by a module in kernel 2.6?

Thank you.

Jim




> On Fri, 7 Jul 2006 13:55:39 +1000 (EST) yh@bizmail.com.au wrote:
>
>> Thanks for all helps. The module can now be loaded. There are some other
>> issues as descripbled as follows:
>>
>> 1. The module I used links to i2c drivers. It works fine in kernel 2.4
>> after "insmod NewModule.o", but now it has a NULL point in kernel 2.6
>> when
>> to init it. It seems that the i2c driver is not linked in the module.
>> How
>> can I link an i2c to my driver module?
>
> Sorry, I don't understand the question.
> Where is the driver source code?
>
>> 2. In kernel 2.4, when I call "insmod NewModule.o", the insmod can find
>> the path of the NewModule.o and to init the module. In 2.6 kernel, the
>> "insmod NewModule.ko" does not know the path, so I have to specify the
>> path explicitly as "insmod
>> /lib/modules/2.6.8.1/kernel/drivers/char/NewModule.ko" to make it work.
>> I
>> guess the above problem in question 1 may also related to this issue.
>> What
>> did I wrong here?
>
> In module-init-tools, insmod requires full path and modprobe
> does not (it searches for the file).
>
> ---
> ~Randy
>


