Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266687AbSKHAle>; Thu, 7 Nov 2002 19:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266689AbSKHAld>; Thu, 7 Nov 2002 19:41:33 -0500
Received: from packet.digeo.com ([12.110.80.53]:36856 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266687AbSKHAld>;
	Thu, 7 Nov 2002 19:41:33 -0500
Message-ID: <3DCB09C3.1EDB05EC@digeo.com>
Date: Thu, 07 Nov 2002 16:48:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@cotse.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
References: <YWxhbg==.5c396bf3e8e65dc7442a4adb6f35702e@1036715544.cotse.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2002 00:48:07.0250 (UTC) FILETIME=[80CC2320:01C286C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Willis wrote:
> 
> > Why?  We are preempting during the generic file write/read routines, I
> > bet, which can otherwise be long periods of latency.  CPU is up and I
> > bet the throughput is down, but his test is getting the attention it
> > wants.
> 
>   I'm curious, would running contest after a fresh boot and with profile=2
> provide a profile that tells exactly where time is being spent?  Since
> about 2.5.45 I've had some strange slow periods, and starting aterm
> would take a while, redrawing windows in X would slow down, it 'feels'
> like my workstation becomes a laptop that is just waking up.  Sometimes
> this is after only a few minutes of inactivity, or after switching
> virtual desktops in kde, or when I have alot of aterm instances running.

- Run `vmstat 1', and see if the slowdowns coincide with any unusual
  IO activity.

- Could be the scheduler.  Try
  renice -19 $(pidof X) $(pidof aterm) $(pidof other stuff)
