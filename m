Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132919AbREBM0N>; Wed, 2 May 2001 08:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132914AbREBM0C>; Wed, 2 May 2001 08:26:02 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:11773 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S132909AbREBMZt>; Wed, 2 May 2001 08:25:49 -0400
Message-ID: <CDF99E351003D311A8B0009027457F140810E2EC@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: alan@lxorguk.ukuu.org.uk, fluido@fluido.as
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi mo
	dule
Date: Wed, 2 May 2001 07:24:35 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	 if(pdev!=NULL)
> >     scsi_set_pci_device(shpnt->pci_dev, pdev);
>
> I suspect it should be
> 
> 	if(shpnt->pci_dev)
> 
> but the effect is identical


That one's mine.  It should be:
   scsi_set_pci_device(shpnt, pdev);

There's no reason to check if pdev != NULL first, as it's NULL in the
structure beforehand, and NULL afterward.

I'll fix and submit a patch, and make sure I didn't make the same mistake
elsewhere too.

Thanks,
Matt
