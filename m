Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVA1WTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVA1WTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVA1WTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:19:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11450 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262793AbVA1WT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:19:27 -0500
Date: Fri, 28 Jan 2005 23:19:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050128221900.GA10732@elte.hu>
References: <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us> <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <20050128080802.GA2860@elte.hu> <871xc62bot.fsf@sulphur.joq.us> <20050128084049.GA5004@elte.hu> <41FAB9A5.6020105@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FAB9A5.6020105@bigpond.net.au>
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


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> I think part of the problem here is that by comparing each tasks limit
> to the runqueue's usage rate (and to some extent using a relatively
> short decay period) you're creating the need for the limits to be
> quite large i.e. it has to be big enough to be bigger than the
> combined usage rates of all the unprivileged real time tasks and also
> to handle the short term usage rate peaks of the task.

actually, at least for Jackd use, the current average worked out pretty
well - setting the limit 5-10% above that of the reported average CPU
use gave a result that was equivalent to unrestricted SCHED_FIFO
results.

	Ingo
