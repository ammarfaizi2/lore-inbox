Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVBAUOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVBAUOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 15:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVBAUOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 15:14:47 -0500
Received: from mx1.elte.hu ([157.181.1.137]:57733 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262110AbVBAUOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 15:14:45 -0500
Date: Tue, 1 Feb 2005 21:14:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Manish Lachwani <mlachwani@mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.11-rc2-V0.7.37-02
Message-ID: <20050201201402.GA31930@elte.hu>
References: <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu> <20050115133454.GA8748@elte.hu> <20050122122915.GA7098@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122122915.GA7098@elte.hu>
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


i have released the -V0.7.37-02 Real-Time Preemption patch, which can be
downloaded from the usual place:

  http://redhat.com/~mingo/realtime-preempt/

the big change in the patch is increased architecture support: most
notable i've merged the MIPS patch from Manish Lachwani. Also, the x64
port should be working again. (To make architecture merges easier in the
future the timer interrupt is not threaded anymore - if this shows
latency problems then we'll try to solve it on other ways.)

to create a -V0.7.37-02 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc2.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-rc2-V0.7.37-02

	Ingo
