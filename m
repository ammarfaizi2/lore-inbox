Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbUCZQgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 11:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbUCZQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 11:36:04 -0500
Received: from amalthea.dnx.de ([193.108.181.146]:24006 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S264075AbUCZQgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 11:36:00 -0500
Date: Fri, 26 Mar 2004 17:35:43 +0100
From: Robert Schwebel <robert@schwebel.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040326163543.GD16461@pengutronix.de>
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl> <20040326121928.GC16461@pengutronix.de> <4064530C.5030308@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4064530C.5030308@pacbell.net>
User-Agent: Mutt/1.4i
X-Scan-Signature: bdb6ba8b9184e0b6a72479d1f42a9fb8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 07:58:04AM -0800, David Brownell wrote:
> >>>-	.bDeviceClass =		DEV_CONFIG_CLASS,
> >>>+	.bDeviceClass =		0x02,
> >>
> >>Is this wise?
> >
> >
> >Until now DEV_CONFIG_CLASS was 0xFF, which results in Windows getting
> >hickup. If you directly set this to 0x02 (Network Device) Win is happy.
> 
> Actually I suspect setting it to USB_CLASS_COMM would be preferred, in
> RNDIS-specific config descriptors....

We have tried that, Windows does not like it. The only constellation
where it worked was setting the device descriptor's bConfigClass=0x02. 

RNDIS is a sensitive beast. Do one bit different results in that uggly
"Error 10" message on the Windows side. We saw it when we started with
the driver, we saw it when the driver was half way finished and we will
see it again if somebody tweaks the driver without exactly knowing what
the guys at Microsoft smoked when they designed that protocol :-) 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
