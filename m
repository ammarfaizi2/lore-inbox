Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318912AbSIIXea>; Mon, 9 Sep 2002 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318976AbSIIXea>; Mon, 9 Sep 2002 19:34:30 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:25614 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S318912AbSIIXe3>; Mon, 9 Sep 2002 19:34:29 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: 9 Sep 2002 23:22:27 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aljafj$bjv$1@abraham.cs.berkeley.edu>
References: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk> <20020909165303.GA31597@waste.org> <alik0a$70c$1@abraham.cs.berkeley.edu> <20020909194707.GB31597@waste.org>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1031613747 11903 128.32.153.211 (9 Sep 2002 23:22:27 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 9 Sep 2002 23:22:27 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron  wrote:
>On Mon, Sep 09, 2002 at 04:58:50PM +0000, David Wagner wrote:
>> Whether you like it or not, you're already trusting Intel, if you're
>> using an Intel chip.  If Intel were malicious and out to get you, they
>> could have put a backdoor in the chip.  And a RNG is *much* easier to
>> reverse-engineer and audit than an entire CPU, so it would probably be
>> riskier for Intel to hide a backdoor in the RNG than in, say, the CPU.
>
>Not sure I buy that. Consider that with a CPU, you control the inputs,
>you've got a complete spec of the core functionality, you've got a
>huge testbed of code to test that functionality, and you've got a
>whole industry of people reverse engineering your work. 

There's no guarantee that the CPU behaves deterministically.
Maybe on April 1, 2005 (or after executing a magic sequence of
1000 instructions) it starts ignoring all privilege and permission
bits.  Good luck finding that through mere testing.

>More to the point, the backdoor we're worried about is one that
>compromises our encryption keys to passive observers. Doing that by
>making the RNG guessable is relatively easy. On the other hand
>determining whether a given snippet of code is doing RSA, etc. is
>equivalent to solving the halting problem, so it's seems to me pretty
>damn hard to usefully put this sort of back door into a CPU without
>sacrificing general-purpose functionality.

Ok, I agree: The RNG is the most natural, and one of the more
devastating places, to put a backdoor.  (There are other ways
of putting a backdoor in a CPU other than scanning to identify
RSA code, though.)
