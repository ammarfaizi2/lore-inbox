Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262740AbTCYQVE>; Tue, 25 Mar 2003 11:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262749AbTCYQVD>; Tue, 25 Mar 2003 11:21:03 -0500
Received: from fionet.com ([217.172.181.68]:1518 "EHLO service")
	by vger.kernel.org with ESMTP id <S262740AbTCYQVB>;
	Tue, 25 Mar 2003 11:21:01 -0500
Subject: System time warping around real time problem - please help
From: Fionn Behrens <fionn@unix-ag.org>
Reply-To: fionn@unix-ag.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: United Fools of Bugaloo
Message-Id: <1048609931.1601.49.camel@rtfm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 17:32:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,


I have got an increasingly annoying problem with our fairly new (fall
'02) Dual Athlon2k+ Gigabyte 7dpxdw linux system running 2.4.20.
The only kernel patch applied is Alan Cox's ptrace patch.

To say it right away: the system is not overclocked or anything and
never was. It has decent cooling and is used as a combined workstation
and server.

I cant say exactly when it started but the system clock tends to begin
jumping around real time in an erratic manner, usually after about 12-48
hours of uptime. The maximum time jump is about 5 seconds back or forth
so the time is always "about" right.
To give you an example to visualize, you can watch asclock in X and see
the second clock-hand jumping like 3 seconds backwards, then 5 seconds
forth, 2 back and 1 forth or so within 2 or 3 seconds.
For a demonstration I wrote the following short example in python:

t = 0
while 1:
  n = time()
  if t > n: print t, ">", n
  t = n

Running this loop returned the following lines:

1048608745.61 > 1048608745.60
1048608745.63 > 1048608745.62
1048608745.65 > 1048608745.64
1048608748.23 > 1048608745.67
1048608748.27 > 1048608745.71
1048608748.30 > 1048608745.74
1048608748.34 > 1048608745.78
1048608748.42 > 1048608745.86
1048608748.47 > 1048608745.91
1048608748.52 > 1048608745.96
[----cut----]

So you see the time() on this system is constantly overtaking itself and
jumping back. It almost looks like two parallel time()s are there and it
switches back and forth between them.

I recompiled the kernel, I upgraded the BIOS to the latest version
available, I disabled ntp and tried some more I dont recall yet - no
success. Due to the erratic timer, working on the machine is no fun.
Software crashes are regularly - naturally. No programmer expects system
timers going back in time.

I am pretty desperate and I'd appreciate any hints on what to check.
I'll glady present any system detail that you might miss for a proper
analysis on request per email or on freenode (Fionn).

Thank you in advance,
   			F. Behrens (Not a subscriber of this list)
-- 
I believe we have been called by history to lead the world.
                                                 G.W. Bush, 2002-03-01
