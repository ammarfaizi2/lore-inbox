Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbQLLW3g>; Tue, 12 Dec 2000 17:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQLLW30>; Tue, 12 Dec 2000 17:29:26 -0500
Received: from pnendick.cpe.dsl.enteract.com ([216.80.39.125]:3845 "EHLO
	thefunk.org") by vger.kernel.org with ESMTP id <S129784AbQLLW3R>;
	Tue, 12 Dec 2000 17:29:17 -0500
Date: Mon, 11 Dec 2000 15:58:23 -0600
From: " Paul C. Nendick " <pnendick@highku.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Cavan <johncavan@home.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.16 SMP: mtrr errors
Message-ID: <20001211155822.A1901@thefunk.org>
In-Reply-To: <3A3693A8.E0BA83B7@home.com> <E145wtZ-0001pn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E145wtZ-0001pn-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 12, 2000 at 09:23:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shall I submit this to Matrox as a bug then?

/paul

Alan Cox (alan@lxorguk.ukuu.org.uk) said:

> > Petr, the Matrox card splits the memory between the two video screens
> > when running in a multi-head configuration and "pretends" that it is two
> > distinct cards. Thus, a 32 mb card will register an mtrr for 24mb and
> > for 8mb seperately when in this mode.
> 
> That is a driver bug. The intel processors only support MTRR's on certain
> power boundaries/sizes. The fall through is intended. 
> 
> > to fall through, but is this correct? I've inserted a break at the end
> > of the Intel switch before and have not had problems, but I left it out
> 
> Lucky
> 
> > in the latest couple of kernels because of all the mtrr work being done,
> > waiting to see if there was resolution.
> 
> The Matrox driver needs to register a single 32Mb MTRR
> 

-- 
Paul C. Nendick
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
