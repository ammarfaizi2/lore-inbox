Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHIVN>; Thu, 8 Feb 2001 03:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBHIVE>; Thu, 8 Feb 2001 03:21:04 -0500
Received: from astrid2.nic.fr ([192.134.4.2]:7946 "EHLO astrid2.nic.fr")
	by vger.kernel.org with ESMTP id <S129032AbRBHIUr>;
	Thu, 8 Feb 2001 03:20:47 -0500
Date: Thu, 8 Feb 2001 09:18:19 +0000
From: Francois romieu <romieu@ensta.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Remaining net/ pci_enable_device cleanups.
Message-ID: <20010208091819.A30551@nic.fr>
Reply-To: Francois romieu <romieu@ensta.fr>
In-Reply-To: <Pine.LNX.4.31.0102072310240.29253-100000@athlon.local> <3A821701.C7ED5ED2@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A821701.C7ED5ED2@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Feb 07, 2001 at 10:48:17PM -0500
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Wed, Feb 07, 2001 at 10:48:17PM -0500, Jeff Garzik wrote :
[...]
> > diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/epic100.c linux-dj/drivers/net/epic100.c
> > --- linux/drivers/net/epic100.c Wed Feb  7 21:55:56 2001
> > +++ linux-dj/drivers/net/epic100.c      Wed Feb  7 22:15:22 2001
> 
> applied


@@ -341,7 +341,7 @@
        static int printed_version;
        long ioaddr;
        int chip_idx = (int) ent->driver_data;
-       const int irq = pdev->irq;
+       int irq;
        struct net_device *dev;
        struct epic_private *ep;
        int i, option = 0, duplex = 0;
@@ -354,10 +354,11 @@
                printk (KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
                        version, version2, version3);

-       i = pci_enable_device(pdev);
-       if (i)
+       if (pci_enable_device(pdev))
                return i;

return i ? Looks bogus to me.

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
