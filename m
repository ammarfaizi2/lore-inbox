Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWEAUeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWEAUeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWEAUeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:34:07 -0400
Received: from mail.shorthander.org ([85.10.227.118]:29403 "EHLO
	herakles.nuerscht.net") by vger.kernel.org with ESMTP
	id S932231AbWEAUeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:34:06 -0400
Date: Mon, 1 May 2006 22:34:01 +0200
From: Tobias Klauser <tklauser@nuerscht.ch>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: + drivers-scsi-use-array_size-macro.patch added to -mm tree
Message-ID: <20060501203401.GA3557@neon.tklauser.home>
References: <200605011717.k41HHagU001787@shell0.pdx.osdl.net> <1146505519.20760.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146505519.20760.60.camel@laptopd505.fenrus.org>
X-GPG-Key: 0x3A445520
X-OS: GNU/Linux
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-05-01 at 19:45:19 +0200, Arjan van de Ven <arjan@infradead.org> wrote:
> On Mon, 2006-05-01 at 10:15 -0700, akpm@osdl.org wrote:
> > diff -puN drivers/scsi/53c700.c~drivers-scsi-use-array_size-macro drivers/scsi/53c700.c
> > --- devel/drivers/scsi/53c700.c~drivers-scsi-use-array_size-macro	2006-05-01 10:15:39.000000000 -0700
> > +++ devel-akpm/drivers/scsi/53c700.c	2006-05-01 10:15:39.000000000 -0700
> > @@ -316,7 +316,7 @@ NCR_700_detect(struct scsi_host_template
> >  	BUG_ON(!dma_is_consistent(pScript) && L1_CACHE_BYTES < dma_get_cache_alignment());
> >  	hostdata->slots = (struct NCR_700_command_slot *)(memory + SLOTS_OFFSET);
> >  	hostdata->dev = dev;
> > -		
> > +
> >  	pSlots = pScript + SLOTS_OFFSET;
> >  
> >  	/* Fill in the missing routines from the host template */
> 
> noise?

I usually remove trailing whitespaces which are around the section I'm
patching (I highlight them in my vim). Is that a problem?

> > @@ -332,19 +332,18 @@ NCR_700_detect(struct scsi_host_template
> >  	tpnt->slave_destroy = NCR_700_slave_destroy;
> >  	tpnt->change_queue_depth = NCR_700_change_queue_depth;
> >  	tpnt->change_queue_type = NCR_700_change_queue_type;
> > -	
> > +
> 
> more noise?

Same here

> > @@ -385,17 +382,17 @@ NCR_700_detect(struct scsi_host_template
> >  	host->hostdata[0] = (unsigned long)hostdata;
> >  	/* kick the chip */
> >  	NCR_700_writeb(0xff, host, CTEST9_REG);
> > -	if(hostdata->chip710) 
> > +	if (hostdata->chip710)
> 
> while a nice cleanup.. does it fit in this patch?
> 
> 
> (many more such things snipped)

I probably should have mentioned the whitespace/coding style cleanups in
the description of the patch. Or should I just leave out these kind of
cleanups?
