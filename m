Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbUCZMTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUCZMTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:19:50 -0500
Received: from amalthea.dnx.de ([193.108.181.146]:55995 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S264030AbUCZMTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:19:46 -0500
Date: Fri, 26 Mar 2004 13:19:28 +0100
From: Robert Schwebel <robert@schwebel.de>
To: bert hubert <ahu@ds9a.nl>, David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
Message-ID: <20040326121928.GC16461@pengutronix.de>
References: <20040325221145.GJ10711@pengutronix.de> <20040326115947.GA22185@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040326115947.GA22185@outpost.ds9a.nl>
User-Agent: Mutt/1.4i
X-Scan-Signature: bdb6ba8b9184e0b6a72479d1f42a9fb8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 12:59:47PM +0100, bert hubert wrote:
> > Unfortunately, although it works with the original Microsoft driver, you
> > need an inf file on the windows side; you can download the template for
> > that directly from M$. 
> 
> I don't understand this comment, it would probably be very wise to add
> something to Documentation/ about this.

You need such an .inf file on the windows side; M$ has a template where
you simply need to insert your vendor/device ID and other stuff. I'm not
sure about the license for these files, so I don't know if it is allowed
to distribute them. 

> > -	.bDeviceClass =		DEV_CONFIG_CLASS,
> > +	.bDeviceClass =		0x02,
> 
> Is this wise?

Until now DEV_CONFIG_CLASS was 0xFF, which results in Windows getting
hickup. If you directly set this to 0x02 (Network Device) Win is happy.
Might be a good idea anyway. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
