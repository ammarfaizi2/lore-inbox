Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271645AbRIPLCK>; Sun, 16 Sep 2001 07:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271672AbRIPLCB>; Sun, 16 Sep 2001 07:02:01 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:4367 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S271645AbRIPLBj>;
	Sun, 16 Sep 2001 07:01:39 -0400
Date: Sun, 16 Sep 2001 13:02:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, VDA@port.imtp.ilyichevsk.odessa.ua,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Message-ID: <20010916130201.A1327@suse.cz>
In-Reply-To: <1292125035.20010914214303@port.imtp.ilyichevsk.odessa.ua> <E15i2Bp-00017m-00@the-village.bc.nu> <20010916035207.C7542@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010916035207.C7542@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Sun, Sep 16, 2001 at 03:52:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 03:52:07AM +0200, Petr Vandrovec wrote:
> > +static void __init pci_fixup_athlon_bug(struct pci_dev *d)
> > +{ 
> > +       u8 v; 
> > +       pci_read_config_byte(d, 0x55, &v);
> > +       if(v & 0x80) {
> > +               printk(KERN_NOTICE "Stomping on Athlon bug.\n");
> > +               v &= 0x7f; /* clear bit 55.7 */
> > +               pci_write_config_byte(d, 0x55, v);
> > +       }
> > +}
> > 
> > Well, these are cosmetic changes anyway...
> > What is more important now:
> > 1) Do we have people who still see Athlon bug with the patch?
> 
> Just by any chance - does anybody have KT133 (not KT133A)
> datasheet? I just noticed at home that my KT133 has reg 55 set
> to 0x89 and it happilly lives... So maybe some BIOS vendors
> used KT133 instead of KT133A BIOS image?

Same here ...

-- 
Vojtech Pavlik
SuSE Labs
