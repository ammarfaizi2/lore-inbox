Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277316AbRKDBqA>; Sat, 3 Nov 2001 20:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277341AbRKDBpu>; Sat, 3 Nov 2001 20:45:50 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5138 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277316AbRKDBpm>; Sat, 3 Nov 2001 20:45:42 -0500
Date: Sun, 4 Nov 2001 02:45:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.ent,
        torvalds@transmeta.com
Subject: Re: VM test comparison of 2.4.14-pre5, aa1, and 2.4.13-ac5-fs
Message-ID: <20011104024541.H1898@athlon.random>
In-Reply-To: <20011030022640.A225@earthlink.net> <20011030154911.E1340@athlon.random> <20011031004129.A207@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011031004129.A207@earthlink.net>; from rwhron@earthlink.net on Wed, Oct 31, 2001 at 12:41:29AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 12:41:29AM -0500, rwhron@earthlink.net wrote:
> So I'm thinking about just continuing to use the mtest01 from LTP, 
> knowing that with my test conditions, a variation of a few percent 
> isn't significant.
> 
> Andrea, is that okay with you?

Why don't you use the -b option with the mean size of all the previous
runs that you did with the default -p option? this way you'd avoid
throwing away all the previous results and the new ones would be more
reliable. I'd prefer if you would allocate always the same amount of
memory, the variations are not huge, so I guess it's better to reduce
the userspace noise.

In particular I'm interested if you can see significant performance
variations between pre5aa1 and pre6aa1 and pre7aa2. I'm also testing
here (mainly Linus's 40m kde test to verify interactive response on real
life that unfortunately cannot produce raw numbers) and I didn't had
much time to spend producing numbers since there was also some bug to
fix utill yesterday (should be all fixed in pre7aa2). The recent changes
were mostly in function of the kde mem=40m workload that is pretty well
usable for me in pre7aa2 (xmms never skips one beat while playing mp3
even if mem=40m and browsing the web with konqueror is fluid, mozilla
also is usable but much slower than konqueror with mem=40m because it's
a true memory hog at least when flash starts and of course it shares
less libs with the rest of the desktop).

Andrea
