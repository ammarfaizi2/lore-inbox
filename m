Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbULIQCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbULIQCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbULIQCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:02:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:25316 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261542AbULIQCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:02:18 -0500
X-Authenticated: #4399952
Date: Thu, 9 Dec 2004 17:17:09 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Mark_H_Johnson@raytheon.com
Cc: Ingo Molnar <mingo@elte.hu>, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209171709.7f80b823@mango.fruits.de>
In-Reply-To: <OF7A3735CE.0606A36B-ON86256F65.00512706@raytheon.com>
References: <OF7A3735CE.0606A36B-ON86256F65.00512706@raytheon.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004 09:16:49 -0600
Mark_H_Johnson@raytheon.com wrote:

> Comparison of .32-5RT and .32-5PK results
> RT has PREEMPT_RT,
> PK has PREEMPT_DESKTOP and no threaded IRQ's.
> 2.4 has lowlat + preempt patches applied

But you do have set your reference irq (soundcard) to the highest prio
in the PREEMPT_RT case? I just ask to make sure. Also, the PK results
can probably even be improved by having all irq handlers threaded except
for the soundcard irq.

> 
>       within 100 usec
>        CPU loop (%)   Elapsed Time (sec)    2.4
> Test   RT     PK        RT      PK   |   CPU  Elapsed
> X     90.46  99.88      67 *    63+  |  97.20   70
> top   83.03  99.87      35 *    33+  |  97.48   29
> neto  91.69  97.57     360 *   320+* |  96.23   36
> neti  88.37  97.79     360 *   300+* |  95.86   41
> diskw 87.73  67.41     360 *    57+* |  77.64   29
> diskc 86.35  99.39     360 *   320+* |  84.12   77
> diskr 81.57  99.89     360 *   320+* |  90.66   86
> total                 1902    1413   |         368
>  [higher is better]  [lower is better]
> * wide variation in audio duration
> + long stretch of audio duration "too fast"
> 

Flo

-- 
Palimm Palimm!
http://affenbande.org/~tapas/
