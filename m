Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVAQOiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVAQOiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 09:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVAQOiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 09:38:08 -0500
Received: from mx1.elte.hu ([157.181.1.137]:14041 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262808AbVAQOiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 09:38:05 -0500
Date: Mon, 17 Jan 2005 15:36:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050117143654.GB10341@elte.hu>
References: <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us> <20050115134922.GA10114@elte.hu> <874qhiwb1q.fsf@sulphur.joq.us> <871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us> <20050117091740.GA21384@speedy.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117091740.GA21384@speedy.student.utwente.nl>
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


* Sytse Wielinga <s.b.wielinga@student.utwente.nl> wrote:

> We are talking about two different things here. POSIX is just about
> API and has, correct me if I'm wrong, nothing to do with system calls
> whatsoever. The manpage nice(2) is about the libc library call nice(),
> which is per-process, which it should be according to POSIX. The
> system call, called sys_nice() in C, is per-thread. Apparently glibc
> or some thread library contains some magic to make the translation.

AFAIK there's no such translation at the glibc level - i.e. you'll get
per-thread semantics. (glibc really needs kernel help to do the
per-process things cleanly.) Anyway, this hasnt been a big issue in the
past, and especially for the current testing purpose this behavior is
what we need right now.

	Ingo
