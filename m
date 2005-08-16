Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVHPJpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVHPJpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbVHPJpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:45:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11923 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S965170AbVHPJpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:45:13 -0400
Date: Tue, 16 Aug 2005 11:45:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: 2.6.13-rc6-rt2
Message-ID: <20050816094516.GA19873@elte.hu>
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


i have released the 2.6.13-rc6-rt2 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

it includes a single bugfix, which fixes a HRT timer-latency problem, 
and which could explain some of the crashes/reboots Thomas Gleixner was 
seeing on his test-box.

Changes since 2.6.13-rc6-rt1:

 - fix raise_softirq_prio() bug which can cause artificial latencies and 
   can cause runqueue corruption (me)

to build a 2.6.13-rc6-rt2 tree, the following patches should to be 
applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rc6-rt2

	Ingo
