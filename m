Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUKBT2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUKBT2u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUKBT2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:28:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:54733 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261340AbUKBT0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:26:41 -0500
Date: Tue, 2 Nov 2004 20:27:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041102192709.GA1674@elte.hu>
References: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com> <20041102191858.GB1216@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102191858.GB1216@elte.hu>
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

> > This build appears to run OK and then in the middle of the real time
> > tests stops doing useful work (during network test).
> 
> weird, the deadlock detector did not trigger, although it is a clear
> circular deadlock:

ah ... found it - a fair portion of spinlocks and rwlocks had deadlock
detection turned off in -V0.6.6 - amongst them ptype_lock. I've uploaded
-V0.6.9 that fixes this.

	Ingo
