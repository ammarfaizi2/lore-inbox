Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262714AbRE3Kgq>; Wed, 30 May 2001 06:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbRE3Kg0>; Wed, 30 May 2001 06:36:26 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:36879 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262719AbRE3KgV>; Wed, 30 May 2001 06:36:21 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105301035.MAA06191@green.mif.pg.gda.pl>
Subject: Re: [PATCH] net #6
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 30 May 2001 12:35:17 +0200 (CEST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), Philip.Blundell@pobox.com,
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <E1550vA-0005Xe-00@the-village.bc.nu> from "Alan Cox" at May 30, 2001 09:01:36 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > The following patch removes unnecessary #ifdefs from eexpress.c
> 
> They are neccessary

Yes, you are right.
I was suggested by improper part of spinlock.h ...

Forget this patch.
 
> > @@ -643,9 +631,7 @@
> >  	        eexp_hw_tx_pio(dev,data,length);
> >  	}
> >  	dev_kfree_skb(buf);
> > -#ifdef CONFIG_SMP
> >  	spin_unlock_irqrestore(&lp->lock, flags);
> > -#endif
> >  	enable_irq(dev->irq);
> >  	return 0;
> 
> They are done this way to get good non SMP performance. Your changes would
> ruin that.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
