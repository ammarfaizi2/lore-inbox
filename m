Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267422AbUHPEhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267422AbUHPEhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUHPEhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:37:21 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25728 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267422AbUHPEhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:37:19 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816042653.GA14738@elte.hu>
References: <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816024314.GA8960@elte.hu>
	 <20040816030818.GA10685@elte.hu> <1092629953.810.23.camel@krustophenia.net>
	 <20040816042653.GA14738@elte.hu>
Content-Type: text/plain
Message-Id: <1092631087.810.34.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 00:38:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 00:26, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > > just to check this theory, could you make __check_and_rekey() an empty
> > > > function? This should still produce a working random driver, albeit at
> > > > much reduced entropy. If these latencies have a relationship to the
> > > > mlockall() issue then this change should have an effect.
> > > 
> > > hm, could you disable the random driver in the .config rather? It seems
> > > that adding to the entropy pool (from hardirq context) alone is quite
> > > expensive too.
> > > 
> > 
> > Can this be disabled in the .config?  I can't find an option for it.
> 
> oh well, indeed it cannot be disabled.

Hmm, what happens if CONFIG_HW_RANDOM is set then?  I would call it a
bug if having a hardware RNG didn't disable the software /dev/random
driver.  This implies that the software RNG can be easily disabled.

Lee


