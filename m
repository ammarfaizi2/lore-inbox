Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVGGLdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVGGLdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVGGLbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:31:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:14567 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261304AbVGGL3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:29:52 -0400
Date: Thu, 7 Jul 2005 13:29:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050707112936.GA26335@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050706204429.GA1159@elte.hu> <200507071046.41938.s0348365@sms.ed.ac.uk> <200507071221.47946.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507071221.47946.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Unfortunately, since this is called when the kernel crashes, it's 
> impossible for me to capture any messages prior to this spam, if there 
> even are any.

this is where serial logging (or netconsole/netlogging) may be useful.

do you have DEBUG_STACKOVERFLOW and latency tracing still enabled?  The 
combination of those two options is pretty good at detecting stack 
overflows. Also, you might want to enable CONFIG_4KSTACKS, that too 
disturbs the stack layout enough so that the error message may make it 
to the console.

	Ingo
