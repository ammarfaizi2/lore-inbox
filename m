Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUE1J2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUE1J2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUE1J2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:28:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40863 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262422AbUE1J1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:27:43 -0400
Date: Fri, 28 May 2004 11:29:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <peterw@aurema.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH][2.6.6] Replacing CPU scheduler active and expired with a single array
Message-ID: <20040528092900.GA23347@elte.hu>
References: <40B6C571.3000103@aurema.com> <20040528090536.GA12933@elte.hu> <40B70542.2060006@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B70542.2060006@aurema.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <peterw@aurema.com> wrote:

> >just try it - run a task that runs 95% of the time and sleeps 5% of the
> >time, and run a (same prio) task that runs 100% of the time. With the
> >current scheduler the slightly-sleeping task gets 45% of the CPU, the
> >looping one gets 55% of the CPU. With your patch the slightly-sleeping
> >process can easily monopolize 90% of the CPU!
> 
> If these two tasks have the same nice value they should around robin
> with each other in the same priority slot and this means that the one
> doing the smaller bites of CPU each time will in fact get less CPU
> than the other i.e. the outcome will be the opposite of what you
> claim.

just try what i described with and without your patch and look at the
'top' output. You can do a simple loop plus short 10-20msec sleeps (via
nanosleep) to simulate a 95% busy task.

	Ingo
