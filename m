Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263187AbREaTiU>; Thu, 31 May 2001 15:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263188AbREaTiA>; Thu, 31 May 2001 15:38:00 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S263187AbREaThx>;
	Thu, 31 May 2001 15:37:53 -0400
Message-ID: <20010531002437.A21681@bug.ucw.cz>
Date: Thu, 31 May 2001 00:24:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Philip.Blundell@pobox.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #6
In-Reply-To: <200105300044.CAA04542@green.mif.pg.gda.pl> <E1550vA-0005Xe-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E1550vA-0005Xe-00@the-village.bc.nu>; from Alan Cox on Wed, May 30, 2001 at 09:01:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> They are neccessary
> 
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

Maybe macro "spin_lock_irqsave_on_smp()" would be good idea? These
ifdefs look ugly. Maybe local to driver, maybe even global.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
