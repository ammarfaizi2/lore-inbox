Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131805AbRAMTqP>; Sat, 13 Jan 2001 14:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132017AbRAMTqG>; Sat, 13 Jan 2001 14:46:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32520 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131805AbRAMTpt>; Sat, 13 Jan 2001 14:45:49 -0500
Subject: Re: ide.2.4.1-p3.01112001.patch
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Sat, 13 Jan 2001 19:46:42 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <20010113150046.E1155@suse.cz> from "Vojtech Pavlik" at Jan 13, 2001 03:00:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HWdQ-0006VF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_SIS5513) ||
>  		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
>  		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PIIX4NX) ||
> -		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X))
> +		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X)  ||
> +		    IDE_PCI_DEVID_EQ(d->devid, DEVID_VIA_IDE) ||
> +		    IDE_PCI_DEVID_EQ(d->devid, DEVID_VP_IDE))
>  			autodma = 0;
>  		if (autodma)
>  			hwif->autodma = 1;

How about

		    && !force_dma)


__setup("force_dma") ...

So those who want to play fast can
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
