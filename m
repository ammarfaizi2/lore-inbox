Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVAVM3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVAVM3r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 07:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVAVM3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 07:29:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23268 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262706AbVAVM3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 07:29:45 -0500
Date: Sat, 22 Jan 2005 13:29:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.36-00
Message-ID: <20050122122915.GA7098@elte.hu>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115133454.GA8748@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.36-00 Real-Time Preemption patch, which can be
downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/
 
this is mainly a merge to 2.6.11-rc2.

There was alot of merging to be done due to Thomas Gleixner's
spinlock/rwlock cleanups making it into upstream and due to the upstream
spinlock changes, and there were some networking related conflicts as
well, so these areas might introduce new regressions.

the patch includes a fix that should resolve the microcode-update
related boot-time crash reported by K.R. Foley. It also includes a
verify_mm_writelocked() fix from Daniel Walker.

to create a -V0.7.36-00 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc2.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-rc2-V0.7.36-00

	Ingo
