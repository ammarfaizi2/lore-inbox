Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275398AbTHNTlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275405AbTHNTlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:41:21 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:46352 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S275398AbTHNTlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:41:07 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Date: Thu, 14 Aug 2003 19:40:25 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bhgoj9$9ab$1@abraham.cs.berkeley.edu>
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1060890025 9547 128.32.153.211 (14 Aug 2003 19:40:25 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Thu, 14 Aug 2003 19:40:25 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson  wrote:
>Throwing away 80 bits of the 160 bit output is much better
>than folding the two halves together.  In all the cases we've
>discussed where folding might improve matters, throwing away half the
>output would be even better.

I don't see where you are getting this from.  Define
  F(x) = first80bits(SHA(x))
  G(x) = first80bits(SHA(x)) xor last80bits(SHA(x)).
What makes you think that F is a better (or worse) hash function than G?

I think there is little basis for discriminating between them.
If SHA is cryptographically secure, both F and G are fine.
If SHA is insecure, then all bets are off, and both F and G might be weak.
