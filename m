Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbTAJJ3c>; Fri, 10 Jan 2003 04:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTAJJ3c>; Fri, 10 Jan 2003 04:29:32 -0500
Received: from h-64-105-35-49.SNVACAID.covad.net ([64.105.35.49]:28288 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264614AbTAJJ3b>; Fri, 10 Jan 2003 04:29:31 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 10 Jan 2003 01:38:03 -0800
Message-Id: <200301100938.BAA03617@baldur.yggdrasil.com>
To: maxk@qualcomm.com
Subject: Re: Another idea for simplifying locking in kernel/module.c
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jan 2003, Max Krasnyansky wrote:
>At 12:53 AM 1/7/2003 -0800, Adam J. Richter wrote:
>>I wrote:
>>>        Here is a way to replace all of the specialized "stop CPU"
>>>locking code in kernel/module.c with an rw_semaphore by using
>>>down_read_trylock in try_module_get() and down_write when beginning to
>>>unload the module.
>>>
>>>        The following UNTESTED patch, a net deletion of 136 lines,
>>
>>        I am running that patch now on two computers.  It seems to
>>be OK.
>>
>>        Rusty, I'd be interested in knowing what you think of the
>>patch (likewise for other lkml readers).

>We have to be able to call try_module_get() from interrupt context.

	Where?  Why?  Please show me one or more examples.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
