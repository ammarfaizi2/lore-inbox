Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTAEP75>; Sun, 5 Jan 2003 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTAEP74>; Sun, 5 Jan 2003 10:59:56 -0500
Received: from smtp3.poczta.onet.pl ([213.180.130.29]:17283 "EHLO
	smtp3.poczta.onet.pl") by vger.kernel.org with ESMTP
	id <S264863AbTAEP74>; Sun, 5 Jan 2003 10:59:56 -0500
Date: Sun, 5 Jan 2003 17:07:52 +0100
From: Piotr Wajnberg <davine@poczta.onet.pl>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: CD recording and RAID
Message-Id: <20030105170752.500ea7b8.davine@poczta.onet.pl>
X-Mailer: Sylpheed version 0.8.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux_from_Scratch/Slackware
My_sister_uses: FreeBSD!
Registered_linux_user: #250250
LFS_ID: 7325
Gadu-Gadu: 209197
X-Face: #?xY:o#9:4(p4y`g(v~6gdj9&?YCSzDf+u]4`%jEX[3>4pffeYJEuf6ofF~3ym&+:~k`(2E
 ^WnV8YyFM{&!h0*m5*0FHVsQw~|Z./|o
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a RAID-0 setup and suppose a slowest disk io performance (like 300kb/s) during
CD recording is due to the recorder being on the same ide controller  as
my hard disks although md5summing is as fast as usual and can even  
starve the recorder causing the recording to fail.
What I'd like to know is why the system completely
freezes for the time a CD is being fixated. Here's the output of
vmstat for the final stages of fixation: 
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 5  0  0   6824   4508  10768 159036   0   0     0    80  172   745 100   0   0
 2  0  0   6824   4508  10768 159036   0   0     0     0  158   741  99   1   0
 7  0  0   6824   4508  10768 159036   0   0     0     0  158   700 100   0   0
 2  0  0   6824   4508  10768 159036   0   0     0     0  158   736  99   1   0
 5  0  0   6824   4484  10768 159036   0   0     0     0  151   703 100   0   0
 3  1  1   6824   4476  10784 159036   0   0     0    12  148   691 100   0   0
 5  1  1   6824   4476  10784 159036   0   0     0     0  151   580 100   0   0
 2  0  1   6824   3416  10808 159036   0   0     0    40  156   639 100   0   0
 6  0  0   6824   8864  10892 154936   0   0     0   253 9384 37130   3   0  97

As you can see from the last entry as soon as the the recording ends  the system 
catches up, as it were, with all the processes that were cut off from the processor. 
I'm currently using 2.4.20-ck2 because I thought the patches would cure the 
condition but they've made no difference. Could anyone, please, offer an explanation?

-- 
PeteVine
  5:07pm  up 22:54,  2 users,  load average: 1.11, 1.18, 1.27
65 processes: 60 sleeping, 5 running, 0 zombie, 0 stopped
CPU states:  3.9% user,  5.8% system, 90.1% nice,  0.0% idle

Linux registered user #250250
http://counter.li.org


--------------r-e-k-l-a-m-a-----------------

Super tanie kwatery narciarskie.
Od 300 zl/osoba/tydzien
http://wycieczki.onet.pl
