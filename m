Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSLQSRd>; Tue, 17 Dec 2002 13:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSLQSRd>; Tue, 17 Dec 2002 13:17:33 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:7172 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265238AbSLQSRa>; Tue, 17 Dec 2002 13:17:30 -0500
X-Envelope-From: roubal@jobatlas.cz
Message-ID: <0bca01c2a5f9$99216ea0$551b71c3@krlis>
From: "Milan Roubal" <roubal@jobatlas.cz>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>, <linux-kernel@vger.kernel.org>
References: <000801c2a598$99eccc00$35251c43@joe>
Subject: Re: big load
Date: Tue, 17 Dec 2002 19:24:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
now in clean system there are these values, I don't have got these values
from that fault.
# vmstat
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 0  0  0      0  19924   1488 747392   0   0    93    87  138   136   2   2
96

Thanx
    Milan

----- Original Message -----
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Milan Roubal'" <roubal@jobatlas.cz>; <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 17, 2002 7:50 AM
Subject: RE: big load


I remember an error like this from a few months ago.  Are you encountering
large I/O access?  Lots of swapping?  Lots of buffer input?  Lots of buffer
output?  This would show up on vmstats.

Joseph Wagner

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Milan Roubal
Sent: Sunday, December 15, 2002 7:55 PM
To: linux-kernel@vger.kernel.org
Subject: big load

Hi,
I have got server runnig 5 days and now its doing this:

2:48am  up 5 days, 11:23,  2 users,  load average: 19.97, 15.70, 10.63
61 processes: 60 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  8.1% system,  0.0% nice, 91.4% idle
CPU1 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle

I can't understand where I can got so big load
processor is idle all the time, but load is going higher and higher.

  2:50am  up 5 days, 11:24,  2 users,  load average: 21.45, 17.45, 11.80
62 processes: 61 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU1 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle

my process:


  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
13782 root      13   0   892  892   696 R     0.2  0.0   0:00 top
    1 root      20   0    84   84    52 S     0.0  0.0   0:11 init
    2 root      20   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      20  19     0    0     0 SWN   0.0  0.0   0:03 ksoftirqd_CPU0
    4 root      20  19     0    0     0 SWN   0.0  0.0   0:00 ksoftirqd_CPU1
    5 root      20   0     0    0     0 SW    0.0  0.0  17:22 kswapd
    6 root       0   0     0    0     0 SW    0.0  0.0   1:45 bdflush
    7 root      20   0     0    0     0 SW    0.0  0.0  33:48 kupdated
    8 root      20   0     0    0     0 SW    0.0  0.0   0:00 kinoded
   11 root       0 -20     0    0     0 SW<   0.0  0.0   0:00 mdrecoveryd
   14 root      20   0     0    0     0 SW    0.0  0.0   0:03 kreiserfsd
   51 root      20 -20     0    0     0 SW<   0.0  0.0  11:20 raid5d
  245 root      20   0     0    0     0 DW    0.0  0.0   0:09 pagebuf_daemon
  388 root      20   0   316  316   208 S     0.0  0.0   0:00 syslogd
  391 root      20   0   440  440   216 S     0.0  0.0   0:00 klogd
  427 root      20   0     0    0     0 SW    0.0  0.0   0:00 khubd

What could be wrong?
In log is only this message:

Dec 16 02:32:37 fileserver kernel: lease timed out

# /usr/local/samba/bin/smbd -V
Version 2.2.6

System is 2.4.18-3 from SuSE,
SuSE 8.1 distribution.
Filesystem XFS on 1TB RAID5 array
    Thanx
    Milan Roubal


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



