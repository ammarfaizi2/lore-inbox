Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271486AbRINXMi>; Fri, 14 Sep 2001 19:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271431AbRINXM1>; Fri, 14 Sep 2001 19:12:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55054 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271486AbRINXMK>; Fri, 14 Sep 2001 19:12:10 -0400
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
To: VDA@port.imtp.ilyichevsk.odessa.ua
Date: Sat, 15 Sep 2001 00:16:05 +0100 (BST)
Cc: VANDROVE@vc.cvut.cz (Petr Vandrovec), linux-kernel@vger.kernel.org
In-Reply-To: <1292125035.20010914214303@port.imtp.ilyichevsk.odessa.ua> from "VDA" at Sep 14, 2001 09:43:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15i2Bp-00017m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void __init pci_fixup_athlon_bug(struct pci_dev *d)
> +{ 
> +       u8 v; 
> +       pci_read_config_byte(d, 0x55, &v);
> +       if(v & 0x80) {
> +               printk(KERN_NOTICE "Stomping on Athlon bug.\n");
> +               v &= 0x7f; /* clear bit 55.7 */
> +               pci_write_config_byte(d, 0x55, v);
> +       }
> +}
> 
> Well, these are cosmetic changes anyway...
> What is more important now:
> 1) Do we have people who still see Athlon bug with the patch?
> 2) Do Alan read these messages? ;-)

Im watching the discussion with interest. If it proves to be the magic 
bullet I will ask VIA for guidance on the issue
