Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSLPBrA>; Sun, 15 Dec 2002 20:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264786AbSLPBrA>; Sun, 15 Dec 2002 20:47:00 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:14601 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264766AbSLPBq7>; Sun, 15 Dec 2002 20:46:59 -0500
X-Envelope-From: roubal@jobatlas.cz
Message-ID: <0a6501c2a4a6$1a23b7b0$551b71c3@krlis>
From: "Milan Roubal" <roubal@jobatlas.cz>
To: <linux-kernel@vger.kernel.org>
Subject: big load
Date: Mon, 16 Dec 2002 02:54:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


