Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131001AbQLIVer>; Sat, 9 Dec 2000 16:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131223AbQLIVeh>; Sat, 9 Dec 2000 16:34:37 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131001AbQLIVeY>;
	Sat, 9 Dec 2000 16:34:24 -0500
Message-ID: <20001209101924.A126@bug.ucw.cz>
Date: Sat, 9 Dec 2000 10:19:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rasmus Andersen <rasmus@jaquet.dk>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove warning from drivers/net/hp100.c (240-test12-pre7)
In-Reply-To: <20001208211908.D599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001208211908.D599@jaquet.dk>; from Rasmus Andersen on Fri, Dec 08, 2000 at 09:19:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch removes a 'defined but not used' warning from drivers/
> new/hp100.c when compiling without CONFIG_PCI (240t12p3). It should apply
> cleanly.

I'd say that warning is more acceptable than #ifdef... In cases where
warnings can be eliminating without ifdefs, that's okay, but this...

								Pavel

> --- linux-240-t12-pre3-clean/drivers/net/hp100.c	Sat Nov  4 23:27:07 2000
> +++ linux/drivers/net/hp100.c	Sat Dec  2 16:07:27 2000
> @@ -265,12 +265,14 @@
>  
>  #define HP100_EISA_IDS_SIZE	(sizeof(hp100_eisa_ids)/sizeof(struct hp100_eisa_id))
>  
> +#ifdef CONFIG_PCI
>  static struct hp100_pci_id hp100_pci_ids[] = {
>    { PCI_VENDOR_ID_HP, 		PCI_DEVICE_ID_HP_J2585A },
>    { PCI_VENDOR_ID_HP,		PCI_DEVICE_ID_HP_J2585B },
>    { PCI_VENDOR_ID_COMPEX,	PCI_DEVICE_ID_COMPEX_ENET100VG4 },
>    { PCI_VENDOR_ID_COMPEX2,	PCI_DEVICE_ID_COMPEX2_100VG }
>  };
> +#endif
>  
>  #define HP100_PCI_IDS_SIZE	(sizeof(hp100_pci_ids)/sizeof(struct hp100_pci_id))


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
