Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbUKLSZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbUKLSZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 13:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbUKLSZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 13:25:08 -0500
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:23432 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S262600AbUKLSYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 13:24:21 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
To: Shane Shrybman <shrybman@aei.ca>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF6E8C462B.2451EF23-ON86256F4A.0064AC96@raytheon.com>
From: Mark_H_Johnson@RAYTHEON.COM
Date: Fri, 12 Nov 2004 12:23:51 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/12/2004 12:23:56 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Typical example of the error message:
>
>kernel: hde: dma_timer_expiry: dma status == 0x24
>kernel: ALSA sound/core/pcm_native.c:1424: playback drain error (DMA or
IRQ trouble?)
>kernel: PDC202XX: Primary channel reset.
>kernel: hde: DMA interrupt recovery
>kernel: hde: lost interrupt
>
>This was on a Promise TX2 133 ide card with one IDE disk. The problem
>would show itself if using the RT patches and APIC. But the problem seems
>to have been resolved now.

I had errors like that one when the IDE IRQ was at a priority less than
the real time task. Since then, I run with all the IRQ's at max RT priority
and will continue to do so until I get a better assessment of what my real
application (not these audio tests...) needs for IRQ priorities.

This may have been fixed as a side effect of Ingo setting the IRQ threads
at
RT priorities in the 40's.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

