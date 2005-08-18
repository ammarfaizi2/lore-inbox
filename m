Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVHRGBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVHRGBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVHRGBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:01:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36284 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750785AbVHRGBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:01:00 -0400
Date: Thu, 18 Aug 2005 08:01:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: 2.6.13-rc6-rt9
Message-ID: <20050818060126.GA13152@elte.hu>
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


i have released the 2.6.13-rc6-rt9 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

it's a fixes-only release. Changes since 2.6.13-rc6-rt3:

 - USB irq flags use cleanups (Alan Stern)

 - RCU tasklist-lock fixes (Paul McKenney, Thomas Gleixner)

 - HR-timers waitqueue splitup, better HRT latencies (Thomas Gleixner)

 - latency tracer fixes, irq flags tracing cleanups (Steven Rostedt, me)

 - NFSd BKL unlock fix (Steven Rostedt)

 - stackfootprint-max-printer fix (Steven Rostedt)

 - stop_machine fix (Steven Rostedt)

 - lpptest fix (me)

 - turned off IOAPIC_POSTFLUSH when CONFIG_X86_IOAPIC_FAST. Now with
   Karsten's VIA fixes my testbox does not show PCI-POST weirnesses
   anymore. In case of IRQ problems please turn off IOAPIC_FAST. (me)

to build a 2.6.13-rc6-rt9 tree, the following patches should be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rc6-rt9

	Ingo
