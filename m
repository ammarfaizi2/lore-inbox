Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSE0JJF>; Mon, 27 May 2002 05:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSE0JJE>; Mon, 27 May 2002 05:09:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:45050 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314690AbSE0JJD>; Mon, 27 May 2002 05:09:03 -0400
Subject: Re: [PATCH] 2.5.18 : drivers/pci/pool.c minor printk fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.33.0205262058570.18267-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 11:11:23 +0100
Message-Id: <1022494283.11859.202.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 02:06, Frank Davis wrote:
> Hello,
>   The following patch addresses a compile warning. printk saw the "," as 
> an argument, which it shouldn't.

So fix printk or whatever actually got confused not the symptom


>  	if (page->bitmap [map] & (1UL << block)) {
> -		printk (KERN_ERR "pci_pool_free %s/%s, dma %x already free\n",
> +		printk (KERN_ERR "pci_pool_free %s/%s dma %x already free\n",
>  			pool->dev ? pool->dev->slot_name : NULL,

