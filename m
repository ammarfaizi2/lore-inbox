Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUG3PTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUG3PTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbUG3PTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:19:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10399 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267703AbUG3PTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:19:52 -0400
Date: Fri, 30 Jul 2004 17:20:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Shane Shrybman <shrybman@aei.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
Message-ID: <20040730152040.GA13030@elte.hu>
References: <1091196403.2401.10.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091196403.2401.10.camel@mars>
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


* Shane Shrybman <shrybman@aei.ca> wrote:

> Twice while using -L2 my IBM PS2 keyboard has become completely
> non-responsive. USB mouse and everything else seems to be fine, but no
> LEDs or anything from the keyboard.
> 
> On both occasions the last key I hit on the keyboard was numlock and the
> numlock did not come on and I had to reboot after that.
> 
> UP, x86, gcc 2.95, scsi + ide, bttv
> 
> Resolved in M5?

M5 does that differently, yes - so could you try it? If you still get
problems, does this fix it:

	echo 0 > /proc/irq/1/*/threaded

(this turns the IRQ 1 thread off.)

	Ingo
