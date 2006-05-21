Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWEUKGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWEUKGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEUKGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:06:51 -0400
Received: from bay122-f10.bay122.hotmail.com ([207.46.10.218]:15016 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932356AbWEUKGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:06:50 -0400
Message-ID: <BAY122-F1005FA13DD8848952B2FDBD0A50@phx.gbl>
X-Originating-IP: [84.160.74.149]
X-Originating-Email: [raselmsh@hotmail.com]
From: "Michael T" <raselmsh@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: PCI: mmconfig does not work with my ASUS K8N4-E board
Date: Sun, 21 May 2006 12:06:47 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 21 May 2006 10:06:50.0129 (UTC) FILETIME=[46DF0810:01C67CBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am reporting this to the kernel mailing list on the advice of Greg KH.

I would like to report a problem with my ASUS K8N4-E board/CK804 chipset.
Basically, kernels from 2.6.14 do not boot correctly unless I use the kernel 
option
pci=nommconf.  I have tested this with several kernels, including a vanilla 
2.6.14,
2.6.15, 2.6.16 and 2.6.17-rc4.  Searching on google indicated that several 
people
have similar problems with similar hardware - obviously I can't say for sure 
that it
is exactly the same problem, but in at least two other cases, disabling 
mmconfig
enabled the system to boot.

Note that I can also boot by disabling ACPI, which requires me to specify
in the BIOS that the operating system in use is "non-PnP" in order for the
mouse to work.   If I specify
ide=nodma as a kernel parameter, I can boot, but various other components
including the nVidia ethernet (forcedeth driver) do not work.

I have included the end of the messages printed by
the kernel on bootup when mmconfig is not disabled below.  I can happily 
either
post additional information such as .config, dmesg (when the kernel is 
booted
with mmconfig disabled) or lspci output to the mailing list or send it by 
e-mail to
anyone who is interested, but I have not posted anything initially to avoid
clogging up the list.

Please note that I am not subscribed to the mailing list, so I would request 
you to
CC me any answers you would like me to reply to fast.  This e-mail address 
is not
permanent, but I will monitor it at least as long as this thread is 
relevant.

Regards and thanks,

Michael

End of bootlog when mmconfig is active follows:

NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb: DMA
NFORCE-CK804 Bus-Master DMA disabled (BIOS)
hda: WDC WD1600JB-00REA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST DVDRAM GSA-4167B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 ob irq 15
SCSI subsystem initialized
hda: max request size 1024KiB
hda: cache flushes supported
hda:<4>hda: dma_timer_expiry: dma_status == 0xff
hda: dma_timer_expiry: dma_status == 0xff
hda: dma_timer_expiry: dma_status == 0xff
(...)
Done.
Begin: Waiting for root file system... ...
hda: dma_timer_expiry: dma_status == 0xff
(...)
Done.
ALERT! /dev/hda2 does not exist. Dropping to a shell!
(shell...)

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

