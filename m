Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUELWxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUELWxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUELWxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:53:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:64982 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263000AbUELWxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:53:03 -0400
Date: Thu, 13 May 2004 00:52:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: support@connectcom.net
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.6: SCSI advansys.c doesn't compilefor !PCI
Message-ID: <20040512225254.GA21408@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.6-mm1 (but it doesn't seem to 
be specific to -mm) with CONFIG_PCI=n:

<--   snip  -->

...
  CC      drivers/scsi/advansys.o
drivers/scsi/advansys.c: In function `advansys_detect':
drivers/scsi/advansys.c:4770: error: `pci_devp' undeclared (first use in this function)
drivers/scsi/advansys.c:4770: error: (Each undeclared identifier is reported only once
drivers/scsi/advansys.c:4770: error: for each function it appears in.)
drivers/scsi/advansys.c: In function `DvcAdvWritePCIConfigByte':
drivers/scsi/advansys.c:9154: warning: `return' with a value, in function returning void
drivers/scsi/advansys.c: In function `AscInitFromAscDvcVar':
drivers/scsi/advansys.c:12306: error: dereferencing pointer to incomplete type
make[2]: *** [drivers/scsi/advansys.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

