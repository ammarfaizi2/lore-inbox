Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLSJlk>; Tue, 19 Dec 2000 04:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLSJla>; Tue, 19 Dec 2000 04:41:30 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:41079
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129183AbQLSJlN>; Tue, 19 Dec 2000 04:41:13 -0500
Date: Tue, 19 Dec 2000 10:10:41 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Converting drivers/net/rcpci45.c to new PCI API
Message-ID: <20001219101041.B17946@jaquet.dk>
In-Reply-To: <20001219004604.B761@jaquet.dk> <20001219095906.A5764@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001219095906.A5764@se1.cogenit.fr>; from romieu@cogenit.fr on Tue, Dec 19, 2000 at 09:59:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	unregister_netdev(dev);
> > +	iounmap((void *)dev->base_addr);
> > +        free_irq(dev->irq, dev);
> 
> I'd rather inhibit irq first then release the ressources.
> +       free_irq(dev->irq, dev);
> +	iounmap((void *)dev->base_addr);
> +	unregister_netdev(dev);

Fair enough. I just copied the sequence used in the original but your
suggestion makes sense. I'll do that in my next patch.

Thanks for the eyeballs :),
  Rasmus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
