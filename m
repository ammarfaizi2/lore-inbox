Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271848AbRICWvR>; Mon, 3 Sep 2001 18:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271851AbRICWvI>; Mon, 3 Sep 2001 18:51:08 -0400
Received: from mx2.port.ru ([194.67.57.12]:9486 "EHLO smtp2.port.ru")
	by vger.kernel.org with ESMTP id <S271849AbRICWu6>;
	Mon, 3 Sep 2001 18:50:58 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109040313.f843DYc00623@vegae.deep.net>
Subject: pmap revisited
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Sep 2001 03:13:34 +0000 (UTC)
Cc: marcelo@brutus.conectiva.com.br, riel@surriel.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

             Ashes on my head guys...
    Gotta wrong results in my previous perftest... (slightly different 
  environments), so these are to be sure that on low VM load there isnt
  any significant difference...

  Here are new and revisited. Actually i maked sure that the environments
differs only in kernels...

  Bonus: two bugs! :)
   1. Quintela`s (shmtest of memtest) and pmap{2,3} == 100% instant deadlock
      plain ac12 demonstrates ignorance.
   2. Swapoff oops 100% - only in pmap3! (okay, swapoff of reiserfs 
      to be strict, but i think that doesnt actually matters)
      swapoff oops will be in next mail.

  Revisited results:

time find / -xdev - done 5 times
pmap 3
real    1m5.175s
real    1m4.699s
real    1m3.579s
============================
pmap 2
real    1m5.039s
real    1m4.779s
real    1m4.506s
============================
plain
real    1m4.820s
real    1m4.433s
real    1m4.285s

* fillmem == (fillmem of memtest)
* dont count on differences - they are quite flaky, one is only known:
  there are no much difference anyways...
time fillmem - done 7 times, still giving strange results sometimes...
pmap 3
real    1m2.709s
real    1m2.417s
real    1m1.371s
real    1m1.241s
real    1m0.235s
(1m3.~, 1m4.5~) - add results
============================
pmap 2
real    1m5.294s
real    1m5.169s
real    1m4.431s
real    1m3.878s
real    1m3.523s
(1m6.~, 1m0.~, 1m3.355) - add results
============================
plain
real    1m1.570s
real    1m1.063s
real    1m1.007s
real    1m0.201s
real    0m59.677s

