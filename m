Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUCZU6B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUCZU6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:58:01 -0500
Received: from amalthea.dnx.de ([193.108.181.146]:34256 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S261221AbUCZU56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:57:58 -0500
Date: Fri, 26 Mar 2004 21:57:44 +0100
From: Robert Schwebel <robert@schwebel.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040326205744.GH16461@pengutronix.de>
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de> <4064530C.5030308@pacbell.net> <20040326163543.GD16461@pengutronix.de> <40646C2B.6020306@pacbell.net> <20040326184142.GF16461@pengutronix.de> <40648876.9050902@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40648876.9050902@pacbell.net>
User-Agent: Mutt/1.4i
X-Scan-Signature: 5003f175ed075e86e191ee2bc398b282
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 11:45:58AM -0800, David Brownell wrote:
> Well, what I merge is necessarily going to work on more hardware than
> just PXA ... it'll work over net2280 (at high speed), goku, and surely
> other hardware.  In most cases that'll just require sanity testing.
> Maybe I can get Julian to test on SH3, and it sounds like Andrew is
> getting close on the MediaQ.

A broader variety of controllers would indeed be helpful. When you have
the stuff integrated the way you think it's right, just tell me and I'll
test if it still works on our testbed. 

> Once I can see it work, then it'll be ready for that more widespread
> testing. (Do penguins actually cry?)

Only if they have to read Microsoft specifications :-) 

> It's not as if the protocol actually _needs_ an interrupt endpoint,
> though the MSFT spec says it does. It's actually simpler for the host
> to poll for completion on the control endpoint; none of the requests
> should take very long to finish anyway. An RNDIS host might not even
> notice those "toggle broken" issues.

You probably underestimate the mental sensibility of Windows machines.
We have seen cases where the Windows host just floods you with
interrupts when it is not happy with things like these... 

> Did you have any evidence that the MSFT host was actually using that
> interrupt endpoint? Like CATC snooping showing it never tried to
> collect responses until the interrupt packet arrived?

We have seen the packets with the protocol analyzer. I think we agree
that using an interrupt endpoint just to announce that the gadget has a
message for the host available, but that's how M$ designed it... 

> Also, which versions of MS-Windows did you test against? Some of the
> MSFT docs suggest version-specific protocol quirks.

Win 98, XP, 2000. Auerswald currently tests all available other
variants, and the tests they invented are _really_ crazy ;)

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
