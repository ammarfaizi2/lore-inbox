Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVBBUeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVBBUeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbVBBUee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:34:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5830 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262370AbVBBUaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:30:35 -0500
Date: Wed, 2 Feb 2005 21:29:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050202202953.GA9840@elte.hu>
References: <20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us> <1106782165.5158.15.camel@npiggin-nld.site> <874qh3bo1u.fsf@sulphur.joq.us> <1106796360.5158.39.camel@npiggin-nld.site> <87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu> <873bwfo8br.fsf@sulphur.joq.us> <1107370770.3104.136.camel@krustophenia.net> <87pszikbcv.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pszikbcv.fsf@sulphur.joq.us>
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

> I guess you're right, Lee.  I hadn't thought of it that way.  It just
> looks broken to me because we have no standing in any normal kernel
> requirements process.  That's a shame, but it does seem less like a
> systemic issue.

you have just as much standing, and you certainly went to great lengths
(writing patches, testing stuff, etc.) to address this issue - it is
just an unfortunate situation that the issue here is _not_ clear-cut at
all. It is a longstanding habit on lkml to try to solve things as
cleanly and generally as possible, but there are occasional cases where
this is just not possible.

e.g. technically it was much harder to write all the latency-fix patches
(and infrastructure around it) that are now in 2.6.11-rc2, but it was
also a much clearer issue, with clean solutions; so there was no
conflict about whether to do it and you'll reap the benefits of that in
2.6.11.

so forgive us this stubborness, it's not directed against you in person
or against any group of users, it's always directed at the problem at
hand. I think we can do the LSM thing, and if this problem comes up in
the future again, then maybe by that time there will be a better
solution. (e.g. it's quite possible that something nice will come out of
the various virtualization projects, for this problem area.)

	Ingo
