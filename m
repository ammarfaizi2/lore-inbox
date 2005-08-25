Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVHYG0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVHYG0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbVHYG0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:26:23 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:40597 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751537AbVHYG0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:26:22 -0400
Date: Thu, 25 Aug 2005 08:26:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: "K.R. Foley" <kr@cybsft.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, dwalker@mvista.com
Subject: 2.6.13-rc7-rt1
Message-ID: <20050825062651.GA26781@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


i have released the 2.6.13-rc7-rt1 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release. Changes since 2.6.13-rc6-rt10:

 - init_hrtimers() compilation fix (K.R. Foley)

 - first phase p->pi_lock SMP speedup (Steven Rostedt)

 - HRT/signals exit fixes (Thomas Gleixner)

 - change single-signal delivery (used by e.g. HRT) to RCU
   (Thomas Gleixner)

 - fix larger-than-5-sec sleeps (Thomas Gleixner)

 - ALL_TASKS_PI compilation fixes (Daniel Walker)

 - HRT compilation warning fix (Daniel Walker)

 - PPC fixes (Thomas Gleixner)

 - merge to 2.6.13-rc7

 - disable old HIGH_RES_TIMERS code in ipmi

 - sx8.c semaphore -> compat_semaphore

 - route.c kmalloc-size build fix

to build a 2.6.13-rc7-rt1 tree, the following patches should be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc7.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rc7-rt1

	Ingo
