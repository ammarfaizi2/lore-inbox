Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVH2Ir4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVH2Ir4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 04:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVH2Ir4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 04:47:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:724 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750760AbVH2Ir4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 04:47:56 -0400
Date: Mon, 29 Aug 2005 10:48:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com
Subject: 2.6.13-rt1
Message-ID: <20050829084829.GA23176@elte.hu>
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


i have released the 2.6.13-rt1 tree, which can be downloaded from the 
usual place:

  http://redhat.com/~mingo/realtime-preempt/

the new "eliminate the global PI lock" code from Steven Rostedt is now 
ready for prime-time. Smaller fixes otherwise. Please re-report any 
remaining regressions.

Changes since 2.6.13-rc7-rt1:

 - second (final) phase p->pi_lock SMP scalability improvement: replace 
   the pi_lock with per-task ->pi_lock and eliminate the global pi_lock 
   (Steven Rostedt)

 - fix for ->pi_lock code (Steven Rostedt)

 - improve ->pi_lock code on UP (Steven Rostedt)

 - x86_64 boot fix (Daniel Walker)

 - ALL_TASKS_PI fixes (Daniel Walker)

 - enabled ALL_TASKS_PI for debugging purposes

 - merge to 2.6.13-final

to build a 2.6.13-rt1 tree, the following patches should be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rt1

	Ingo
