Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUHJKM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUHJKM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHJKLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:11:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61113 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264251AbUHJKL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:11:29 -0400
Date: Tue, 10 Aug 2004 12:12:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810101232.GA2706@elte.hu>
References: <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe> <1092117141.761.15.camel@mindpipe> <20040810080933.GA26081@elte.hu> <1092125864.848.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092125864.848.2.camel@mindpipe>
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


i've uploaded a new version of the preempt-timing patch:

  http://redhat.com/~mingo/voluntary-preempt/preempt-timing-on-2.6.8-rc3-O4.patch

this patch fixes a number of false positives and false negatives. In
particular it fixes the idle-task false positives, and it now correctly
measures preemption delays in softirq and hardirq contexts and in
bh-disabled process contexts. Maybe this sheds a light on some of the
more mysterious delays that we've seen. (and which were never directly
measured before.)

(the patch also got alot simpler, which should help portability.)

	Ingo
