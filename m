Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290029AbSAKRcD>; Fri, 11 Jan 2002 12:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290034AbSAKRb4>; Fri, 11 Jan 2002 12:31:56 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:7657 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S290029AbSAKRbt>; Fri, 11 Jan 2002 12:31:49 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -H6
Date: Fri, 11 Jan 2002 18:30:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: dan kelley <dkelley@otec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020111173149Z290029-13996+4387@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

you are the man!
My 1 GHz Athlon II, 640 MB, is up and running with 2.4.17-O(1)-H6.
Writing this under KDE-2.2.2 (KMail) during
time nice +19 make -j40 modules
Max load was: 41,97

Great!

dbench 32 during artsd (noatun, KDE-2.2.2) playing Ogg-Vorbis
"show" hiccup when

artsd (two sub processes) are in
wait_on_p
rt_sigsus

and/or

dbench procs are in
get_reque
wait_on_b
do_journ (ReiserFS?)

Even when I renice both artsd procs I get hiccup.
  PID USER     PRI  NI PAGEIN  SIZE  RSS SHARE WCHAN     STAT %CPU %MEM   
TIME COMMAND
 4953 nuetzel    1 -19      0  7148 7148  4324 rt_sigsus S <   3.6  1.1   
0:04 artsd
 1048 nuetzel    1 -19   1280  7148 7148  4324 schedule_ S <   2.7  1.1   
0:24 artsd

But when I put the Ogg-Vorbis file into /dev/shm I get _NO_ hiccup anymore!!!
So it is only disk IO limited with your O(1)-H6.

Wow, that is fantastic!!!
Never had that before.
Writing during both...;-)

Redid it without renice (-19):
some very few short hiccup.

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
