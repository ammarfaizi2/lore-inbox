Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315796AbSEEAsW>; Sat, 4 May 2002 20:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315797AbSEEAsW>; Sat, 4 May 2002 20:48:22 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6410 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315796AbSEEAsV>; Sat, 4 May 2002 20:48:21 -0400
Date: Sat, 4 May 2002 17:47:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Neil Conway <nconway_kernel@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH, IDE corruption, 2.4.18
In-Reply-To: <20020505002212.GA2392@matchmail.com>
Message-ID: <Pine.LNX.4.10.10205041746290.19145-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is not a problem in 2.5, you have a worse one.

NO DMA TIMEOUT RECOVERY -- woohoo ...........

On Sat, 4 May 2002, Mike Fedyk wrote:

> On Sat, May 04, 2002 at 01:15:20PM +0100, Neil Conway wrote:
> > -	byte stat;
> > +	byte stat,unit;
> 
> [snip]
> 
> >  #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
> > -	byte unit = (drive->select.b.unit & 0x01);
> > +	unit = (drive->select.b.unit & 0x01);
> 
> Why are you moving the init of "unit" out of that ifdef?
> 
> Can you see if this problem is still in 2.5 also?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

