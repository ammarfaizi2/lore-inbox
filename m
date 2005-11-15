Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVKOJIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVKOJIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVKOJIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:08:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15555 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751401AbVKOJIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:08:46 -0500
Date: Tue, 15 Nov 2005 10:08:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: 2.6.14-rt13
Message-ID: <20051115090827.GA20411@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.14-rt13 tree, which can be downloaded from the 
usual place:

   http://redhat.com/~mingo/realtime-preempt/

lots of fixes in this release affecting all supported architectures, all 
across the board. Big MIPS update from John Cooper.

Changes since 2.6.14-rt1:

 - lots of RCU fixes and updates in signal handling and related areas
   (Paul E. McKenney)

 - big RCU torture-test update (Paul E. McKenney)

 - fix netfilter/conntrack crash reported by Paweł Sikora

 - big MIPS update (John Cooper)

 - ARM updates (Daniel Walker)

 - PPC updates (Benedikt Spranger)

 - ktimers rounding fix (Thomas Gleixner)

 - off by one fix in timespec normalization (George Anzinger)

 - lpptest Kconfig dependency fix (Tom Rini)

 - clean up get_cpu_tick() -> get_cycles() in blocker, lpptest and 
   latency.c. (Tom Rini)

 - fix ppc32 bootwrapper code for new zlib (Tom Rini)

 - rtc histogram fixes merged for real :-) (K.R. Foley)

 - fix NMI watchdog false positive (Steven Rostedt, me)

 - added the nsleep() kernel API, which uses high-resolution sleeps

 - build fix on !PREEMPT_RT

 - cleanup of the PER_CPU_LOCKED infrastructure

 - fix softlockup false positives triggered by the RCU torture-test.

 - do not send a false -ERESTART_RESTARTBLOCK to userspace if the
   HRT timer hardware wakes us up early.

to build a 2.6.14-rt13 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rt13

	Ingo
