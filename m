Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131150AbQLNWmB>; Thu, 14 Dec 2000 17:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbQLNWlw>; Thu, 14 Dec 2000 17:41:52 -0500
Received: from fe3.rdc-kc.rr.com ([24.94.163.50]:59911 "EHLO mail3.kc.rr.com")
	by vger.kernel.org with ESMTP id <S131150AbQLNWlj>;
	Thu, 14 Dec 2000 17:41:39 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: Chris Lattner <sabre@nondot.org>, linux-kernel@vger.kernel.org
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit (and ioctl must die!)
In-Reply-To: <Pine.GSO.4.21.0012141331460.8287-100000@weyl.math.psu.edu>
From: Mike Coleman <mcoleman2@kc.rr.com>
Date: 14 Dec 2000 16:10:46 -0600
In-Reply-To: Alexander Viro's message of "Thu, 14 Dec 2000 14:11:32 -0500 (EST)"
Message-ID: <87wvd2mz6h.fsf@subterfugue.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:
> ioctl() is avoidable. Proof: Plan 9. They don't _have_ that system call.
> It doesn't mean that we should (or could) remove it. It _does_ mean that
> new APIs do not need it.

*I* sure wish we could.  From the standpoint of trying to trace system calls,
it's a big stinking black hole.  All of the other syscalls (I think) have
pretty well defined semantics in terms of what they do to a process' memory
space, but the semantics of ioctl are "may read or write any memory
whatsoever, and if you want to know what, well, it sucks to be you".

Even NT does this better, if I'm interpreting this correctly:

   http://msdn.microsoft.com/library/psdk/winbase/devio_9quk.htm

--Mike


-- 
[O]ne of the features of the Internet [...] is that small groups of people can
greatly disturb large organizations.  --Charles C. Mann
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
