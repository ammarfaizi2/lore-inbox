Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAIRmp>; Tue, 9 Jan 2001 12:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAIRmf>; Tue, 9 Jan 2001 12:42:35 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:29154 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S131308AbRAIRmU>;
	Tue, 9 Jan 2001 12:42:20 -0500
Date: Tue, 9 Jan 2001 09:42:17 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, John Ruttenberg <rutt@chezrutt.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: wavelan has fatal error with 2.4.0 (but worked in 2.4.0-test12)
Message-ID: <20010109094217.A30225@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20010109090427.A30175@bougret.hpl.hp.com> <E14G2LB-0006zy-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14G2LB-0006zy-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 09, 2001 at 05:13:42PM +0000
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 05:13:42PM +0000, Alan Cox wrote:
> > 	This is a bug with the definition of udelay(). Somebody tried
> > to be too clever with udelay(), and the end result is that it breaks
> > perfectly good and valid code.
> > 	Therefore, it should be reported as such on LKML, a bug in udelay().
> 
> It is a bug in the driver.

	Please check again the code and point me the invalid
udelay(). You will realise that there is no delay in the driver that
is longer than 100ms.
	The bug is that udelay() can't be passed a variable but only a
constant. Therefore bug in udelay().

> > there. For my part, I insist that the code is correct, that replacing
> > an inline function by a #define is going backwards and that udelay()
> > should be fixed one way or another (easy, just define __bad_udelay()
> > as returning a compilation warning or an error message).
> 
> You can't #define a function to a #warning or #error in C. Language limitation

	Yes. Tough.

	Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
