Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318649AbSHPScs>; Fri, 16 Aug 2002 14:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318652AbSHPScs>; Fri, 16 Aug 2002 14:32:48 -0400
Received: from atlas015.atlas-iap.es ([194.224.1.15]:60616 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S318649AbSHPScr>; Fri, 16 Aug 2002 14:32:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.4.19 and Promise 20267 doesn't recognise ide raid
Date: Fri, 16 Aug 2002 20:36:38 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17flxe-0007iH-00@antoli.gallimedina.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just upgraded a server from 2.4.17 to 2.4.19, had to go down to 2.4.18. 

It doesn't boot with 2.4.19, the error is (ish, messages are not logged 
because the disk cannot be mounted, neither the root filesystem):

- RAID cannot be found.
- Cannot mount root FS.

I checked that drivers/ide/pdc202xx.c has been changed extensively from 
2.4.18 to 2.4.19.

I believes the config is the right one (at least similar to the working 
2.4.17 and 2.4.18):

CONFIG_BLK_DEV_PDC202XX=y
CONFIG_PDC202XX_BURST=y
CONFIG_PDC202XX_FORCE=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=y
CONFIG_BLK_DEV_ATARAID_PDC=y
CONFIG_BLK_DEV_ATARAID_HPT=y


Hope this helps.

-- 
  ricardo
       A paperless office has about as much a chance as a paperless bathroom
