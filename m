Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVAXVD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVAXVD1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXVCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:02:03 -0500
Received: from mx1.elte.hu ([157.181.1.137]:40911 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261651AbVAXUzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:55:51 -0500
Date: Mon, 24 Jan 2005 21:55:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Con Kolivas <kernel@kolivas.org>, Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050124205509.GB20485@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <877jm3qqxz.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877jm3qqxz.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> Has anyone done this kind of realtime testing on an SMP system?  I'd
> love to know how they compare.  Unfortunately, I don't have access to
> one at the moment.  Are they generally better or worse for this kind
> of work?  I'm not asking about partitioning or processor affinity, but
> actually using the entire SMP complex as a realtime machine.

this particular test was done with an UP kernel. (although the
testsystem indeed is an SMP box.) Generally i mention SMP explicitly. 
There are a couple of patches in the -RT tree to make RT scheduling
better on SMP systems.

with those fixes applied (i.e. under the -RT kernel), jackd/jack_test
behaves better than on a single CPU. I didnt find any scheduling anomaly
that wasnt caused by the kernel.

	Ingo
