Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVBOHDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVBOHDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 02:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVBOHDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 02:03:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:31120 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261638AbVBOHC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 02:02:59 -0500
Date: Tue, 15 Feb 2005 08:02:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <ntl@pobox.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6-bk: cpu hotplug + preempt = smp_processor_id warnings galore
Message-ID: <20050215070217.GB13568@elte.hu>
References: <20050211232821.GA14499@otto> <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com> <20050214215948.GA22304@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214215948.GA22304@otto>
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


* Nathan Lynch <ntl@pobox.com> wrote:

> Works ok here.
> 
> It looks as if we need to explicitly bind worker threads to a newly
> onlined cpu.  This gets rid of the smp_processor_id warnings from
> cache_reap.  Adding a little more instrumentation to the debug
> smp_processor_id showed that new worker threads were actually running
> on the wrong cpu...
> 
> Does this look ok?

indeed - looks much better than the 'turn off the warning' solution.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
