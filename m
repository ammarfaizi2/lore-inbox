Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVATIJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVATIJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 03:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVATIJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 03:09:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31980 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262077AbVATIIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 03:08:12 -0500
Date: Thu, 20 Jan 2005 09:07:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050120080720.GB12665@elte.hu>
References: <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu> <87llaruy6m.fsf@sulphur.joq.us> <20050118080218.GB615@elte.hu> <87pt02pt0r.fsf@sulphur.joq.us> <20050119082433.GE29037@elte.hu> <20050119143927.GA11950@elte.hu> <87651tmhwv.fsf@sulphur.joq.us> <20050119183202.GM12076@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119183202.GM12076@waste.org>
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


* Matt Mackall <mpm@selenic.com> wrote:

> > Or, should that be?
> > 
> > 	if (prio > 0 && prio <= 20 && policy != SCHED_NORMAL) {
> 
> Or you can just drop the 'prio == 1 &&' part for this test. Ingo was
> trying to be clever to allow some RT bits, but that's not really
> necessary.

actually, there may be some kernel threads that may run at RT priority
99. But i agree, dropping the test for prio==1 should work just as fine.

	Ingo
