Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271777AbRHUSXA>; Tue, 21 Aug 2001 14:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271779AbRHUSWu>; Tue, 21 Aug 2001 14:22:50 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:45830 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271777AbRHUSWn>;
	Tue, 21 Aug 2001 14:22:43 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: /dev/random in 2.4.6
Date: 21 Aug 2001 18:19:29 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lu8nh$n5v$2@abraham.cs.berkeley.edu>
In-Reply-To: <Pine.LNX.4.30.0108200942060.4612-100000@waste.org> <605104920.998386381@[169.254.45.213]>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998417969 23743 128.32.45.153 (21 Aug 2001 18:19:29 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Aug 2001 18:19:29 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel  wrote:
>Equally, I do not want want to read /dev/urandom (and not block) which, in
>an absence of entropy, is (arguably) cryptographically weaker (see below).

This doesn't make any sense to me.  You're using SSL, so you already
have to trust MD5 and SHA.  The only way that /dev/urandom might even
plausibly be in trouble is if those hash functions are broken, but in
this case SSL is in even worse trouble.  If you're using the random
numbers for cryptographic purposes, you might as well use /dev/urandom.
Your fears about weaknesses in /dev/urandom seem to completely unfounded.

There is a perfectly good technical solution available, and it is called
/dev/urandom.  I hope this reassures you...

>The point is simple: We say to authors of cryptographic applications
>(ssl, ssh etc.) that they should use /dev/random, because /dev/urandom
>is not cryptographically strong enough.

Whoever says this is simply wrong.  There are a few isolated scenarios
where /dev/urandom is not sufficient and where /dev/random is needed,
but they are very rare, and they have nothing to do with weaknesses in
/dev/urandom (they have to do with recovering from host compromises,
and they're a second- or third-order concern).
