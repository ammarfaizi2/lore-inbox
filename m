Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWDOPDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWDOPDz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 11:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWDOPDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 11:03:55 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:55698 "EHLO mail48.e.nsc.no")
	by vger.kernel.org with ESMTP id S1030256AbWDOPDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 11:03:55 -0400
To: linux-kernel@vger.kernel.org
Subject: SATA Conflict with PATA DMA
From: Esben Stien <b0ef@esben-stien.name>
Date: Sat, 15 Apr 2006 19:02:35 +0200
Message-ID: <87odz2kc0k.fsf@esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having problems enabling DMA for my PATA HD.

hdparm -d1 /dev/hdb reports: 
HDIO_SET_DMA failed: Operation not permitted

Of course, I'm super user. Nothing is printed in dmesg. 

I'm on linux-2.6.16 and motherboard is Fujitsu Siemens D1561 with an
ICH5. I also have a SATA hd in the computer and this only happens when
the SATA hd is there. If I remove the SATA HD, then I can enable DMA
for the PATA hd.

Both the SATA and the PATA are very new. 

# zcat /proc/config.gz |grep -i dma
CONFIG_GENERIC_ISA_DMA=y
CONFIG_ISA_DMA_API=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_SCSI_PDC_ADMA is not set

Any pointers as to what I can try?

-- 
Esben Stien is b0ef@e     s      a             
         http://www. s     t    n m
          irc://irc.  b  -  i  .   e/%23contact
          [sip|iax]:   e     e 
           jid:b0ef@    n     n
