Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289971AbSAPP2e>; Wed, 16 Jan 2002 10:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289975AbSAPP2Y>; Wed, 16 Jan 2002 10:28:24 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22538 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289972AbSAPP2S>; Wed, 16 Jan 2002 10:28:18 -0500
Date: Wed, 16 Jan 2002 10:27:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16QXhu-0000wl-00@starship.berlin>
Message-ID: <Pine.LNX.3.96.1020116102256.28369C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Daniel Phillips wrote:

> On January 15, 2002 06:26 am, Mark Hahn wrote:
> > > than the task's float, the completion time of the schedule as a whole will be 
> > > delayed.  This is no different for a computer than it is for a group of 
> > > people, it is still a scheduling problem.  Delaying any random task risks 
> > 
> > it is quite different.  with computers, there are often STRONG benefits
> > to clustering, batching, chunking, piggybacking, whatever you want to call it.
> 
> It's no different.

Sorry, there are strong benefits from all of the things mentioned. I lack
time and inclination to explain how caching works, but there are costs of
changing from one thing to another.

The other issue is that processes doing i/o (blocking before a whole
timeslice) will run better if they get priority when they can use the CPU.
Therefore a system needs to recognize (and be tuned) for both of these.

Computers are very different than people in lines.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

