Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263899AbTI2R3R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTI2R2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:28:45 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:8913 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263899AbTI2R1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:27:02 -0400
Date: Mon, 29 Sep 2003 18:26:42 +0100
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ULL fixes for qlogicfc
Message-ID: <20030929172642.GR5507@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1A41Rq-0000NJ-00@hardwired> <20030929172329.GD6526@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929172329.GD6526@gtf.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 01:23:29PM -0400, Jeff Garzik wrote:
 > On Mon, Sep 29, 2003 at 06:04:34PM +0100, davej@redhat.com wrote:
 > > diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/scsi/qlogicfc.c linux-2.5/drivers/scsi/qlogicfc.c
 > > --- bk-linus/drivers/scsi/qlogicfc.c	2003-09-08 00:47:00.000000000 +0100
 > > +++ linux-2.5/drivers/scsi/qlogicfc.c	2003-09-08 01:30:56.000000000 +0100
 > > @@ -718,8 +718,8 @@ int isp2x00_detect(Scsi_Host_Template * 
 > >  				continue;
 > >  
 > >  			/* Try to configure DMA attributes. */
 > > -			if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff) &&
 > > -			    pci_set_dma_mask(pdev, (u64) 0xffffffff))
 > > +			if (pci_set_dma_mask(pdev, 0xffffffffffffffffULL) &&
 > > +			    pci_set_dma_mask(pdev, 0xffffffffULL))
 > >  					continue;
 > 
 > Looks great.
 > 
 > I wonder if you are motivated to create similar pci_set_dma_mask()
 > cleanups for other drivers?  ;-)

Yeah, I'm on it.  I have some patches already, will do another
bombing run later tonight.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
