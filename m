Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264900AbRFTPXe>; Wed, 20 Jun 2001 11:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbRFTPXP>; Wed, 20 Jun 2001 11:23:15 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:4105 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S264900AbRFTPXH>;
	Wed, 20 Jun 2001 11:23:07 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ahu@ds9a.nl (bert hubert),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <E15CR1f-0006Wh-00@the-village.bc.nu>
From: Jes Sorensen <jes@sunsite.dk>
Date: 20 Jun 2001 17:22:55 +0200
In-Reply-To: Alan Cox's message of "Tue, 19 Jun 2001 20:18:59 +0100 (BST)"
Message-ID: <d37ky7ch0w.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> But that foregoes the point that the code is far more complex and
>> harder to make 'obviously correct', a concept that *does* translate
>> well to userspace.

Alan> There I disagree. Threads introduce parallelism that the
Alan> majority of user space programmers have trouble getting right
Alan> (not that C is helpful here).

Alan> A threaded program has a set of extremely complex hard to repeat
Alan> timing based behaviour dependancies. An unthreaded app almost
Alan> always does the same thing on the same input. From a
Alan> verification and coverage point of view that is incredibly
Alan> important.

Not to mention how complex it is to get locking right in an efficient
manner. Programming threads is not that much different from kernel SMP
programming, except that in userland you get a core dump and retry, in
the kernel you get an OOPS and an fsck and retry.

For some reason CS professors decided that threads were the cool thing
to do and started teaching all their students to program threadded
applications. Unfortunately they did forget to teach about the caveats
and all the funny side effects that generally mostly threadded apps a
really stupid idea.

It's been like this for some years now, one would expect a switch to
another buzzword of the year paradigm from them soon.

Jes
