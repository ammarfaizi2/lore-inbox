Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbUKDQcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUKDQcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUKDQcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:32:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53659 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262286AbUKDQcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:32:09 -0500
Date: Thu, 4 Nov 2004 17:32:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
Message-ID: <20041104163254.GA3810@elte.hu>
References: <OF5DB3F102.6D3B4834-ON86256F42.00598BFD@raytheon.com> <20041104163012.GA3498@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104163012.GA3498@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> X should be scheduled on the other CPU just fine. Only per-CPU kernel
> threads (which are affine to their particular CPU) are affected by
> this problem - ordinary tasks not. I.e. the system threads that have
> /0 and /1 in their name. In theory you should not even need to chrt
> the hardirq threads, those should schedule fine too.

plus there's the 'priority inheritance dependency-chain closure' bug
noticed by John Cooper - that should only affect the latency of RT tasks
though.

	Ingo
