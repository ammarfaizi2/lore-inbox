Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289001AbSAFSie>; Sun, 6 Jan 2002 13:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289003AbSAFSiZ>; Sun, 6 Jan 2002 13:38:25 -0500
Received: from unknown-1-11.wrs.com ([147.11.1.11]:16820 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id <S289001AbSAFSiO>;
	Sun, 6 Jan 2002 13:38:14 -0500
From: mike stump <mrs@windriver.com>
Date: Sun, 6 Jan 2002 10:37:26 -0800 (PST)
Message-Id: <200201061837.KAA19546@kankakee.wrs.com>
To: dewar@gnat.com, guerby@acm.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: dewar@gnat.com
> To: dewar@gnat.com, guerby@acm.org
> Date: Sun,  6 Jan 2002 08:43:53 -0500 (EST)

> The point is that the implementation of a write has, given your
> quote from the RM, pretty much no choice but to do an exactly
> "correct" write, but for a read, there is nothing to stop reading
> MORE than the minimum, the requirement of atomicity is still
> met.

Ok, we can agree the wording in the standard sucks.  Though, I think
we might be able to agree on the intent and goal of the wording.  It
isn't allowed to mandate the byte read/write, as the machine may not
support it, and that would artificially constrain the machine from
being implementable on the platform, and this would be a bad idea.

I think the goal and intent, for Ada and C as well, is to say that the
compiler will generate what is possible from assembly code written by
an expert on the platform, using the best fitting access that is
possible.

Once we understand the standard and the motivation behind it, and what
it is trying to provide our users, and how our users might reasonably
use it, we can mandate for ourselves as a quality of implementation
issue, if you would like to call it that, those reasonable semantics.
Should we fail to provide them, and should users want them, then it is
finally up to the users to more completely describe the language they
want, and refine the language standards to include it.  But, in spite
of that, we don't have to go out of our way to do stupid things, nor
should be brow beat our users with, your code isn't conformant
needlessly.  It is all to easy to do that, we should resist the
temptation.
