Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268005AbTAIUdE>; Thu, 9 Jan 2003 15:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268004AbTAIUdE>; Thu, 9 Jan 2003 15:33:04 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:31104 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268005AbTAIUdD>; Thu, 9 Jan 2003 15:33:03 -0500
Message-Id: <5.1.0.14.2.20030109124002.079f1228@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 09 Jan 2003 12:41:39 -0800
To: "Adam J. Richter" <adam@yggdrasil.com>, rusty@rustcorp.com.au
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Another idea for simplifying locking in kernel/module.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301070853.AAA04065@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:53 AM 1/7/2003 -0800, Adam J. Richter wrote:
>I wrote:
>>        Here is a way to replace all of the specialized "stop CPU"
>>locking code in kernel/module.c with an rw_semaphore by using
>>down_read_trylock in try_module_get() and down_write when beginning to
>>unload the module.
>>
>>        The following UNTESTED patch, a net deletion of 136 lines,
>
>        I am running that patch now on two computers.  It seems to
>be OK.
>
>        Rusty, I'd be interested in knowing what you think of the
>patch (likewise for other lkml readers).

We have to be able to call try_module_get() from interrupt context.

Max

