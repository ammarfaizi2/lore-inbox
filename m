Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbUKUXZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUKUXZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbUKUXZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:25:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37532 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261845AbUKUXYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:24:31 -0500
Date: Mon, 22 Nov 2004 01:27:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041122002702.GB16936@elte.hu>
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Hi,
>  From realfeel I wrote a small, simple test to test how well priority
> inheritance mechanism works. 

cool - this is a really useful testsuite.

> I tested it on V0.7.26-0 and my own U9.2-priom. Both implementations
> fails when the mutex is congested by more than 1 non-real-time task.
> [...]

i can confirm your measurements.

I have fixed all the PI bugs that your suite uncovered (there were quite
a number of them!), the fixes are included in the V0.7.30-0 patch
available at the usual place:

   http://redhat.com/~mingo/realtime-preempt/

with this patch i get the expected histogram with entries only in the
0-1 msec buckets.

	Ingo
