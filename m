Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280435AbRKGKfl>; Wed, 7 Nov 2001 05:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280450AbRKGKfc>; Wed, 7 Nov 2001 05:35:32 -0500
Received: from bacon.van.m-l.org ([208.223.154.200]:11392 "EHLO
	bacon.van.m-l.org") by vger.kernel.org with ESMTP
	id <S280435AbRKGKfS>; Wed, 7 Nov 2001 05:35:18 -0500
Date: Wed, 7 Nov 2001 05:35:17 -0500 (EST)
From: George Greer <greerga@m-l.org>
X-X-Sender: <greerga@bacon.van.m-l.org>
To: <linux-kernel@vger.kernel.org>
Subject: keve-ntd (linux 2.2 and gcc 3 sillies)
Message-ID: <Pine.LNX.4.33.0111070527490.2769-100000@bacon.van.m-l.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, this is funny:

5 (ntd) S 1 1 1 0 -1 64 0 0 0 0 0 2239187 0 0 11 0 0 0 76 0 0 2147483647 
3221225472 3223473832 0 0 0 0 2147483647 65536 0 3223678300 0 0 0 1
0 0 0 0 0 0 0

Name:   ntd
State:  R (running)
Pid:    5
PPid:   1
Uid:    0       0       0       0
Gid:    0       0       0       0
Groups:
SigPnd: 0000000000000000
SigBlk: 00000000ffffffff
SigIgn: 0000000000010000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 00000000ffffffff
CapEff: 00000000fffffeff

Judging by the PID, that was supposed to be 'keventd'.  It must be upset
over losing part of its name, although right now it just seems content with
eating up 60% of my CPU time:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM COMMAND
    5 root      19   0     0    0     0 RW   62.3  0.0 ntd

Problem is apparently that it was GCC 3.0.  Serves me right for forgetting
that even though 2.2.19 was compiled with egcs 1.1.2, I've upgraded
compilers since then.  Oh well.  Since I am sending this e-mail from the
machine it isn't too bad. Now to dig up a suitable compiler...

-- 
George Greer, greerga@m-l.org
http://www.m-l.org/~greerga/

