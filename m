Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283946AbRLAIrI>; Sat, 1 Dec 2001 03:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284008AbRLAIq6>; Sat, 1 Dec 2001 03:46:58 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:41164 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S283946AbRLAIqn>; Sat, 1 Dec 2001 03:46:43 -0500
Date: Sat, 1 Dec 2001 03:49:58 -0500
To: linux-kernel@vger.kernel.org
Subject: Is Andrew Morton a god?
Message-ID: <20011201034958.A4354@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something beautiful has happened in 2.4.17-pre2.

Interactive Latency during very heavy disk I/O has dropped dramatically.
Several LTP tests have a tendency to make interactive performance poor.  
The improvement in 2.4.17-pre2 is astonishing.

Normally runalltests.sh does one test at a time. Since the usual 
interactivity slowdown during the growfiles tests didn't happen, I 
tried running a bunch of things at once.  

Concurrently:
3 growfiles scripts (run all growfiles tests in LTP).
3 LTP runalltests.sh
setiathome
make clean dep bzImage modules 
list directories with lots files that hadn't been listed before in this boot.
ps, w, logout, login.
3 irc clients, play a couple mp3s, read entertaining Coding Standards thread.

The start time of the concurrent growfiles and runalltests.sh was spaced 
out, so different tests were being executed.  

Occasionally ls or w had a 10 second or so delay, but delays were infrequent, 
and shorter than usual.

Kudos to all the Kernel Hackers!

-- 
Randy Hron

