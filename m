Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276489AbRJ3Ran>; Tue, 30 Oct 2001 12:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276361AbRJ3Rad>; Tue, 30 Oct 2001 12:30:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15635 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277047AbRJ3Ra1>; Tue, 30 Oct 2001 12:30:27 -0500
Date: Tue, 30 Oct 2001 18:30:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030183058.O1340@athlon.random>
In-Reply-To: <20011030175417.K1340@athlon.random> <XFMail.20011030182326.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <XFMail.20011030182326.pochini@shiny.it>; from pochini@shiny.it on Tue, Oct 30, 2001 at 06:23:26PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 06:23:26PM +0100, Giuliano Pochini wrote:
> 
> >> #ifdef ?
> >
> > yes, but not for ppc, for alpha and all other archs without accessed bit
> > provided in hardware (and cached in the tlb).
> 
> PPCs have that bits. I'm not sure if they are cached in the tbl.

yes, this is why it won't need to define the HAVE_NO_ACCESS_BIT_IN_TLB,
only alpha will.  but again I'm not sure if it worth given we just
reduced the flush frequency of an order of magnitude.

Andrea
