Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291341AbSBMDz3>; Tue, 12 Feb 2002 22:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291335AbSBMDzJ>; Tue, 12 Feb 2002 22:55:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29191 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291332AbSBMDy6>; Tue, 12 Feb 2002 22:54:58 -0500
Date: Tue, 12 Feb 2002 22:54:02 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69B5D7.CFF9E8EA@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020212224341.8017C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan and/or Linus:

  Am I misreading this or is the Linux implementation of sync() based on
making the shutdown scripts pause until disk i/o is done? Because I don't 
think commercial unices work that way, I think they work as SuS
specifies. More reason to rethink this in 2.4 as well as 2.5 and get the
possible live lock out of the kernel.

  If I'm missing any portable program which assumes this, or any common
UNIX version which works like Linux, please enlighten everyone, I'm going
to put the patch on my test system tomorrow, but I'm going to look at what
it takes to implement SuS and make it totally non-blocking, so I can see
if that really creates any problem.

  If this were only a performance issue I wouldn't push for prompt
implementation, but anything which can hang the system, particularly in
shutdown, is bad.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

