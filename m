Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVF0IQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVF0IQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVF0IQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:16:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5335 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261919AbVF0IQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:16:42 -0400
Date: Mon, 27 Jun 2005 10:15:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050627081542.GA15096@elte.hu>
References: <Pine.LNX.4.58.0506221434170.22191@echo.lysdexia.org> <20050622220007.GA28258@elte.hu> <Pine.LNX.4.58.0506221558260.22649@echo.lysdexia.org> <20050623001023.GC11486@elte.hu> <Pine.LNX.4.58.0506231330450.27096@echo.lysdexia.org> <Pine.LNX.4.58.0506231755020.27757@echo.lysdexia.org> <20050624070639.GB5941@elte.hu> <Pine.LNX.4.58.0506241510040.32173@echo.lysdexia.org> <20050625041453.GC6981@elte.hu> <Pine.LNX.4.58.0506262102250.32435@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506262102250.32435@echo.lysdexia.org>
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

> I still haven't been able to get any NMI watchdog traces with the 
> lockups induced by VLC and burnP6.  Early printk is enabled on the 
> serial console. I have noticed, however, that scheduling performance 
> slowly degrades during the ~1 minute before locking up.  Once I was 
> able to get a delayed SysRq response (~30s) from the serial console 
> after the X console became unresponsive.  Is this possibly a scheduler 
> starvation issue that affects everything, including the NMI watchdog?  
> Any more suggestions for catching a trace?

hm. Nothing should starve the NMI watchdog. Only a nasty, complete 
kernel crash or a hardware failure can lock up the box in a way that not 
even the NMI watchdog can get some message out to the console. Just in 
case, could you try the latest patch (-50-24 or later), there were a 
couple of bugs fixed.

	Ingo
