Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267343AbTAGIpV>; Tue, 7 Jan 2003 03:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267344AbTAGIpV>; Tue, 7 Jan 2003 03:45:21 -0500
Received: from h-64-105-35-112.SNVACAID.covad.net ([64.105.35.112]:10973 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267343AbTAGIpV>; Tue, 7 Jan 2003 03:45:21 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 7 Jan 2003 00:53:15 -0800
Message-Id: <200301070853.AAA04065@baldur.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Another idea for simplifying locking in kernel/module.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>        Here is a way to replace all of the specialized "stop CPU"
>locking code in kernel/module.c with an rw_semaphore by using
>down_read_trylock in try_module_get() and down_write when beginning to
>unload the module.
>
>        The following UNTESTED patch, a net deletion of 136 lines,

	I am running that patch now on two computers.  It seems to
be OK.

	Rusty, I'd be interested in knowing what you think of the
patch (likewise for other lkml readers).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
