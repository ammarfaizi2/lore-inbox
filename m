Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272747AbTHPG23 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 02:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272780AbTHPG23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 02:28:29 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:64782 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S272747AbTHPG22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 02:28:28 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Date: Sat, 16 Aug 2003 06:27:44 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bhkit0$nu1$1@abraham.cs.berkeley.edu>
References: <20030809173329.GU31810@waste.org> <20030815004004.52f94f9a.davem@redhat.com> <20030815095503.C2784@pclin040.win.tue.nl> <20030815202235.GB13384@speare5-1-14>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1061015264 24513 128.32.153.211 (16 Aug 2003 06:27:44 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 16 Aug 2003 06:27:44 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson  wrote:
>If entropy(x) == entropy(y), then:
>
>entropy(x) >= entropy(x xor y)
>entropy(y) >= entropy(x xor y)

No, that's still wrong.  Please see my earlier email with a counterexample.
That counterexample disproves not only the earlier claim, but also this more
recent revised claim.

Let x and y be two 80-bit strings.  Assume that x is either 0 or 1
(equal probability for both possibilities).  Assume y is either 0 or 2
(equal probability for both possibilities), and is independent of x.  Then
  entropy(x) = 1 bit
  entropy(y) = 1 bit
  entropy(x xor y) = 2 bits

Again, I believe there is little basis to distinguish between taking the
first half of SHA vs. xor-ing both the halves of SHA.  One can come up with
scenarios where one or the other is better, but there is little basis for
believing that one of those scenarios is especially more likely than the
other.

In short, we're arguing about how many angels can fit on a pinhead.
There are far better things to be worrying about.
