Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbUJ0VMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbUJ0VMp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbUJ0VIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:08:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36569 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262728AbUJ0VD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:03:29 -0400
Date: Wed, 27 Oct 2004 23:04:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@RAYTHEON.COM
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041027210422.GA26586@elte.hu>
References: <OFB2831BD0.16B54A00-ON86256F3A.00544150@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB2831BD0.16B54A00-ON86256F3A.00544150@raytheon.com>
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


* Mark_H_Johnson@RAYTHEON.COM <Mark_H_Johnson@RAYTHEON.COM> wrote:

> [5] Running my stress test, the first test (X server) appeared to run
> OK. The second test (/proc or top) did not run properly. The RT audio
> test appeared to take the whole system (both CPU's) and the terminal
> window showing top did not appear until the audio test finished (and
> was quickly taken down by the script). Could not move the mouse at all
> during that test. The third test (network output) ran a short period
> and then the machine locked up. Had to use the hardware reset to
> recover.

the network one could perhaps be related to the network deadlocks
reported by others. Would be nice to turn on RWSEM_DETECT_DEADLOCKS and
to use a serial logging if possible.

does the audio test use alot of CPU time? In that case it would be
normal for the RT task to 'lock' the system up. In any case it would be
nice to try 0.4.2 because it has more check-preemption fixes affecting
both UP and SMP systems.

	Ingo
