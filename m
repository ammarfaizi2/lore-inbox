Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264993AbRFZPeh>; Tue, 26 Jun 2001 11:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264994AbRFZPe2>; Tue, 26 Jun 2001 11:34:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51463 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264993AbRFZPeW>; Tue, 26 Jun 2001 11:34:22 -0400
Subject: Re: AMD thunderbird oops
To: adeucher@UU.NET (Alex Deucher)
Date: Tue, 26 Jun 2001 16:33:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), joeja@mindspring.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3B38A988.A576028B@uu.net> from "Alex Deucher" at Jun 26, 2001 11:26:00 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Euql-0003hh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's weird though is that it is rock solid as long as I don't use
> athlon optimizations.  I'm not sure how much of a speed improvement they

That fits the pattern beautifully. 

> provide, but everything's fine with i686, so I can't complain, besides I
> doubt I can return the board at this point anyway.  BTW, which would be
> better with an athlon, k6 or i686 optimization?  I've heard i686 is
> faster, but I've never really looked into it too much myself.

The optimisations are worth several %age points on some benchmarks - the
prefetching memory copier it uses basically hits the full bus bandwidth on
memory copies which rep movs will not do.

My current speculation is that the sdram setup on some of these boards can't
actually take the full CPU spec caused by these hand tuned routines. There is
some evidence to support that as several other boards only work with Athlon
optimisation if you set the BIOS options to 'conservative' not 'optimised'

Equally we don't see the problem on AMD chipset boards and we don't know if
that indicates a bug in the kernel not tripped on such boards or a chipset
problem (even BIOS setuo maybe) on the VIA.

Alan

