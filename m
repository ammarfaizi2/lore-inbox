Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbUKXUdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUKXUdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbUKXUdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:33:02 -0500
Received: from palrel11.hp.com ([156.153.255.246]:58050 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262840AbUKXUaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:30:00 -0500
Date: Wed, 24 Nov 2004 11:40:03 -0800
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How to perform a Wireless Scan?
Message-ID: <20041124194003.GA31262@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20041124185451.GA29598@bougret.hpl.hp.com> <41A4E091.50205@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A4E091.50205@tiscali.de>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 08:27:13PM +0100, Matthias-Christian Ott wrote:
> Jean Tourrilhes wrote:
> 
> >Matthias-Christian Ott wrote :
> > 
> >
> >>I'm currently developing the the wireless functions for the rtl8180
> >>chipset.
> >>There's only one problem:
> >>I don't know how to perform a wireless scan.
> >>How does it work?
> >>Is there an algorithm or a GPL based driver which does this well?
> >>   
> >>
> >
> >	Most modern wireless drivers support the scan function (airo,
> >hostap, orinoco v15, prism54, atmel_cs, wl3501, madwifi, ipw2x00,
> >acx100, poldhu, at76c503, adm8211... - check my Howto).
> >	Unfortunately, the implementation is highly dependant on the
> >hardware itself, and each hardware has it's own way. Chipset which are
> >"softer" require more work. A good example of harder MAC is
> >airo/orinoco, for softer MAC check madwifi.
> >	Good luck...
> >
> >	Jean
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> > 
> >
> Hi Jean!
> Let me understand scan algorithm:
> The card looks on different frequencies and channels for packages and 
> extracts the mac of the access point?
> Or am I wrong?

	Some card do the scan automatically in firmware. You just need
to say "perform the scan", and after a while it will return some
results. Other card don't have support for it, so you need to go on
each frequency, send a probe request and look at the beacons.
	A helpful hint : scanning is done for the initial association
of the card to the BSSID. If the card perform all the association by
itself (just give an ESSID), it usually has an interface to perform
scanning. If you have to write the code to perform all the association
in the driver, then you can reuse that code to implement scanning.

> Thanks
> Matthias-Christian Ott

	Good luck...

	Jean
