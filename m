Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129766AbRCCVsY>; Sat, 3 Mar 2001 16:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129768AbRCCVsO>; Sat, 3 Mar 2001 16:48:14 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:34834 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S129766AbRCCVsH>;
	Sat, 3 Mar 2001 16:48:07 -0500
Date: Sat, 3 Mar 2001 14:48:56 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Message-ID: <20010303144856.A18389@ftsoj.fsmlabs.com>
In-Reply-To: <19350126005232.15154@mailhost.mipsys.com> <Pine.LNX.4.10.10103030954060.17574-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10103030954060.17574-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 03, 2001 at 10:00:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} > I don't have a simple way on PPC to cause the interrupt to happen again,
} > as you can imagine this is rather controller-specific. However, looking
} > at the code closely, I couldn't figure out a case where having
} > IRQ_PENDING in enable_irq() makes sense.
} 
} It only makes sense for broken irq controllers. And most aren't. You can
} likely ignore it - and note how even on an x86, most of the irq controller
} code _does_ ignore it. 

We do have broken interrupt controllers in this respect.  We already have a
way of handling it.  Ben, take a look at set_lost().
