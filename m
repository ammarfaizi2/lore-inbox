Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318943AbSHQA3f>; Fri, 16 Aug 2002 20:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318946AbSHQA3f>; Fri, 16 Aug 2002 20:29:35 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:51615 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318943AbSHQA3e>;
	Fri, 16 Aug 2002 20:29:34 -0400
Date: Sat, 17 Aug 2002 02:33:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Larry McVoy <lm@work.bitmover.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020817003328.GA3587@win.tue.nl>
References: <200208170058.39227.m.c.p@wolk-project.de> <Pine.LNX.4.44.0208161622240.1674-100000@home.transmeta.com> <20020816163642.D31052@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020816163642.D31052@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 04:36:42PM -0700, Larry McVoy wrote:

> This may be politically incorrect, but could you (or anyone) provide a 
> history of the IDE maintainers to date and why they didn't work out 
> and what would need to change to make them work out?  I'm sticking my
> nose in where I know nothing but maybe one of them could rise up to
> the necessary level if it were spelled out what that level was.

Prehistory: Linus and others.

Since start of 1994: Mark Lord. Everybody was happy until mid 1998 (2.1.111),
when, after a discussion about problems a few people had with DMA
Linus patched linux/drivers/block/Config.in:

-        bool '     Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA
+       # Either the DMA code is buggy or the DMA hardware is unreliable. FIXME.
+        #bool '     Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA

and Mark wrote: "I will not be updating the IDE driver again until the
linux/drivers/block/Config.in file is restored to its pre-111 state."

Since Fall 1998 (2.1.122): Andre Hedrick.

Recent history is known.

(Lots of other people also did useful work on IDE. I will not try to list
names since I would forget some.)

Of course, "IDE maintainer" implies work on the interface with the hardware
and work on the interface with the block I/O subsystem of the kernel.
Some people know all about the hardware, others know much less about
hardware but have good ideas about the driver interface.
There is no reason to force the "IDE maintainer" to be a single person.

Andries


