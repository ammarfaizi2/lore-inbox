Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbRBHRuz>; Thu, 8 Feb 2001 12:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129512AbRBHRup>; Thu, 8 Feb 2001 12:50:45 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23815 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129092AbRBHRuk>;
	Thu, 8 Feb 2001 12:50:40 -0500
Message-ID: <3A82DB42.46EA0696@mandrakesoft.com>
Date: Thu, 08 Feb 2001 12:45:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois romieu <romieu@ensta.fr>
CC: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Remaining net/ pci_enable_device cleanups.
In-Reply-To: <Pine.LNX.4.31.0102072310240.29253-100000@athlon.local> <3A821701.C7ED5ED2@mandrakesoft.com> <20010208091819.A30551@nic.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois romieu wrote:
> 
> The Wed, Feb 07, 2001 at 10:48:17PM -0500, Jeff Garzik wrote :
> [...]
> > > diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/epic100.c linux-dj/drivers/net/epic100.c
> > > --- linux/drivers/net/epic100.c Wed Feb  7 21:55:56 2001
> > > +++ linux-dj/drivers/net/epic100.c      Wed Feb  7 22:15:22 2001
> >
> > applied
> 
> @@ -341,7 +341,7 @@
>         static int printed_version;
>         long ioaddr;
>         int chip_idx = (int) ent->driver_data;
> -       const int irq = pdev->irq;
> +       int irq;
>         struct net_device *dev;
>         struct epic_private *ep;
>         int i, option = 0, duplex = 0;
> @@ -354,10 +354,11 @@
>                 printk (KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
>                         version, version2, version3);
> 
> -       i = pci_enable_device(pdev);
> -       if (i)
> +       if (pci_enable_device(pdev))
>                 return i;
> 
> return i ? Looks bogus to me.

Definitely bogus and I forgot to mention that I fixed this up :)

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
