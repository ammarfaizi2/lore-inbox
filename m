Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSGXOgN>; Wed, 24 Jul 2002 10:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGXOgN>; Wed, 24 Jul 2002 10:36:13 -0400
Received: from [196.26.86.1] ([196.26.86.1]:42973 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317326AbSGXOgM>; Wed, 24 Jul 2002 10:36:12 -0400
Date: Wed, 24 Jul 2002 16:57:08 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: Muli Ben-Yehuda <mulix@actcom.co.il>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Boot problem, 2.4.19-rc3-ac1
In-Reply-To: <9cfk7nl5jcm.fsf@rogue.ncsl.nist.gov>
Message-ID: <Pine.LNX.4.44.0207241655011.17209-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jul 2002, Ian Soboroff wrote:

>  static int trident_suspend(struct pci_dev *dev, u32 unused)
>  {
> -       struct trident_card *card = (struct trident_card *) dev;
> +       struct trident_card *card = pci_get_drvdata(dev);
>  
>         if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
>                 ali_save_regs(card);
> @@ -3466,7 +3466,7 @@
>  
>  static int trident_resume(struct pci_dev *dev)
>  {
> -       struct trident_card *card = (struct trident_card *) dev;
> +       struct trident_card *card = pci_get_drvdata(dev);
>  
>         if(card->pci_id == PCI_DEVICE_ID_ALI_5451) {
>                 ali_restore_regs(card);

Thats definitely correct, has this patch been sent to lkml before?

Cheers,
	Zwane

-- 
function.linuxpower.ca

