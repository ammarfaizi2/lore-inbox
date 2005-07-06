Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVGGAXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVGGAXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVGFT7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:59:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:50061 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262281AbVGFQ26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:28:58 -0400
Date: Wed, 6 Jul 2005 18:28:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706162856.GB24728@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061351.18410.s0348365@sms.ed.ac.uk> <20050706133915.GB19467@elte.hu> <200507061658.53845.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061658.53845.s0348365@sms.ed.ac.uk>
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

> On Wednesday 06 Jul 2005 14:39, Ingo Molnar wrote:
> > * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > Then it continues to boot. I'm getting periodic lockups under high
> > > network load, however, though I suspect that might be the ipw2200
> > > driver I compiled against the realtime-preempt kernel. Are there any
> > > known issues with external modules versus PREEMPT-RT?
> >
> > you should keep an eye on compile-time warnings, but otherwise, most of
> > the API deviations should be runtime detected and should be reported in
> > one way or another (if you have all debugging options enabled).
> 
> I now no longer suspect the ipw2200 module. It locks up within 5 
> minutes, reliably, with or without network load. I seem to always have 
> to promote a large redraw in X11 before it occurs, but this is just 
> hand waving, I don't really have any evidence.

just to make sure: you dont have debug_direct_keyboard when using the 
console keyboard and mouse, correct? Sometimes i forget to turn it off 
and i get a crash in the keyboard or mouse irq after some time. Under X 
that often looks like a silent hard lockup.

	Ingo
