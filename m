Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbUJ0LIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbUJ0LIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUJ0LIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:08:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32176 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262362AbUJ0LIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:08:41 -0400
Date: Wed, 27 Oct 2004 13:09:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027110939.GA30381@elte.hu>
References: <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027082831.GA15192@elte.hu> <20041027084401.GA15989@elte.hu> <20041027085221.GA16742@elte.hu> <20041027090620.GA17621@elte.hu> <20041027123329.14570992@mango.fruits.de> <20041027124524.693161b8@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027124524.693161b8@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> ah, and btw: what does the /proc/sys/kernel/kernel_preemption tunable
> do with PREEMPT_REALTIME enabled?

it's pretty pointless to offer this tunable, agreed. In theory one could
try to turn off involuntary preemption but what's the point?

> mango:~# cat /proc/sys/kernel/kernel_preemption 
> 1
> 
> [all the other VP tunables are not available anymore]
> 
> mango:~# cat /proc/sys/kernel/voluntary_preemption
> cat: /proc/sys/kernel/voluntary_preemption: No such file or directory
> mango:~# cat /proc/sys/kernel/hardirq_preemption
> cat: /proc/sys/kernel/hardirq_preemption: No such file or directory
> mango:~# cat /proc/sys/kernel/softirq_preemption
> cat: /proc/sys/kernel/softirq_preemption: No such file or directory

right - the PREEMPT_REALTIME kernel is only correct if all asynchronous
processing is done in a process context, so i removed those tunables.

	Ingo
