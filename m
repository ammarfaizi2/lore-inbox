Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVAONuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVAONuH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVAONuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:50:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48362 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262286AbVAONtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:49:52 -0500
Date: Sat, 15 Jan 2005 14:49:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050115134922.GA10114@elte.hu>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu> <87fz15j325.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fz15j325.fsf@sulphur.joq.us>
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

> OK, I reran with just 5 processes reniced from -10 to -5.  On my
> system they were: events, khelper, kblockd, aio and reiserfs.  In
> addition, I reniced loop0 from -20 to -5.

> One major problem: this `nice --20' hack affects every thread, not
> just the critical realtime ones.  That's not what we want.  Audio
> applications make very conscious choices which threads run with high
> priority and which do not.

how much did this problem affect your test? Could the source of the 500
msec delays be the non-highprio components of the test that somehow
became nice --20?

	Ingo
