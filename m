Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRCaUH3>; Sat, 31 Mar 2001 15:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132492AbRCaUHT>; Sat, 31 Mar 2001 15:07:19 -0500
Received: from dial053.za.nextra.sk ([195.168.64.53]:4 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S132488AbRCaUHM>;
	Sat, 31 Mar 2001 15:07:12 -0500
Date: Sat, 31 Mar 2001 23:04:54 +0200
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Question about SysRq
Message-ID: <20010331230454.A801@Boris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I managed fullowing situation: user with no ulimits will run script like
this:

#! /usr/bin/perl

while (1)
{
  fork();
};

on say tty2. The processes get created pretty fast. After a short while
I supposed a single solution to this to kill all session by alt+sysrq+k,
but nothing happened. Under normal averagely loaded situation, this will
imidiately kill all processes on current vt and bring getty prompt. 
Shouldn't it function similiarily in former case ? I see all processes on vt 
get SIGKILL, so what's hapenned ? Maybe I had to wait
a bit longer for kernel to accomplish that ? Killing all processes with init 
(alt+sysrq+i) seems to be immediate.


Thought, i really love all sysrq properties of linux, so i need less often
to make hardware resets an then await and fear, what fsck will print.
One more property, that i'd like to have should be request key to force the
most basic text mode (say 80x25) on the console, when eg. X freezes and 
i kill its session, then last gfx mode resides on the screen and see no way 
to restore back the text mode - /usr/bin/reset or something alike will not 
do it. But it seems to be not a good idea at all, does it ? 

Cheers                                                                 B.


-- 
