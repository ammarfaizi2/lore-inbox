Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVBSJKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVBSJKr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVBSJGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:06:19 -0500
Received: from mx1.elte.hu ([157.181.1.137]:42689 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261666AbVBSJFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:05:40 -0500
Date: Sat, 19 Feb 2005 10:03:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050219090312.GA30513@elte.hu>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net> <20050219090036.GA30456@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219090036.GA30456@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Testing on an all SCSI 1.3Ghz Athlon XP system, I am seeing very long
> > latencies in the journalling code with 2.6.11-rc4-RT-V0.7.39-02.
> 
> could you send me the full trace?

just in case the system in question is still running - could you also do 
a 'verbose' trace via:

	echo 1 > /proc/sys/kernel/trace_verbose

and then copying /proc/latency_trace again? (so that we can see the
precise function call offsets - journal_commit_transaction() is a long
function.)

	Ingo
