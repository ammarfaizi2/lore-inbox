Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUHPD1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUHPD1q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUHPD1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:27:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61323 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267388AbUHPD1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:27:43 -0400
Date: Mon, 16 Aug 2004 05:28:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816032806.GA11750@elte.hu>
References: <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092624221.867.118.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> I believe the constant-time behavior that I reported was an artifact
> of ALSA xrun debugging.  Now it seems like the latency produced *does*
> correspond directly to the amount of memory being mlockall'ed.  If
> ./mlockall-test 1500 triggers an xrun at all it's ~0.2ms.  3000
> triggers a ~1ms xrun, and 10000 a ~3 ms xrun.

could you try more extreme values - e.g. does 100 MB cause a 30 msec
xrun?

	Ingo
