Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbUKDKF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbUKDKF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 05:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUKDKF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 05:05:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38049 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262151AbUKDKFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 05:05:52 -0500
Date: Thu, 4 Nov 2004 11:06:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
Message-ID: <20041104100634.GA29785@elte.hu>
References: <4189108C.2050804@blueyonder.co.uk> <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk> <418988A6.4090902@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418988A6.4090902@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> >include/asm/vsyscall.h:48: error: previous declaration of `__xtime_lock'
> 
> Does the patch below fix the above error?

i applied your earlier patch but many more changes were needed to port
PREEMPT_REALTIME (and in particular, PREEMPT_HARDIRQS) to x64. You can
check out the x64 bits in -V0.7.8 which can be downloaded from the usual
place:

   http://redhat.com/~mingo/realtime-preempt/

Sid, does this one build/work for you? (i had to disable CPUFREQ in the
.config to get it to build - an -mm bug i suspect.)

	Ingo
