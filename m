Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270037AbUJSRrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270037AbUJSRrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269996AbUJSRnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:43:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51624 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269997AbUJSRkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:40:55 -0400
Date: Tue, 19 Oct 2004 19:40:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
Message-ID: <20041019174050.GA18998@elte.hu>
References: <OF684A90CB.5A611764-ON86256F32.005DA19F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF684A90CB.5A611764-ON86256F32.005DA19F@raytheon.com>
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

> Booted to single user and was able to get some network operations
> going with this version (w/ previously mentioned update). However, at
> the step where I start CUPS, I got a number of traces on the display
> referring to parport_pc related function calls [but I don't use a
> parallel printer...]. It ended with:

thanks for the logs - there are some semaphore assumptions in
ieee1284.c, it should use completions & wait_for_completion_timeout()
too. The workaround is to disable CONFIG_PARPORT_1284. (or
CONFIG_PARPORT altogether.)

	Ingo
