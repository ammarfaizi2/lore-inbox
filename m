Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269334AbTCDIFV>; Tue, 4 Mar 2003 03:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269337AbTCDIFU>; Tue, 4 Mar 2003 03:05:20 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:17079 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S269334AbTCDIFR>;
	Tue, 4 Mar 2003 03:05:17 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Date: Tue, 4 Mar 2003 19:15:43 +1100
User-Agent: KMail/1.5
References: <103200000.1046755559@[10.10.2.4]> <200303041828.10130.kernel@kolivas.org> <107450000.1046764086@[10.10.2.4]>
In-Reply-To: <107450000.1046764086@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303041915.43743.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003 06:48 pm, Martin J. Bligh wrote:
> >> >> So ... is there any easy way I can diagnose this? Does anyone else
> >> >> have a similar problem?
> >> >
> >> > Most of us who have worked with an O(1) scheduler based kernel have
> >> > found this  at various times. See the previous discussion with akpm
> >> > about the interactivity estimator. Akpm found that decreasing the
> >> > maximum timeslice duration would blunt the effect of the interactivity
> >> > estimator giving preference to the "wrong" task. In 2.4.20-ck4 I avoid
> >> > this problem with the  "desktop tuning" of making the max
> >> > timeslice==min timeslice. Try an -mm  kernel with the scheduler
> >> > tunables patch and try playing with the max  timeslice. Most have
> >> > found that <=25 will usually stop these skips. The  default max
> >> > timeslice of 300ms is just too long for the desktop and interactivity
> >> > estimator.
> >>
> >> Heh, cool. I have the same patch in my tree too, fixed it without
> >> rebooting even ;-) Still a *tiny* bit of skipping, but infinitely better
> >> than it was.
> >
> > Try decreasing prio_bonus_ratio to 15 as well
>
> Doesn't seem to make much difference, actually.
> But "waggle scrollbar a bit" isn't very scientific .. ;-)
> Does contest (or anything else) measure this kind of thing more precisely?

Last time I tried to do a whole swag of tunables it was showing differences 
but I was plagued by memory leaks ruining the data. I'll try again in the 
near future. Also Bill Davidsen's trivial response benchmark may show 
something too.

Con

