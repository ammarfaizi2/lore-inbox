Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263589AbVBETHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbVBETHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 14:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273242AbVBETHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:07:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47776 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S273234AbVBETHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:07:23 -0500
Date: Sat, 5 Feb 2005 20:07:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Message-ID: <20050205190700.GA2323@elte.hu>
References: <20050204103350.241a907a.akpm@osdl.org> <200502051411.16194.rjw@sisk.pl> <20050205143511.GA28656@elte.hu> <200502051548.26729.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502051548.26729.rjw@sisk.pl>
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


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > I've attached a patch for touch_softlockup_watchdog() below - but i think
> > what we really need is another mechanism. I'm wondering what the primary
> > reason for the lockup-detection is - did swsuspend stop the the softlockup
> > threads? 
> 
> If my understanding is correct, the time between suspend (ie the
> creation of the image) and resume (ie the resotration of the image) is
> considered as spent in the kernel, so it triggers softlockup as soon
> as its threads are woken up (is that correct, Pavel?).

ah, ok. Could you try my patch and add touch_softlockup_watchdog() to
the resume code (before interrupts are re-enabled)?

	Ingo
