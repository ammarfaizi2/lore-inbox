Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270585AbRHSQPm>; Sun, 19 Aug 2001 12:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270582AbRHSQPc>; Sun, 19 Aug 2001 12:15:32 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:29864 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S270300AbRHSQP3>; Sun, 19 Aug 2001 12:15:29 -0400
Date: Sun, 19 Aug 2001 18:15:41 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, gars@lanm-pc.com
Subject: Re: Swap size for a machine with 2GB of memory
Message-ID: <20010819181541.L9870@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010819024233.A26916@thyrsus.com> <Pine.LNX.4.33.0108190526090.4118-100000@terbidium.openservices.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0108190526090.4118-100000@terbidium.openservices.net>; from ignacio@openservices.net on Sun, Aug 19, 2001 at 05:46:32AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 05:46:32AM -0400, Ignacio Vazquez-Abrams wrote:
> At the other extreme, I've heard of machines that are running heavy scientific
> applications. They have 4 GB of RAM and run with 10+ GB of swap.
> 
> A machine with 2 GB of RAM can easily live with no swap, unless you want to
> run web, proxy, or database servers in very large configurations, or if you
> compile software several times the size of XFree86 with any regularity. By
> "very large configurations" I mean something you would have to deliberately
> set, probably requiring a change to defined constants in the software.

One word here: tmpfs.

I use several amounts of RAM as tmpfs. And with that you can
certainly reach the point of swapping sth. out.

But my machine has only 1GB of RAM and I set up only 2GB of swap.

I compile and test many things there directly from the CVS, run
things like the fcgp to produce nearly a GB of PostScript files
and many more fun things.

So if you plan to use tmpfs, better have enough swap available.
Files in tmpfs can also not be removed by the OOM killer. So you
should define your tmpfs limits properly.

Regards

Ingo Oeser
-- 
Isn't vi that text editor with two modes... one that beeps and one
that corrupts your file? --- Dan Jacobson in comp.os.linux.advocacy
