Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277082AbRJ3SFq>; Tue, 30 Oct 2001 13:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277047AbRJ3SFg>; Tue, 30 Oct 2001 13:05:36 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:7428 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S277082AbRJ3SF0>;
	Tue, 30 Oct 2001 13:05:26 -0500
Date: Tue, 30 Oct 2001 11:01:31 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Victor Yodaiken <yodaiken@fsmlabs.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030110131.A11419@ftsoj.fsmlabs.com>
In-Reply-To: <20011030095757.A9956@hq2> <Pine.LNX.4.33.0110300903320.8603-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110300903320.8603-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 09:17:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, they swung the pendelum the other way for the 64-bit chips.  The
VSID's (MM contexts) are indirectly accessed via a hash-table (with an on
chip TLB-style cache called a SLB).

The speedup from using the software table-walk actually came from emulating
x86 instead of using the native hash tables.  Pretty slick that emulating a
30-year old MMU and improves performance on the PowerPC, eh?

There was an April Fools Microprocessor reports describing a processor that
had gone 64-bit and had a "twisted gothic nightmare of twisted logic" based
MMU that involved XOR-ing addresses with random numbers.  They were
unwittingly predicting the future of the PPC MMU.

The nightmares and shakes have never ended for me, either.  Sorry about
that, man.

} Gods, I hope they have reconsidered that in their 64-bit chips. The 32-bit
} hash chains may be ugly, but the architected 32/64-bit MMU stuff is just
} so incredibly baroque that it makes any other MMU look positively
} beautiful ("Segments? Segments shmegments. Big deal").
} 
} I still have the occasional nightmares about the IBM block diagrams
} "explaining" the PowerPC MMU in their technical documentation.
} 
} There's probably a perfectly valid explanation for them, though (*).
} 
} 		Linus
} 
} (*) Probably along the lines of the designers being so high on LSD that
} they thought it was a really cool idea. That would certainly explain it in
} a very logical fashion.
} 
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
