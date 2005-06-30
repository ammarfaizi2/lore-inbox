Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbVF3U6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbVF3U6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbVF3U41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:56:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39564 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263151AbVF3UvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:51:03 -0400
Date: Thu, 30 Jun 2005 22:50:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050630205029.GB1824@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050629193804.GA6256@elte.hu> <200506300136.01061.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506301952.22022.annabellesgarden@yahoo.de>
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


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> Here come some numbers to back up the usefullness of 
> CONFIG_X86_UP_IOAPIC_FAST. (and to show that my patch actually works 
> ;-)) All measurement where taken on an UP Athlon64 2Ghz running 32bit 
> 2.6.12-RT-50-35 PREEMPT_RT on a K8T800 mobo.

thanks - the numbers are pretty convincing. I've applied most of your 
patch (except the instrumentation bits), and it seems to work quite well 
- one of my testsystems that had interrupt storms before can now run 
IOAPIC_FAST. (i also enabled the option to be selectable for SMP kernels 
too. If things work out fine we can make it default-on.) I've uploaded 
the -50-39 patch with these changes included.

	Ingo
