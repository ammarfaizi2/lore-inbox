Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291425AbSBHFXq>; Fri, 8 Feb 2002 00:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291423AbSBHFXh>; Fri, 8 Feb 2002 00:23:37 -0500
Received: from gear.torque.net ([204.138.244.1]:15108 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S291421AbSBHFXW>;
	Fri, 8 Feb 2002 00:23:22 -0500
Message-ID: <3C6360AE.96BE9BED@torque.net>
Date: Fri, 08 Feb 2002 00:22:54 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.4-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [subversion of 2.5.4-pre3] __pa() still works
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For anyone fighting with this little gem:
  "virt_to_bus_not_defined_use_pci_map"
in lk 2.5.4-pre4 ... you should read
Documentation/DMA-mapping.txt and change lots of 
code. Alternatively you may be pleased to know that 
__pa() still works as a replacement for virt_to_bus()
on i386. [Also __va() instead of bus_to_virt() .]

Since my system uses an advansys SCSI adapter I
have been rather busy. There is an impressive
list of "pre3" breakages on my system:
  ide-dma.c   [patch from Jens on lkml]
  ide-scsi.c    "      "
  sg.c          "      "
  advansys.c
  scsi_debug   [simple fix]
  usb/storage/debug.c  [simple fix]
  sound.c    [too tired]
  ...

$ uname -a
Linux frig 2.5.4-pre3 #72 Thu Feb 7 23:24:06 EST 2002 i686 unknown

Please accompany any flames with the correct "pci_map"
patch to the advansys driver:-)


Doug Gilbert
