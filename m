Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbRGFPFe>; Fri, 6 Jul 2001 11:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266714AbRGFPFO>; Fri, 6 Jul 2001 11:05:14 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:56069 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S266713AbRGFPFM>;
	Fri, 6 Jul 2001 11:05:12 -0400
Date: Fri, 6 Jul 2001 17:04:54 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Juergen Wolf <JuWo@N-Club.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: Problem with SMC Etherpower II + kernel newer 2.4.2
Message-ID: <20010706170454.A22419@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com> <3B42DEC2.AAB1E65B@N-Club.de> <20010704145752.A29311@se1.cogenit.fr> <3B456D45.FBF10C1A@N-Club.de> <20010706134421.B20614@se1.cogenit.fr> <3B45AEBD.8D0599E3@N-Club.de> <3B45B61F.BA6AA1BF@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B45B61F.BA6AA1BF@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jul 06, 2001 at 08:59:12AM -0400
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> ecrit :
[...]
> --- /spare/tmp/linux-2.4.7-pre3/drivers/net/epic100.c	Mon Jul  2 21:03:04 2001
> +++ linux/drivers/net/epic100.c	Fri Jul  6 12:56:40 2001
[...]
>  /* The user-configurable values.
> @@ -448,7 +451,7 @@
>  	outl(0x0008, ioaddr + TEST1);
>  
>  	/* Turn on the MII transceiver. */
> -	outl(dev->if_port == 1 ? 0x13 : 0x12, ioaddr + MIICfg);
> +	outl(0x12, ioaddr + MIICfg);
>  	if (chip_idx == 1)
>  		outl((inl(ioaddr + NVCTL) & ~0x003C) | 0x4800, ioaddr + NVCTL);
>  	outl(0x0200, ioaddr + GENCTL);

The link that Juergen sent does that in epic_init_one but it removes it 
from epic_open (the patch I forwarded). 

Btw it plays rude games with udelay() (consequence of posted writes + optimized 
loops ?).

-- 
Ueimor
