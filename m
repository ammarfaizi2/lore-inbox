Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276330AbRJ3RRX>; Tue, 30 Oct 2001 12:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275743AbRJ3RRO>; Tue, 30 Oct 2001 12:17:14 -0500
Received: from altus.drgw.net ([209.234.73.40]:46605 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S278464AbRJ3RRF>;
	Tue, 30 Oct 2001 12:17:05 -0500
Date: Tue, 30 Oct 2001 11:16:12 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030111612.C13806@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com> <20011030095757.A9956@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030095757.A9956@hq2>; from yodaiken@fsmlabs.com on Tue, Oct 30, 2001 at 09:57:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 09:57:57AM -0700, Victor Yodaiken wrote:
> On Tue, Oct 30, 2001 at 08:38:31AM -0800, Linus Torvalds wrote:
> > > It's simply not true on eg PPC.
> > 
> > Now, it's not true on _all_ PPC's.
> > 
> > The sane PPC setups actually have a regular soft-filled TLB, and last I
> > saw that actually performed _better_ than the stupid architected hash-
> > chains. And for the broken OS's (ie AIX) that wants the hash-chains, you
> > can always make the soft-fill TLB do the stupid thing..
> 
> You can't turn off hardware hash-chains on anything past 603, sadly enough.
> So all Macs, many embedded boards, ...

Actually, the 7450 (V'ger) from Mot supports software tablewalks. (This is 
what is in the > 800mhz dual mac G4's).

The issue then becomes supporting both hardware and software TLB walks on 
SMP systems, since the 7450 is the first SMP capable PPC that can do 
software tlbwalks.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
