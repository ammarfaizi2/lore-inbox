Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbRE3PTf>; Wed, 30 May 2001 11:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbRE3PTP>; Wed, 30 May 2001 11:19:15 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:53265 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S261297AbRE3PTH>; Wed, 30 May 2001 11:19:07 -0400
Message-Id: <200105301519.f4UFJ2U53164@aslan.scsiguy.com>
To: Michael David <michael@newearth.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 panic while starting aic7xxx 
In-Reply-To: Your message of "Wed, 30 May 2001 10:59:57 EDT."
             <Pine.LNX.4.32.0105301054100.1827-100000@sapphire.newearth.org> 
Date: Wed, 30 May 2001 09:19:02 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>SCSI subsystem driver Revision: 1.00
>PCI: Found IRQ 11 for device 00:0c.0
>scsi0: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
>        <Adaptec 2940 Ultra2 SCSI adapter>
>        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs
>ahc_intr: AWAITING_MSG for an SCB that does not have a waiting message
>SCSIID = 7, target_mask = 1
>Kernel panic: SCB = 3, SCB Control = 40, MSG_OUT = 80 SCB flags = 6000
>In interrupt handler - not syncing

This looks like the firmware file is not in sync with the rest
of the driver.  Depending on the host environment, you may be
able to rebuild the firmware yourself.  Just check the box in
the kernel config section for the aic7xxx driver to rebuild
the firmware.

--
Justin
