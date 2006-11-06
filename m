Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWKFGml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWKFGml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 01:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWKFGmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 01:42:40 -0500
Received: from pop-satin.atl.sa.earthlink.net ([207.69.195.63]:27272 "EHLO
	pop-satin.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932652AbWKFGmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 01:42:40 -0500
Date: Mon, 6 Nov 2006 01:42:32 -0500 (EST)
From: Brent Baccala <cosine@freesoft.org>
X-X-Sender: baccala@debian.freesoft.org
To: Jens Axboe <jens.axboe@oracle.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
In-Reply-To: <20061105121522.GC13555@kernel.dk>
Message-ID: <Pine.LNX.4.64.0611060136250.4220@debian.freesoft.org>
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org>
 <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org>
 <20061103160212.GK13555@kernel.dk> <Pine.LNX.4.64.0611031214560.28100@debian.freesoft.org>
 <20061105121522.GC13555@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2006, Jens Axboe wrote:

> On Fri, Nov 03 2006, Brent Baccala wrote:
>>
>> Does 7 microseconds seem a bit excessive for an io_submit (and a
>> gettimeofday)?
>
> I guess you mean miliseconds, not microseconds. 7 miliseconds seems way
> too long. I repeated your test here, and the 100 submits take 97000
> microseconds here - or 97 miliseconds. So that's a little less than 1
> msec per io_submit. Still pretty big. You can experiment with oprofile
> to profile where the kernel spends its time in that period.
>
> -- 
> Jens Axboe
>

Yes, of course, milliseconds.  I have enough other problems with this
program (measured in minutes, and no mistake that) that I doubt I'll
be profiling the kernel any time soon, but thank you for your help.

More than anything else, you've made me understand that I can't just
fire off a bunch of async requests like I'm tossing peanuts across the
table.  I've really got to pay attention to what's in that kernel
queue and how it gets managed.



 					-bwb

 					Brent Baccala
 					cosine@freesoft.org
