Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVDVHe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVDVHe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 03:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVDVHe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 03:34:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38346 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262015AbVDVHep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 03:34:45 -0400
Date: Fri, 22 Apr 2005 09:34:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
Message-ID: <20050422073408.GA5470@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu> <20050421073537.GA1004@elte.hu> <20050422062714.GA23667@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050422062714.GA23667@elte.hu>
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


> this includes fixes from Daniel Walker, which could fix the plist 
> related slowdown bugs:

there are still some problems remaining: i just ran Esben Nielsen's 
priority-inheritance validation testsuite, and the plist code gives a 
worst-case latency of 9.0 msecs.

I've reverted the plist changes for now and have uploaded -46-02 - this 
gives the expected 1.0 msec worst-case latencies. Diffing -01 against 
-02 should give you the latest plist snapshot.

	Ingo
