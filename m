Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272407AbRIORpM>; Sat, 15 Sep 2001 13:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272421AbRIORpC>; Sat, 15 Sep 2001 13:45:02 -0400
Received: from [24.254.60.22] ([24.254.60.22]:5045 "EHLO
	femail32.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272407AbRIORor>; Sat, 15 Sep 2001 13:44:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, VDA@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Date: Sat, 15 Sep 2001 10:44:10 -0700
X-Mailer: KMail [version 1.2]
Cc: VANDROVE@vc.cvut.cz (Petr Vandrovec), linux-kernel@vger.kernel.org
In-Reply-To: <E15i2Bp-00017m-00@the-village.bc.nu>
In-Reply-To: <E15i2Bp-00017m-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01091510441001.00174@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 September 2001 04:16 pm, Alan Cox wrote:
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
> > 2) Do Alan read these messages? ;-)
>
> Im watching the discussion with interest. If it proves to be the magic
> bullet I will ask VIA for guidance on the issue

Not being a developer or guru on the internal software workings of the 
hardware here, I have to ask, does this clear up some bug, or does it 
disable the optimizations causing the problem? Is this a *fix* or a 
band-aid?
