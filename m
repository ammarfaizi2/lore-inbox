Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270195AbUJTIDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270195AbUJTIDC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270064AbUJTH5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:57:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49287 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270054AbUJTHk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:40:58 -0400
Date: Wed, 20 Oct 2004 09:40:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
Message-ID: <20041020074049.GA20963@elte.hu>
References: <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <1098229098.26927.40.camel@cmn37.stanford.edu> <1098229166.12223.1153.camel@thomas> <1098248541.12223.1450.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098248541.12223.1450.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 2004-10-20 at 01:39, Thomas Gleixner wrote:
> > That's in scsi_error_handler() where a mutex is initialized locked and
> > then acquired again. This triggers the deadlock/correctness check.
> 
> Some more fixes
> 
> - scsi_error_handler() fix
> 
> - device subsystem device_remove locking fix

thanks, i've applied these. The block/loop.c assert reported by Rui
seems to be a similar problem too.

	Ingo
