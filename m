Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292184AbSBBCIB>; Fri, 1 Feb 2002 21:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292185AbSBBCHv>; Fri, 1 Feb 2002 21:07:51 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:13829 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S292184AbSBBCHs>;
	Fri, 1 Feb 2002 21:07:48 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Continuing /dev/random problems with 2.4
Date: 2 Feb 2002 02:05:29 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <a3fhh9$u87$1@abraham.cs.berkeley.edu>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1012615529 30983 128.32.45.153 (2 Feb 2002 02:05:29 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 2 Feb 2002 02:05:29 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Monta  wrote:
>Many motherboards have on-board sound.  Why not turn the mic
>gain all the way up and use the noise---surely there will be
>a few bits' worth?

That may be reasonable, but beware: there are some potential pitfalls.
For instance, is there a risk that the audio data you read is strongly
correlated to 60Hz mains noise in some scenarios?  Also, my understanding
is that the quality of randomness you get can depend on which sound card
you have, and moreover that the left and right channels can be strongly
correlated (audio-entropyd takes the difference between the two).
I think there are some things you can do, but it seems that one might
want to be a bit careful here.

In general, I am warmly supportive of using as diverse a set of entropy
sources as possible to provide robustness in case one source unexpectedly
fails, but I also recommend care in analyzing how much entropy each
source really gives you (it seems prudent to be a bit conservative in
one's entropy estimates, due to the variety of subtle effects that can
compromise the quality of your randomness sources).

Also, you may be interested in audio-entropyd, rexx, and Nautilus,
all of which use something like this as part of their entropy collection.
