Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSGXOyL>; Wed, 24 Jul 2002 10:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSGXOyL>; Wed, 24 Jul 2002 10:54:11 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:27345 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S317300AbSGXOyL>; Wed, 24 Jul 2002 10:54:11 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Muli Ben-Yehuda <mulix@actcom.co.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Boot problem, 2.4.19-rc3-ac1
References: <Pine.LNX.4.44.0207241655011.17209-100000@linux-box.realnet.co.sz>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 24 Jul 2002 10:57:14 -0400
In-Reply-To: <Pine.LNX.4.44.0207241655011.17209-100000@linux-box.realnet.co.sz>
Message-ID: <9cffzy95g39.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> On 24 Jul 2002, Ian Soboroff wrote:
> 
> >  static int trident_suspend(struct pci_dev *dev, u32 unused)
> >  {
> > -       struct trident_card *card = (struct trident_card *) dev;
> > +       struct trident_card *card = pci_get_drvdata(dev);
> >  
> >         if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
> >                 ali_save_regs(card);
> > @@ -3466,7 +3466,7 @@
> >  
> >  static int trident_resume(struct pci_dev *dev)
> >  {
> > -       struct trident_card *card = (struct trident_card *) dev;
> > +       struct trident_card *card = pci_get_drvdata(dev);
> >  
> >         if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
> >                 ali_restore_regs(card);
> 
> Thats definitely correct, has this patch been sent to lkml before?

I didn't see it in a quick search at the uwsg.ia.edu archive.  The
last ALi patch I see on 2.4 seems to come from Matt Wu at ALi on
4/4/2001.

Anyone have a clue on the IDE part of my question? ;-)

ian
