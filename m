Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129767AbQKGPzE>; Tue, 7 Nov 2000 10:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbQKGPyz>; Tue, 7 Nov 2000 10:54:55 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:13200 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129767AbQKGPyn>;
	Tue, 7 Nov 2000 10:54:43 -0500
Date: Tue, 7 Nov 2000 10:53:23 -0500
Message-Id: <200011071553.KAA21829@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: drepper@cygnus.com
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        George Talbot <george@brain.moberg.com>, Marc Lehmann <pcg@goof.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: Ulrich Drepper's message of 06 Nov 2000 10:50:37 -0800,
	<m33dh5aq9u.fsf@otr.mynet.cygnus.com>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land  programmer...
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ulrich Drepper <drepper@redhat.com>
   Date: 06 Nov 2000 10:50:37 -0800

   > Arguably though the bug is in glibc, in that if it's using signals
   > behinds the scenes, it should have passed SA_RESTART to sigaction.

   Why are you talking  such a nonsense?

The claim was made that pthreads was using signals behind the scenes, so
that programs which weren't expecting that system calls to get
interrupted were getting interrupted.  Hence, one could make the
argument that if the pthreads code had used SA_RESTART to set up its
signal handlers, then this situation wouldn't have come up.

I haven't looked more deeply into this.  As far as I'm concerned,
threads === "more rope" and use of threads should be avoided whenever
possible, even if Linux had a decent threads implementation....

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
