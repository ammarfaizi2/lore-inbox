Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265712AbTL3JnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 04:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbTL3JnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 04:43:05 -0500
Received: from bay2-f70.bay2.hotmail.com ([65.54.247.70]:4363 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265712AbTL3Jmu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 04:42:50 -0500
X-Originating-IP: [193.172.9.1]
X-Originating-Email: [aka_mr_zapper@hotmail.com]
From: "g-j v dijk" <aka_mr_zapper@hotmail.com>
To: roger.larsson@norran.net, linux-kernel@vger.kernel.org
Subject: Re: Problem with SCHED_RR and kernel 2.4.18-4GB
Date: Tue, 30 Dec 2003 10:42:48 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F70OY1YT5D6pm8000352f2@hotmail.com>
X-OriginalArrivalTime: 30 Dec 2003 09:42:49.0127 (UTC) FILETIME=[4957D370:01C3CEB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem is that if I implement this, and set scheduling to be 
>SCHED_RR,
> > or SCHED_FIFO, my linux machine hangs. With SCHED_OTHER, I don't have 
>that
> > (note that for testing I used to set all prios to minimum (=1)).
>
>The big difference is that if a tread running as SCHED_RR or SCHED_FIFO 
>never
>sleeps normal treads (like X, sh, login, ...) will not be given ANY CPU 
>time
>- computer will appear hanged.

Yep, I checked all threads. Not all threads have sleeps, but they do use 
semaphores or some blocking OS calls. Are you saying that's not enough? I 
think it should be, else the threads have design flaws.

>[BTW you are not running the same code in both cases due to ifdefs...]

Yep, IMHO you don't have to set the schedule type in "OTHER" mode.

>But it is possible to get out of this situation if you prepared for it
>before... Use a higher priority monitor to detect looping RT processes and
>reduce their priorities!

I like that Idea, it would be really appreciated if you could give me some 
sample code, just to get me started.

Thanks a lot,

Gert-Jan

_________________________________________________________________
MSN Search, for accurate results! http://search.msn.nl

