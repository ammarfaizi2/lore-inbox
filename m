Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271744AbRHUSnM>; Tue, 21 Aug 2001 14:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271751AbRHUSnB>; Tue, 21 Aug 2001 14:43:01 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:59910 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S271815AbRHUSlq>;
	Tue, 21 Aug 2001 14:41:46 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Date: 21 Aug 2001 18:38:33 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9lu9r9$n5v$9@abraham.cs.berkeley.edu>
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com.suse.lists.linux.kernel> <20010820211107.A20957@thunk.org.suse.lists.linux.kernel> <200108210136.f7L1aa008756@vindaloo.ras.ucalgary.ca.suse.lists.linux.kernel> <oupk7zyqhw3.fsf@pigdrop.muc.suse.de>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 998419113 23743 128.32.45.153 (21 Aug 2001 18:38:33 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 21 Aug 2001 18:38:33 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen  wrote:
>It is not that they are hard to fix; e.g. a $10 sound card
>with a noise generating circuit on input and a small daemon to feed
>/dev/audio to /dev/random can do it; [...]

This is a good idea, but do note that you have to be a little careful:
there are lots of ways that the result can look random enough to fool
/dev/random's entropy count but be non-random enough to provide much
less entropy than you'd otherwise expect (e.g., 60Hz effects, etc.).

I think it's a workable approach, and I warmly recommend using a broad
diversity of entropy sources (including, e.g., soundcards), but you just
have to be careful to avoid some of the pitfalls.
