Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273144AbRIPBrn>; Sat, 15 Sep 2001 21:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273143AbRIPBrd>; Sat, 15 Sep 2001 21:47:33 -0400
Received: from p0019.as-l042.contactel.cz ([194.108.237.19]:10112 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S273136AbRIPBrO>;
	Sat, 15 Sep 2001 21:47:14 -0400
Date: Sun, 16 Sep 2001 03:52:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: VDA@port.imtp.ilyichevsk.odessa.ua, alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Message-ID: <20010916035207.C7542@ppc.vc.cvut.cz>
In-Reply-To: <1292125035.20010914214303@port.imtp.ilyichevsk.odessa.ua> <E15i2Bp-00017m-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15i2Bp-00017m-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
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

Just by any chance - does anybody have KT133 (not KT133A)
datasheet? I just noticed at home that my KT133 has reg 55 set
to 0x89 and it happilly lives... So maybe some BIOS vendors
used KT133 instead of KT133A BIOS image?
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz
						

