Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130623AbRCEGGk>; Mon, 5 Mar 2001 01:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130626AbRCEGGa>; Mon, 5 Mar 2001 01:06:30 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:34060 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S130623AbRCEGGT>;
	Mon, 5 Mar 2001 01:06:19 -0500
Date: Sun, 4 Mar 2001 23:07:07 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Message-ID: <20010304230707.L2565@ftsoj.fsmlabs.com>
In-Reply-To: <20010303144856.A18389@ftsoj.fsmlabs.com> <19350127143809.22288@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <19350127143809.22288@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sun, Mar 04, 2001 at 10:06:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} Also, we currently don't use the same mecanism as i386, and since Linus
} expressed his desire to have irq.c become generic, I'm trying to make sure
} I fully understand it before merging in PPC the bits that I didn't merge
} them yet.

More generic in terms of using irq_desc[] and some similar structures I can
see.  Making do_IRQ() and enable/disable use the same names and structures
as x86 isn't sensible.  They're different ports, with different design
philosophies.

I don't believe that the plan is a common irq.c - lets stay away from that.
