Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbULIULe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbULIULe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbULIULe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:11:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:33955 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261601AbULIUL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:11:28 -0500
Date: Thu, 9 Dec 2004 21:11:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209201110.GB14194@elte.hu>
References: <OF005FDB8A.72F792AC-ON86256F65.0063E013@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF005FDB8A.72F792AC-ON86256F65.0063E013@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >| The max CPU latencies in RT are worse than PK as well. The values for
> >| RT range from 3.00 msec to 5.43 msec and on PK range from 1.45 msec to
> >| 2.24 msec.
> >
> >
> >these come from userspace timestamping? So where userspace detects a
> >delay the kernel tracer doesnt measure any?
>
> Yes. That is correct. Very puzzling to me too.

well, i think this measurement issue needs resolving before jumping to
any generic conclusions. Not a single trace is extremely suspect. The
userspace timestamps are rdtsc based, or gettimeofday() based? In
theory, as long as no trace is triggered, there should not be any huge
overhead from tracing itself (when a trace is reported and saved then,
if the trace is large, it can be quite expensive that the tracer wont
report as a latency - but this isnt the case here).

	Ingo
