Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVA1Gjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVA1Gjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 01:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVA1Gjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 01:39:32 -0500
Received: from mx1.elte.hu ([157.181.1.137]:10191 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261486AbVA1Gj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 01:39:29 -0500
Date: Fri, 28 Jan 2005 07:38:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050128063857.GA32658@elte.hu>
References: <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106796360.5158.39.camel@npiggin-nld.site>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> But the important elements are lost. The standard provides a
> deterministic scheduling order, and a deterministic scheduling latency
> (of course this doesn't mean a great deal for Linux, but I think we're
> good enough for a lot of soft-rt applications now).
> 
> >  [1] http://www.opengroup.org/onlinepubs/007908799/xsh/realtime.html

no, the patch does not break POSIX. POSIX compliance means that there is
an environment that meets POSIX. Any default install of Linux 'breaks'
POSIX in a dozen ways, you have to take a number of steps to get a
strict, pristine POSIX environment. The only thing that changes is that
now you have to add "set RT_CPU ulimit to 0 or 100" to that (long) list
of things.

	Ingo
