Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTEHFHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 01:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbTEHFHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 01:07:54 -0400
Received: from outbound01.telus.net ([199.185.220.220]:63946 "EHLO
	priv-edtnes03-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S261179AbTEHFHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 01:07:52 -0400
Subject: 2.4.21-rc boot stalls
From: Bob Gill <gillb4@telusplanet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 May 2003 23:21:47 -0600
Message-Id: <1052371307.2703.43.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I just built 2.4.21-rc.  It hangs on boot.  More specifically, I
get: 
hda: (ide_dma_test_irq) called while not waiting
blk queue c031e840
I/O limit 4095 Mb (mask 0xffffffff)
setting using_dma_to 1 (on)


... It gets here and stalls.  No OOPS.  My ide devices are:
cat /proc/ide/hda/model
Maxtor 92041U4
cat /proc/ide/hdb/model
Maxtor 98196H8
cat /proc/ide/hdc/model
SAMSUNG DVD-ROM SD-608
cat /proc/ide/hdd/model
CR-4804TE

My chipset is:
cat /proc/ide/sis
SiS 5513 Ultra 100 chipset
--------------- Primary Channel ---------------- Secondary Channel
-------------Channel Status: On 	 	 	 	 On 
Operation Mode: Compatible 	 	 	 Compatible 
Cable Type:     80 pins 	 	 	 80 pins
Prefetch Count: 512 	 	 	 	 512
Drive 0:        Postwrite Enabled 	 	 Postwrite Disabled
                Prefetch  Enabled 	 	 Prefetch  Disabled
                UDMA Enabled 	 	 	 UDMA Disabled
                UDMA Cycle Time    3 CLK 	 UDMA Cycle Time    Reserved
                Data Active Time   3 PCICLK 	 Data Active Time   3
PCICLK
                Data Recovery Time 1 PCICLK 	 Data Recovery Time 1
PCICLK
Drive 1:        Postwrite Enabled 	 	 Postwrite Disabled
                Prefetch  Enabled 	 	 Prefetch  Disabled
                UDMA Enabled 	 	 	 UDMA Disabled
                UDMA Cycle Time    2 CLK 	 UDMA Cycle Time    Reserved
                Data Active Time   3 PCICLK 	 Data Active Time   3
PCICLK
                Data Recovery Time 1 PCICLK 	 Data Recovery Time 3
PCICLK


I checked /Documentation/Changes and confirmed that all of my build
software meets/exceeds the minimum requirements, but be aware I am using
gcc 3.2.2 and glibc-2.3.1.  I also use hdparm to set multi-word 32 bit
I/O with DMA (hdparm -d1 -c3 -m16 -k1) at boot time.  (Also, 2.4.21-pre6
builds/boots/runs OK).

Thanks in advance,

Bob



