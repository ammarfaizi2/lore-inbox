Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279983AbRJ3Pen>; Tue, 30 Oct 2001 10:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279985AbRJ3Ped>; Tue, 30 Oct 2001 10:34:33 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:3335 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S279983AbRJ3PeY>;
	Tue, 30 Oct 2001 10:34:24 -0500
Date: Tue, 30 Oct 2001 13:34:50 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011030162008.G1340@athlon.random>
Message-ID: <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
> On Mon, Oct 29, 2001 at 09:25:46PM -0500, Benjamin LaHaise wrote:
> > I fully well expect it to be.  However, from the point of view of stability
> > we *want* to be conservative and correct.  If Al had to demonstrate with
>
> Dave just told you what this change has to do with stability, not sure
> why you keep reiterating about stability and correctness.
>
> But of course going from page flush to the mm flush is fine from my part
> too. As Linus noted a few days ago during swapout we're going to block
> and reschedule all the time, so the range flush is going to be a noop in

Only on architectures where the TLB (or equivalent) is
small and only capable of holding entries for one address
space at a time.

It's simply not true on eg PPC.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

