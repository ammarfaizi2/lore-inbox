Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWGAJBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWGAJBu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWGAJBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:01:50 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:15574 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932472AbWGAJBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:01:49 -0400
Date: Sat, 1 Jul 2006 11:01:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: ltuikov@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
In-Reply-To: <20060630183744.310f3f0d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0607011056590.25773@yvahk01.tjqt.qr>
References: <20060630181915.638166c2.akpm@osdl.org>
 <20060701012658.14951.qmail@web31803.mail.mud.yahoo.com>
 <20060630183744.310f3f0d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> I think incrementing it would be a good thing, plus other things
>> may want to represent 8 bytes as a character array to be the name
>> of a task thread.
>
>OK, that's a reason.  Being able to map a kernel thread onto a particular
>device is useful.
>
Eh, that is not the case for some ATM.

Do "migration", "ksoftirqd", "watchdog", "events", "kblockd" and "aio" map 
to a particular device besides possibly "CPU"?

"xfslogd", "xfsdatad", and "rpciod" also have one thread per CPU rather 
than per-device or per-mount.

"pdflush" even has a variable number of threads running, depending on load. 
One thread may serve many mounts/devices, or - I have seen this - eight 
instances manage two mounts.


Jan Engelhardt
-- 
