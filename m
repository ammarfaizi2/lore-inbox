Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315566AbSEWBaR>; Wed, 22 May 2002 21:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315580AbSEWBaQ>; Wed, 22 May 2002 21:30:16 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:45258 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315566AbSEWBaP>;
	Wed, 22 May 2002 21:30:15 -0400
Date: Thu, 23 May 2002 11:27:40 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: jt@hpl.hp.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
Message-ID: <20020523012740.GN1001@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	jt@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020522103834.B10921@bougret.hpl.hp.com> <E17Aams-0002Ue-00@the-village.bc.nu> <20020522111751.A10992@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 11:17:51AM -0700, Jean Tourrilhes wrote:
> On Wed, May 22, 2002 at 07:24:37PM +0100, Alan Cox wrote:
> > > 	Alan,
> > > 	Could you be more precise and point out which kernel start
> > > failing ?
> > 
> > Certainly in 2.4.18 (and I've seen a pile of other similar reports).
> 
> 	2.4.18 did upgrade the driver from 0.06f to 0.09b. The bug
> with 0.09b is a race condition in Tx code. This was fixed in version
> 0.11.

Yes.  Unfortunately a bunch of the bug fixes we made between 0.06f and
0.09b uncovered other, even worse, bugs - at least on some
hardware/firmware.

It also would have helped if I'd been pushing to the kernel more
frequently, but I got slack.

> 	Have you tried 2.4.19-pre8-acX (well, I mean the Orinoco
> driver in 2.4.19-pre8 ;-). It contains the new version of the driver
> (v11) that fixes the race condition (but introduce the potential COR
> problem).
> 	If 2.4.19-pre8-acX fails, that would be for an entirely
> different reason (even if the failure might look similar).

Yes checking 0.11b, which is in Marcelo's latest -pres (and in
2.5.17), would be very helpful

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
