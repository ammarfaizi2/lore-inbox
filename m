Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262700AbRE3KGA>; Wed, 30 May 2001 06:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262695AbRE3KFu>; Wed, 30 May 2001 06:05:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15633 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262694AbRE3KFm>; Wed, 30 May 2001 06:05:42 -0400
Subject: Re: [PATCH] net #6
To: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz)
Date: Wed, 30 May 2001 09:01:36 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), Philip.Blundell@pobox.com,
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200105300044.CAA04542@green.mif.pg.gda.pl> from "Andrzej Krzysztofowicz" at May 30, 2001 02:44:03 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1550vA-0005Xe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch removes unnecessary #ifdefs from eexpress.c

They are neccessary

> @@ -643,9 +631,7 @@
>  	        eexp_hw_tx_pio(dev,data,length);
>  	}
>  	dev_kfree_skb(buf);
> -#ifdef CONFIG_SMP
>  	spin_unlock_irqrestore(&lp->lock, flags);
> -#endif
>  	enable_irq(dev->irq);
>  	return 0;

They are done this way to get good non SMP performance. Your changes would
ruin that.

