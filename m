Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269313AbTCDHhw>; Tue, 4 Mar 2003 02:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269314AbTCDHhw>; Tue, 4 Mar 2003 02:37:52 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34029 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269313AbTCDHhr>; Tue, 4 Mar 2003 02:37:47 -0500
Date: Mon, 03 Mar 2003 23:48:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Con Kolivas <kernel@kolivas.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Message-ID: <107450000.1046764086@[10.10.2.4]>
In-Reply-To: <200303041828.10130.kernel@kolivas.org>
References: <103200000.1046755559@[10.10.2.4]>
 <200303041636.00745.kernel@kolivas.org> <104910000.1046757141@[10.10.2.4]>
 <200303041828.10130.kernel@kolivas.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> So ... is there any easy way I can diagnose this? Does anyone else
>> >> have a similar problem?
>> > 
>> > Most of us who have worked with an O(1) scheduler based kernel have
>> > found this  at various times. See the previous discussion with akpm
>> > about the interactivity estimator. Akpm found that decreasing the
>> > maximum timeslice duration would blunt the effect of the interactivity
>> > estimator giving preference to the "wrong" task. In 2.4.20-ck4 I avoid
>> > this problem with the  "desktop tuning" of making the max
>> > timeslice==min timeslice. Try an -mm  kernel with the scheduler
>> > tunables patch and try playing with the max  timeslice. Most have
>> > found that <=25 will usually stop these skips. The  default max
>> > timeslice of 300ms is just too long for the desktop and interactivity
>> > estimator.
>> 
>> Heh, cool. I have the same patch in my tree too, fixed it without
>> rebooting even ;-) Still a *tiny* bit of skipping, but infinitely better
>> than it was.
> 
> Try decreasing prio_bonus_ratio to 15 as well

Doesn't seem to make much difference, actually.
But "waggle scrollbar a bit" isn't very scientific .. ;-)
Does contest (or anything else) measure this kind of thing more precisely?

M.

