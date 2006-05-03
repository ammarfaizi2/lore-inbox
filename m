Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbWECQ1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbWECQ1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbWECQ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:27:13 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:39333 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965237AbWECQ1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:27:12 -0400
Date: Wed, 3 May 2006 18:27:10 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Con Kolivas <kernel@kolivas.org>
cc: Juho Saarikko <juhos@mbnet.fi>, ck list <ck@vds.kolivas.org>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] 2.6.16-ck9
In-Reply-To: <200605032330.13131.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0605031825410.13546@yvahk01.tjqt.qr>
References: <200605022338.20534.kernel@kolivas.org> <200605030801.05523.kernel@kolivas.org>
 <1146646484.4260.6.camel@a88-112-69-25.elisa-laajakaista.fi>
 <200605032330.13131.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And so it does. Annoying. Time to hack kernel to add a new scheduling
>> policy, SCHED_STAYIDLE, which is like SCHED_IDLE but cannot be unset
>> except by root.
>>
>> Can't make it the default, since a program running at SCHED_IDLE in a
>> machine with 100% CPU usage by some other program will never process
>> SIGKILL, and thus can only be killed by setting its scheduling policy to
>> normal...

Try making SCHED_STAYIDLE non-idle enough so that non-catchable signals get 
processed in an appropriate time.

>> Darn obnoxious program, SetiAtHome...
>
>Obviously when they wrote the linux client and added the ability to set the 
>priority from within the program to nice 19 they also explicitly set the 
>scheduling policy at the same time. This might make sense on some other OS... 
>but not linux.
>
You have the source, you can change the behavior as a temporary workaround.


Jan Engelhardt
-- 
