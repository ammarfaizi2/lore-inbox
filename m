Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbVJKLOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbVJKLOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 07:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVJKLOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 07:14:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:17869 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751451AbVJKLOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 07:14:30 -0400
Date: Tue, 11 Oct 2005 13:14:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       dwalker@mvista.com, david singleton <dsingleton@mvista.com>
Subject: 2.6.14-rc4-rt1
Message-ID: <20051011111454.GA15504@elte.hu>
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


i have released the 2.6.14-rc4-rt1 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

lots of fixes all across the spectrum. x64 support and debugging 
features on x64 should be in a much better shape now. Same for ARM.

	Ingo
 
Changes since 2.6.14-rc3-rt2:

 - fix nasty memory corruption and crash caused by PREEMPT_DEBUG's 
   lock tracing functionality (Thomas Gleixner)

 - ARM updates (Thomas Gleixner)

 - get rid of bit_spinlock via ->b_state_lock (Steven Rostedt)

 - ACPI flags mismatch fix (Steven Rostedt)

 - softlockup false positive fix (Daniel Walker)

 - robust/PI futex updates (David Singleton)

 - timesource/ktimer updates (Thomas Gleixner)

 - pcmcia shutdown hang fix (Steven Rostedt)

 - fix missing checks for resched

 - merge to 2.6.14-rc4

 - vprintk non-preempt fix

 - various x64 fixes

 - netfilter build fixes

 - various latency tracer fixes

 - use exact BP stackframes when printing stack-overflow debugging info, 
   if x86 and x64, if possible.

 - ide-floppy irq flags fix

 - gameport irq flags fix

 - stack footprint debugging fixes

 - small MIPS updates

 - reduce zlib stack footprint

 - got rid of the last remains of the tlb-simple stuff

 - various build fixes of non-PREEMPT_RT preemption models

 - Kconfig tweak

 - export tsc_c3_compensate

to build a 2.6.14-rc4-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc4.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rc4-rt1

	Ingo
