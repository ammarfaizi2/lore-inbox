Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWIVW5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWIVW5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWIVW5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:57:17 -0400
Received: from xyzzy.farnsworth.org ([65.39.95.219]:26638 "HELO farnsworth.org")
	by vger.kernel.org with SMTP id S965144AbWIVW5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:57:16 -0400
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 22 Sep 2006 15:57:23 -0700
To: Jeff Garzik <jeff@garzik.org>
Cc: Judith Lebzelter <judith@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dale@farnsworth.org
Subject: Re: Arrr! Linux 2.6.18
Message-ID: <20060922225722.GA13787@xyzzy.farnsworth.org>
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org> <20060922215120.GD23169@shell0.pdx.osdl.net> <45145ED9.1080801@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45145ED9.1080801@garzik.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 06:08:25PM -0400, Jeff Garzik wrote:
> Judith Lebzelter wrote:
> >>Dale Farnsworth:
> >>      mv643xx_eth: Unmap DMA buffers in receive path
> >
> >In OSDL's automated cross-compile for powerpc64, kernel 2.6.18 had this 
> >unexpected error:
> >
> >drivers/net/mv643xx_eth.c: In function 'mv643xx_eth_receive_queue':
> >drivers/net/mv643xx_eth.c:388: error: 'RX_SKB_SIZE' undeclared (first use 
> >in this function)
> >
> >Here is a patch that stops the error.
> >
> >Judith Lebzelter
> >OSDL
> >
> >--- drivers/net/mv643xx_eth.c.old	2006-09-22 11:22:47.951049416 -0700
> >+++ drivers/net/mv643xx_eth.c	2006-09-22 11:23:17.787625304 -0700
> >@@ -385,7 +385,7 @@
> > 	struct pkt_info pkt_info;
> > 
> > 	while (budget-- > 0 && eth_port_receive(mp, &pkt_info) == ETH_OK) {
> >-		dma_unmap_single(NULL, pkt_info.buf_ptr, RX_SKB_SIZE,
> >+		dma_unmap_single(NULL, pkt_info.buf_ptr, ETH_RX_SKB_SIZE,
> > 							DMA_FROM_DEVICE);
> 
> Man, talk about timing.  I just sent this to Andrew & Linus just a few 
> seconds ago :)
> 
> 	Jeff

And I sent the same patch to you and netdev 2 days ago.  :)

Did you get the accompanying patch that removes this driver
from the powerpc64 build?  Or shall I resend it?

-Dale
