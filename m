Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292181AbSBBBg2>; Fri, 1 Feb 2002 20:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292182AbSBBBgS>; Fri, 1 Feb 2002 20:36:18 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:5381 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S292181AbSBBBgH>;
	Fri, 1 Feb 2002 20:36:07 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Continuing /dev/random problems with 2.4
Date: 2 Feb 2002 01:33:48 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <a3ffls$tsv$1@abraham.cs.berkeley.edu>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <20020201124300.G763@lynx.adilger.int> <3C5AF6B5.5080105@zytor.com> <20020201152829.A2497@havoc.gtf.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1012613628 30623 128.32.45.153 (2 Feb 2002 01:33:48 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 2 Feb 2002 01:33:48 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik  wrote:
>There actually used to be a timer function in i810_rng driver which
>directly added entropy to the pool.  batch_entropy_store was exported in
>order to do this.
>
>However, that was just the quick and dirty way.  You DO NOT want to do
>this in the kernel, because one must perform fitness tests on the random
>data before adding it to the kernel's /dev/[u]random entropy pool.
>Putting proper fitness tests into the kernel is just plain code bloat.

Hmm.  I don't quite follow your reasoning.  Does the kernel already
perform fitness tests on random data from other drivers?  I don't
think so.

The i810 rng seems much less prone to entropy failure than the data
currently collected from I/O events.  Why are fitness tests for it more
important than for the existing entropy sources that are currently in
the kernel?

What am I missing?
