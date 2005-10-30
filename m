Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVJ3NdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVJ3NdW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 08:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVJ3NdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 08:33:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43974 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750825AbVJ3NdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 08:33:21 -0500
Date: Sun, 30 Oct 2005 14:33:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: 2.6.14-rt1
Message-ID: <20051030133316.GA11225@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020195432.GA21903@elte.hu>
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


i have released the 2.6.14-rt1 tree, which can be downloaded from the 
usual place:

   http://redhat.com/~mingo/realtime-preempt/

this release is mainly about ktimer fixes: it updates to the latest 
ktimer tree from Thomas Gleixner (which includes John Stultz's latest 
GTOD tree), it fixes TSC synchronization problems on HT systems, and 
updates the ktimers debugging code.

These together could fix most of the timer warnings and annoyances 
reported for 2.6.14-rc5-rt kernels. In particular the new 
TSC-synchronization code could fix SMP systems: the upstream TSC 
synchronization method is fine for 1 usec resolution, but it was not 
good enough for 1 nsec resolution and likely caused the SMP bugs 
reported by Fernando Lopez-Lezcano and Rui Nuno Capela.

Please re-report any bugs that remain.

Changes since 2.6.14-rc5-rt1:

 - GTOD -B9 (John Stultz)

 - ktimer updates (Thomas Gleixner, me)

 - ktimer debugging check fixes (Steven Rostedt)

 - smarter TSC synchronization on SMP - we now rely on it for nsecs (me)

 - x64 build fix (reported by Mark Knecht)

 - tracing fix (reported by Florian Schmidt)

 - rtc histogram fixes (K.R. Foley)

 - merge to 2.6.14

to build a 2.6.14-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rt1

	Ingo
