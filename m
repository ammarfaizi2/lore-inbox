Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143734AbRAHOLw>; Mon, 8 Jan 2001 09:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143871AbRAHOLc>; Mon, 8 Jan 2001 09:11:32 -0500
Received: from mail.zmailer.org ([194.252.70.162]:2832 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S143734AbRAHOL2>;
	Mon, 8 Jan 2001 09:11:28 -0500
Date: Mon, 8 Jan 2001 16:11:19 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: p2@mind.be, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tulip
Message-ID: <20010108161119.F25659@mea-ext.zmailer.org>
In-Reply-To: <20010108150108.F1831@mind.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010108150108.F1831@mind.be>; from p2@mind.be on Mon, Jan 08, 2001 at 03:01:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 03:01:08PM +0100, Peter De Schrijver wrote:
> Hi,
> 
> The following patch tries to improve the media autosensing capabilities of the 
> 2.4 tulip driver. Iused Doanld Becker's tulip driver as a basis. I only tested 
> it on a Digital PWS500a with onboard 21143 chip with MII transceiver. 
> 
> Peter.

   A UNI-DIFF (-u option)  would be nice, easier to read what has
   changed when (often) old and new text are next to each other.

   Linus likes them, I like them, ...  (if that is any merit)

/Matti Aarnio

> diff -rc linux.orig/drivers/net/tulip/21142.c linux/drivers/net/tulip/21142.c
> *** linux.orig/drivers/net/tulip/21142.c	Tue Nov  7 20:08:09 2000
> --- linux/drivers/net/tulip/21142.c	Sun Jan  7 18:29:03 2001
> ***************
> *** 99,106 ****
>   {
>   	struct tulip_private *tp = (struct tulip_private *)dev->priv;
>   	long ioaddr = dev->base_addr;
> ! 	int csr14 = ((tp->to_advertise & 0x0780) << 9)  |
> ! 		((tp->to_advertise&0x0020)<<1) | 0xffbf;
>   
>   	DPRINTK("ENTER\n");
>   
> --- 99,106 ----
>   {
>   	struct tulip_private *tp = (struct tulip_private *)dev->priv;
>   	long ioaddr = dev->base_addr;
> ! 	int csr14 = ((tp->sym_advertise & 0x0780) << 9)  |
> ! 		((tp->sym_advertise&0x0020)<<1) | 0xffbf;
>   
>   	DPRINTK("ENTER\n");
>   
....
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
