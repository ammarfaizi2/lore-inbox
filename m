Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130962AbQIJQIu>; Sun, 10 Sep 2000 12:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130957AbQIJQIj>; Sun, 10 Sep 2000 12:08:39 -0400
Received: from [194.242.209.130] ([194.242.209.130]:44804 "EHLO em.gardena.net") by vger.kernel.org with ESMTP id <S130946AbQIJQId>; Sun, 10 Sep 2000 12:08:33 -0400
From: Benno Senoner <sbenno@gardena.net>
To: linux-kernel@vger.kernel.org, linux-audio-dev@ginette.musique.umontreal.ca
Subject: Montavista's preemptive & preempt-rtsched kernels benchmarked ( still 50msec latencies )
Date: Sun, 10 Sep 2000 19:56:19 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: juns@mvista.com, Ingo Molnar <mingo@elte.hu>, Andrew Morton <andrewm@uow.edu.au>
MIME-Version: 1.0
Message-Id: <00091020131600.00958@linuxhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I  benchmarked Montavista's premptive and preemtive-rtsched kernels
( patches for 2.4.0-test6) using "latencytest".

summary:

both patches do not improve latencies very much over standard kernels
I believe around factor 2, but far away from the factor 10 ( 12msec) claimed in
the pressrelease.

To note that the preempt-rtsched gives excellent latencies , below 1msec
during the x11 and /proc stresstest, while the -preempt patch produces 10-20sec
latencies in these two test cases.

Unfortunately during the disk I/O tests both kernels produce 40-50msec
latencies.

here are the graphs:

preemp-rtsched patch:

http://www.linuxdj.com/latency/2.4.0-test6-preemp-rtsched/2048.html

preemp patch:

http://www.linuxdj.com/latency/2.4.0-test6-preemp/2048.html


I ran all my test on my reference PII400 box,

I used the RTC tests (instead of the audio tests) because I am having problems
with modules loading on my Redhat 6.1 box (with modutils-2.3.9-6).
BTW: do I need newer modutils in order to load the 2.4.0-test6 modules
correctly ?
(It seems that newer -test* kernels place the modules in
/lib/modules/KERNEL_VERSION/kernel/ instead in /lib/modules/KERNEL_VERSION.
Can anyone help me to solve my module loading troubles ?)

Again, for comparision this is what Ingo's 2.2.10-lowlatency patch produces
on an old P133
http://www.gardena.net/benno/linux/audio/rtc2048-cpu80/2048.html

all latencies below 1msec on a vastly inferiour machine.
This should be the goal for a 2.4 patch (for now I don't care if it is
preemption point based or preemptive in montavista's style).
At this point realtime mutimedia on kernel 2.4 will be usable
(and no one is asking for short term inclusion anymore, the important thing is
that users have the possiblity to download and use a patched kernel which suits
their realtime needs)

cheers,
Benno.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
