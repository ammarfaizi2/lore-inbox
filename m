Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRBGUey>; Wed, 7 Feb 2001 15:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130015AbRBGUeo>; Wed, 7 Feb 2001 15:34:44 -0500
Received: from colorfullife.com ([216.156.138.34]:2827 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129583AbRBGUed>;
	Wed, 7 Feb 2001 15:34:33 -0500
Message-ID: <3A81B169.B4539406@colorfullife.com>
Date: Wed, 07 Feb 2001 21:34:49 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: davej@suse.de, Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.31.0102071951060.17788-100000@athlon.local> <3A81A89C.DFD09434@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> +       SET_MODULE_OWNER(dev);
> 
>         irq = pdev->irq;
>

One question:
The code copies 'pdev->irq' into 'dev->irq'.

Is that required, who need 'dev->irq'?

> retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);

Can't the driver use?
 retval = request_irq(np->pci_dev->irq)

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
