Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbREXXJr>; Thu, 24 May 2001 19:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262498AbREXXJh>; Thu, 24 May 2001 19:09:37 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:44534 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262500AbREXXJX>; Thu, 24 May 2001 19:09:23 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105242308.f4ON8fv8015978@webber.adilger.int>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8
In-Reply-To: <200105242110.OAA29766@csl.Stanford.EDU> "from Dawson Engler at
 May 24, 2001 02:10:00 pm"
To: Dawson Engler <engler@csl.stanford.edu>
Date: Thu, 24 May 2001 17:08:40 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler writes:
> Here are 37 errors where variables >= 1024 bytes are allocated on a
> function's stack.

First of all, thanks very much for the work you are doing.  It really
is useful, and a good way to catch those very rare error cases that
would not otherwise be fixed.

I'm curious about this stack checker.  Does it check for a single
stack allocation >= 1024 bytes, or does it also check for several
individual, smaller allocations which total >= 1024 bytes inside
a single function?  That would be equally useful.

On a side note, does anyone know if the kernel does checking if the
stack overflowed at any time?  It is hard to use Dawson's tools to
verify call paths because of interrupts and such, but I wonder what
happens when the kernel stack overflows - OOPS, or silent corruption?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
