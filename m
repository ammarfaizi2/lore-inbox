Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269583AbUJLJnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbUJLJnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269581AbUJLJmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:42:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:52667 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269586AbUJLJmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:42:06 -0400
Date: Tue, 12 Oct 2004 11:42:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
Message-ID: <20041012094228.GA19751@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012091501.GA18562@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> i've uploaded -T6:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T6
> 
> this should fix the UP build issues reported by many. -T6 also brings
> back the ->break_lock framework and converts a few more locks to raw.
> 
> SMP is still expected to be flaky due to the zombie-task problem(s).
> But UP is not out of the 'extremely experimental' status either.

one more warning wrt. PREEMPT_REALTIME: if this option is enabled then
it is not safe to make interrupts non-threaded via
/proc/irq/*/*/threaded. If you need to turn an interrupt into a
high-prio event then its irq thread should be set to RT priority via
'chrt'. (-T7 will turn off /proc/irq/*/*/threaded altogether, to make
sure it's not set accidentally.)

	Ingo
