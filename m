Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132914AbREBMm0>; Wed, 2 May 2001 08:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133022AbREBMmR>; Wed, 2 May 2001 08:42:17 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:42513 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S132934AbREBMl5>; Wed, 2 May 2001 08:41:57 -0400
Message-ID: <CDF99E351003D311A8B0009027457F140810E2ED@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: fluido@fluido.as
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: RE: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi mo
	 dule
Date: Wed, 2 May 2001 07:40:50 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That one's mine.  It should be:
>    scsi_set_pci_device(shpnt, pdev);

Can you please try this patch and see if it works for you?

diff -burN linux-2.4.4/drivers/scsi/fdomain.c linux/drivers/scsi/fdomain.c
--- linux-2.4.4/drivers/scsi/fdomain.c  Fri Apr 27 15:59:18 2001
+++ linux/drivers/scsi/fdomain.c        Wed May  2 07:27:32 2001
@@ -971,7 +971,7 @@
        return 0;
    shpnt->irq = interrupt_level;
    shpnt->io_port = port_base;
-   scsi_set_pci_device(shpnt->pci_dev, pdev);
+   scsi_set_pci_device(shpnt, pdev);
    shpnt->n_io_port = 0x10;
    print_banner( shpnt );




Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux
