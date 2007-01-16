Return-Path: <linux-kernel-owner+w=401wt.eu-S1751464AbXAPJtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXAPJtr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXAPJtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:49:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51022 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbXAPJtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:49:46 -0500
Date: Tue, 16 Jan 2007 10:44:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ulrich Drepper <drepper@redhat.com>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
Message-ID: <20070116094450.GB11543@elte.hu>
References: <45A3BFAC.1030700@bull.net> <45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org> <45A73E90.7050805@bull.net> <20070112075816.GA23341@elte.hu> <45AC8E2A.3060708@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AC8E2A.3060708@bull.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pierre Peiffer <pierre.peiffer@bull.net> wrote:

> The modified hackbench is available here:
> 
> http://www.bullopensource.org/posix/pi-futex/hackbench_pth.c

cool!

> I've run this bench 1000 times with pipe and 800 groups.
> Here are the results:
> 
> Test1 - with simple list (i.e. without any futex patches)
> =========================================================
> Latency (s)      min      max      avg      stddev
>                 26.67    27.89    27.14        0.19

> Test2 - with plist (i.e. with only patch 1/4 as is)
>                 26.87    28.18    27.30        0.18

> Test3 - with plist but all SHED_OTHER registered
>                 26.74    27.84    27.16        0.18

ok, seems like the last one is the winner - it's the same as unmodified, 
within noise.

	Ingo
