Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130133AbQKFTMM>; Mon, 6 Nov 2000 14:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130224AbQKFTMC>; Mon, 6 Nov 2000 14:12:02 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:5026 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S130133AbQKFTLz>;
	Mon, 6 Nov 2000 14:11:55 -0500
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
Cc: George Talbot <george@brain.moberg.com>, Marc Lehmann <pcg@goof.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land  programmer...
In-Reply-To: <200011061655.LAA21681@tsx-prime.MIT.EDU>
	<m33dh5aq9u.fsf@otr.mynet.cygnus.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 06 Nov 2000 11:11:27 -0800
In-Reply-To: Ulrich Drepper's message of "06 Nov 2000 10:50:37 -0800"
Message-ID: <m3snp4apb4.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

> "Theodore Y. Ts'o" <tytso@MIT.EDU> writes:
> 
> > Arguably though the bug is in glibc, in that if it's using signals
> > behinds the scenes, it should have passed SA_RESTART to sigaction.
> 
> Why are you talking  such a nonsense?

[Note to self: remove kitten from keyboard before writing mail.]

Glibc has to use signals because there *still* is not mechanism in the
kernel to allow synchronization.  After how many years.

I don't blame Linux.  He has no interest in threads and therefore
spends not much time thinking about it.  But everybody who's
complaining about things like this has to be willing to fix the real
problems.

Get your ass up and write a fast semaphore/mutex system.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
