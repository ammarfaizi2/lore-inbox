Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131048AbQLMLcF>; Wed, 13 Dec 2000 06:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131082AbQLMLb4>; Wed, 13 Dec 2000 06:31:56 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:18952 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S131048AbQLMLbh>; Wed, 13 Dec 2000 06:31:37 -0500
Date: Wed, 13 Dec 2000 11:55:06 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Cavan <johncavan@home.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        " Paul C. Nendick" <pauly@enteract.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.16 SMP: mtrr errors
Message-ID: <20001213115506.A3733@pcep-jamie.cern.ch>
In-Reply-To: <3A3693A8.E0BA83B7@home.com> <E145wtZ-0001pn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E145wtZ-0001pn-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 12, 2000 at 09:23:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Petr, the Matrox card splits the memory between the two video screens
> > when running in a multi-head configuration and "pretends" that it is two
> > distinct cards. Thus, a 32 mb card will register an mtrr for 24mb and
> > for 8mb seperately when in this mode.
> 
> That is a driver bug. The intel processors only support MTRR's on certain
> power boundaries/sizes. The fall through is intended. 

> > in the latest couple of kernels because of all the mtrr work being done,
> > waiting to see if there was resolution.
> 
> The Matrox driver needs to register a single 32Mb MTRR

The kernel VESA framebuffer has exactly the same problem.  Sometimes
VESA reports 2.5Mb video memory, and vesafb's attempt to register an
MTRR fails.

But should vesafb know about Intel-specific MTRR limitations, given that
those limitations may change?

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
