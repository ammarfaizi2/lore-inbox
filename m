Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTBLPia>; Wed, 12 Feb 2003 10:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTBLPiF>; Wed, 12 Feb 2003 10:38:05 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:29967 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267271AbTBLPgy>; Wed, 12 Feb 2003 10:36:54 -0500
Date: Wed, 12 Feb 2003 15:46:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (30/34) SCSI
Message-ID: <20030212154643.D10171@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp> <20030212141456.GE1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030212141456.GE1551@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Wed, Feb 12, 2003 at 11:14:56PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 11:14:56PM +0900, Osamu Tomita wrote:
> +ifneq ($(CONFIG_X86_PC9800),y)
> +scsi_mod-objs	+= scsicam.o
> +else
> +export-objs	+= wd33c93.o

export-objs is gone in 2.5.60.

> +scsi_mod-objs	+= scsicam98.o

umm, if you change stuff slightly cam isn't cam anymore..

> +/* For PC-9800 architecture support */
> +extern struct scsi_device *sd_find_params_by_bdev(struct block_device *, char **, sector_t *);
> +EXPORT_SYMBOL(sd_find_params_by_bdev);

this is never going to get in, sorry.

>  	
>  	/* override with calculated, extended default, or driver values */
> -	if (host->hostt->bios_param)
> +	if (!pc98 && host->hostt->bios_param)

please implement a proper pc98 ->bios_param method instead of messing
with the generic code.

