Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315546AbSEWBaS>; Wed, 22 May 2002 21:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315580AbSEWBaR>; Wed, 22 May 2002 21:30:17 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:43722 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315546AbSEWBaQ>;
	Wed, 22 May 2002 21:30:16 -0400
Date: Thu, 23 May 2002 11:25:17 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Orinoco Wireless driver bugs in 2.5.17
Message-ID: <20020523012517.GM1001@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020522103834.B10921@bougret.hpl.hp.com> <E17Aams-0002Ue-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 07:24:37PM +0100, Alan Cox wrote:
> > 	Alan,
> > 	Could you be more precise and point out which kernel start
> > failing ?
> 
> Certainly in 2.4.18 (and I've seen a pile of other similar reports).

Ah, bugger.

> > 	If I remember properly my debug session with Alan (that was a
> > long while ago), the COR reset was screwing up the firmware (well, how
> > many time did I told you to not make it mandatory ?).
> 
> Long time ago -its been behaving well until fairly recently
> 
> > 	Alan has an old Compaq card (the Intersil PrismII variety, not
> > the new Lucent one) and his firmware is probably not very fresh.
> 
> Oldish firmware definitely. The newer driver finds the card registers
> it but fails on all tx/rx and reports no signal and noise of
> 130/150 or so (as opposed to db). Flipping back to the older kernel it
> works happily. 

The signal/noise bit is probably a red herring.  We have problems with
the reporting of this, but it's mostly cosmetic.  I seem to have
confusing and contradictory information about how to interpret the
values the firmware reports.

> Any specific info/debug/traces that would help ?

Specific error messages on Tx/Rx and also the firmware version as
reported on module load would be very helpful.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
