Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130376AbRAJX5r>; Wed, 10 Jan 2001 18:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129969AbRAJX5a>; Wed, 10 Jan 2001 18:57:30 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:28397 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S131579AbRAJX5P>; Wed, 10 Jan 2001 18:57:15 -0500
Date: Thu, 11 Jan 2001 00:56:57 +0100
From: David Weinehall <tao@acc.umu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Arcangeli <andrea@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Zlatko Calusic <zlatko@iskon.hr>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010111005657.B2243@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E14GR38-0000nM-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 10, 2001 at 07:36:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 07:36:43PM +0000, Alan Cox wrote:
> > I looked at it a year or two ago myself, and came to the conclusion that I
> > don't want to blow up our page table size by a factor of three or more, so
> > I'm not personally interested any more. Maybe somebody else comes up with
> > a better way to do it, or with a really compelling reason to.
> 
> There is only one reason I know for reverse page tables. That is ARM2/ARM3 
> support - which is still not fully merged because of this issue
> 
> The MMU on these systems is a CAM, and the mmu table is thus backwards to
> convention. (It also means you can notionally map two physical addresses to
> one virtual but thats undefined in the implementation ;))

Are there any other (not yet supported) platforms with similar (or other
unrelated, but hard to support because of the current architecture of
the kernel) problems?

(No, I have no secret trumps up my sleeve, I'm just curious.)


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
