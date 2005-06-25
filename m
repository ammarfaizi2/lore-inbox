Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVFYEQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVFYEQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbVFYEQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:16:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62642 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261416AbVFYEPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:15:12 -0400
Date: Sat, 25 Jun 2005 06:14:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050625041453.GC6981@elte.hu>
References: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org> <20050622082450.GA19957@elte.hu> <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org> <20050622220007.GA28258@elte.hu> <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org> <20050623001023.GC11486@elte.hu> <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org> <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu> <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> On Fri, 24 Jun 2005, Ingo Molnar wrote:
> 
> > do you have the NMI watchdog enabled? Find below 
> > serial-logging-earlyprintk-nmi.txt.
> 
> I had a serial console up, but not NMI watchdog until now.  Here's 
> some NMI watchdog traces from both -50-17 and -50-18:

all of these traces seem to have lockupcli involved - is that correct?  
lockupcli is just a userspace test-app to artificially trigger a 
hard-lockup (it disables interrupts and goes into an infinite loop). So 
the NMI watchdog triggering on lockupcli would be normal and expected.  
So once this works, it would be nice to reproduce whatever hard lockup 
you are seeing and see whether the NMI watchdog produces any output to 
the serial log. (if such log is supposed to be included in your dmesg 
then it somehow got intermixed with lockupcli logs)

	Ingo
