Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319301AbSHVDhm>; Wed, 21 Aug 2002 23:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319302AbSHVDhm>; Wed, 21 Aug 2002 23:37:42 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:47884 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S319301AbSHVDhl>; Wed, 21 Aug 2002 23:37:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: 22 Aug 2002 03:25:26 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ak1lj6$drl$3@abraham.cs.berkeley.edu>
References: <20020818021522.GA21643@waste.org> <Pine.LNX.4.44.0208171923330.1310-100000@home.transmeta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1029986725 14197 128.32.153.211 (22 Aug 2002 03:25:26 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 22 Aug 2002 03:25:26 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds  wrote:
>On the other hand, if you are _too_ anal you won't consider _anything_ 
>"truly random", and /dev/random becomes practically useless on things that 
>don't have special randomness hardware.

Well, /dev/random never was the right interface for most applications, and
this is arguably the real source of the problem.  For most applications,
what you want is something like /dev/urandom (possibly a version that
doesn't deplete all the true randomness available for /dev/random).  Very
few applications need true randomness; for most, cryptographic-quality
pseudorandomness should suffice.

1 bit of true randomness a minute should be more than sufficient for most
real applications.  (That means you can catastrophically reseed with 128
bits once every two hours, which sounds good to me.)
