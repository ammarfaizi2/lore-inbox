Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVEWI1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVEWI1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 04:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEWI1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 04:27:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64386 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261868AbVEWI1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 04:27:31 -0400
Date: Mon, 23 May 2005 10:26:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: dwalker@mvista.com, Joe King <atom_bomb@rocketmail.com>,
       ganzinger@mvista.com, Lee Revell <rlrevell@joe-job.com>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Message-ID: <20050523082637.GA15696@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.47-06 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

there was more stabilization activity during the past couple of weeks - 
i think i have all pending patches applied, let me know if something 
went MIA. I've also applied Mingming's ext3 reservation latency 
reductions.

Changes:

 - more plist fixes (Daniel Walker)

 - SMP global-RT-reschedule fix (Steven Rostedt)

 - x86_64 fixes - it builds & boots now (Joe King)

 - ext3 reservations latency reductions (Mingming Cao)

 - kstopmachine yield() fixes (Steven Rostedt)

 - ksoftirqd init fix (George Anzinger)

 - removed yield() uses from coredumping (suggested by many)

to build a -V0.7.47-06 tree, the following patches have to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc4.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc4-V0.7.47-06

	Ingo
