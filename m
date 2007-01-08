Return-Path: <linux-kernel-owner+w=401wt.eu-S1751469AbXAHH1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbXAHH1P (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 02:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbXAHH1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 02:27:15 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:60529 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbXAHH1P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 02:27:15 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting cleanups
Date: Mon, 8 Jan 2007 15:28:20 +0800
Message-ID: <989B956029373F45A0B8AF029708189008656E@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070108042657.GA18610@Ahmed>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting cleanups
Thread-Index: Accy3VGgL1eazBpSRF6pc79PmGoK3wAF4eDg
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ahmed S. Darwish [mailto:darwish.07@gmail.com]
> Sent: Monday, January 08, 2007 12:27 PM
> To: Li Yang-r58472
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org
> Subject: Re: [PATCH 2.6.20-rc3] UCC Ether driver: kmalloc casting
cleanups
> 
> On Mon, Jan 08, 2007 at 11:12:28AM +0800, Li Yang-r58472 wrote:
> > > From: Ahmed S. Darwish [mailto:darwish.07@gmail.com]
> > >
> > > Hi,
> > > A kmalloc casting cleanup patch.
> > > Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> 
> [..]
> 
> > > -				(u32) (kmalloc((u32) (length + align),
> > > -				GFP_KERNEL));
> > > +				kmalloc((u32) (length + align),
GFP_KERNEL);
> > > +
> > >  			if (ugeth->tx_bd_ring_offset[j] != 0)
> > >  				ugeth->p_tx_bd_ring[j] =
> 
> [..]
> 
> > > -			    (u32) (kmalloc((u32) (length + align),
GFP_KERNEL));
> > > +				kmalloc((u32) (length + align),
GFP_KERNEL);
> >
> > NACK about the 2 clean-ups above.  Cast from pointer to integer is
> > required here.
> 
> Are the casts from pointer to integer just needed to suppress gcc
> warnings or there's something technically important about them ?

It is to suppress the warnings.  IMHO, most type casts are not
technically important but for sanity check.

- Leo
