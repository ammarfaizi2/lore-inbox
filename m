Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVBHLFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVBHLFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 06:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVBHLFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 06:05:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:41450 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261512AbVBHLFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 06:05:02 -0500
Date: Tue, 8 Feb 2005 12:04:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Message-ID: <20050208110418.GA878@elte.hu>
References: <20050204103350.241a907a.akpm@osdl.org> <200502062015.56458.rjw@sisk.pl> <20050207085728.GA17197@elte.hu> <200502071353.57660.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502071353.57660.rjw@sisk.pl>
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

> The warning is printed right after the image is restored (ie somewhere
> around the local_irq_enable() above, but it goes before the "PM: Image
> restored successfully." message that is printed as soon as the return
> is executed).  Definitely, less than 1 s passes between the resoring
> of the image and the warining.
> 
> BTW, I've also tried to put touch_softlockup_watchdog() before
> device_power_up(), but it didn't change much.

this is a single-CPU box, right?

could you put a printk into touch_softlockup_watchdog() and re-try your
modified tree - in which order do the messages get printed? (perhaps
also add a jiffies printout to both the lockup message and to
touch_softlockup_watchdog())

	Ingo
