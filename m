Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSHTU7u>; Tue, 20 Aug 2002 16:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSHTU7u>; Tue, 20 Aug 2002 16:59:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55301
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317326AbSHTU7t>; Tue, 20 Aug 2002 16:59:49 -0400
Date: Tue, 20 Aug 2002 14:03:27 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: jools <j1@gramstad.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: hpt374 / BUG();
In-Reply-To: <IOELJIHGBNLBJNBMHABBIEPOCCAA.j1@gramstad.org>
Message-ID: <Pine.LNX.4.10.10208201354260.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have a system where it actually have the PLL already set and in
66-clock base?  You are the first person to ever hit this BUG().
I will need to work with HighPoint to finish the timing table.

If you would have several device of various max transfer rate limits you
could attach without the driver being built it, it would give me a few
data point to verify if the table I have started is even close.

Cheers,

On Tue, 20 Aug 2002, jools wrote:

> Hi
> 
> I'm using a RocketRAID 404 (hpt374) and a Asus A7v266.
> When trying to boot from a 'htp374-enabled' kernel like 2.4.19-ac4 or
> 2.4.20-pre2-ac4, i keep getting kernel panic at hpt366.c:1393.
> Does anyone know why this happens, or what I might do to correct this
> problem? I have tried every patch I can find for the 2.4 kernel.
> 
> hpt366.c line 1392:
> 
> if (hpt_minimum_revision(dev,8))
>         BUG();
> else if (hpt_minimum_revision(dev,5))
>         dev->driver_data = (void *) fifty_base_hpt372;
> else if (hpt_minimum_revision(dev,4))
>         dev->driver_data = (void *) fifty_base_hpt370a;
> else
>         dev->driver_data = (void *) fifty_base_hpt370a;
> printk("HPT37X: using 50MHz internal PLL\n");
> goto init_hpt37X_done;
> 
> 
> Jools
> j1@gramstad.org
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

