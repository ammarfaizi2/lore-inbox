Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279977AbRJ3PUV>; Tue, 30 Oct 2001 10:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279976AbRJ3PUM>; Tue, 30 Oct 2001 10:20:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:1900 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S279978AbRJ3PUA>; Tue, 30 Oct 2001 10:20:00 -0500
Date: Tue, 30 Oct 2001 16:20:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030162008.G1340@athlon.random>
In-Reply-To: <20011029.173400.35036258.davem@redhat.com> <Pine.LNX.4.33.0110291736010.7778-100000@penguin.transmeta.com> <20011029212546.B17506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011029212546.B17506@redhat.com>; from bcrl@redhat.com on Mon, Oct 29, 2001 at 09:25:46PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 09:25:46PM -0500, Benjamin LaHaise wrote:
> I fully well expect it to be.  However, from the point of view of stability 
> we *want* to be conservative and correct.  If Al had to demonstrate with 

Dave just told you what this change has to do with stability, not sure
why you keep reiterating about stability and correctness.

But of course going from page flush to the mm flush is fine from my part
too. As Linus noted a few days ago during swapout we're going to block
and reschedule all the time, so the range flush is going to be a noop in
real life (the whole thing is an heuristic), and this is why it wasn't
implemented right now. But I agree it shouldn't hurt either and it looks
nicer.

Andrea
