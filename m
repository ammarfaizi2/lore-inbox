Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313174AbSDYO6j>; Thu, 25 Apr 2002 10:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSDYO6i>; Thu, 25 Apr 2002 10:58:38 -0400
Received: from TK212017087078.teleweb.at ([212.17.87.78]:62848 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S313174AbSDYO6h>;
	Thu, 25 Apr 2002 10:58:37 -0400
Message-ID: <3CC81A29.3050204@fsmat.at>
Date: Thu, 25 Apr 2002 17:00:57 +0200
From: FonkiE <fonkie@fsmat.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux1394-user@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: problems with sbp2 and sd_mod (ipod firewire harddisk)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i have an ipod too. yesterday everything worked fine. today i updated
from firmware 1.02 to 1.1. now the system crashed with 'modprobe sbp2'.

i tried it with 2.4.17 and 2.4.19-pre1.

what i know is that the mac-partition-map changed. so it may as well be
the the code that handles that which is the problem...

the most info i can get out of logfiles:

Apr 25 15:56:05 elch kernel: ohci1394: $Revision: 1.80 $ Ben Collins 
<bcollins@debian.org>
Apr 25 15:56:05 elch kernel: PCI: Found IRQ 11 for device 00:0d.0
Apr 25 15:56:05 elch kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11] 
MMIO=[efffe000-effff000]  Max Packet=[2048]
Apr 25 15:56:05 elch kernel: ieee1394: Device added: node 1:1023, GUID 
000a27000201e05c
Apr 25 15:56:05 elch /sbin/hotplug: no runnable 
/etc/hotplug/ieee1394.agent is installed
Apr 25 15:56:11 elch kernel: ieee1394: sbp2: Driver forced to serialize 
I/O (serialize_io = 1)
Apr 25 15:56:11 elch kernel: ieee1394: sbp2: Node 1:1023: Max speed 
[S400] - Max payload [2048]
Apr 25 15:56:11 elch kernel: scsi4 : IEEE-1394 SBP-2 protocol driver
Apr 25 15:56:11 elch kernel:   Vendor: Apple     Model: iPod 
   Rev: 1.10
Apr 25 15:56:11 elch kernel:   Type:   Direct-Access 
   ANSI SCSI revision: 02
Apr 25 15:56:11 elch kernel: Attached scsi removable disk sdb at scsi4, 
channel 0, id 0, lun 0
Apr 25 15:56:11 elch kernel: SCSI device sdb: 9780750 512-byte hdwr 
sectors (5008 MB)
Apr 25 15:56:11 elch kernel: sdb: Write Protect is off

then CRASH...

what ipod version do others have? similar problems? how to track it down?

a working version of the logs: (firmware 1.02 if ipod, kernel 2.4.17)

Mar 23 18:36:20 elch kernel: ohci1394: $Revision: 1.80 $ Ben Collins 
<bcollins@debian.org>
Mar 23 18:36:20 elch kernel: PCI: Found IRQ 11 for device 00:0d.0
Mar 23 18:36:20 elch kernel: ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11] 
MMIO=[efffe000-effff000]  Max Packet=[2048]
Mar 23 18:36:20 elch kernel: ieee1394: Device added: node 0:1023, GUID 
000a27000201e05c
Mar 23 18:36:20 elch /sbin/hotplug: no runnable 
/etc/hotplug/ieee1394.agent is installed
Mar 23 18:36:27 elch kernel: ieee1394: sbp2: Driver forced to serialize 
I/O (serialize_io = 1)
Mar 23 18:36:27 elch kernel: ieee1394: sbp2: Node 0:1023: Max speed 
[S400] - Max payload [2048]
Mar 23 18:36:27 elch kernel: scsi2 : IEEE-1394 SBP-2 protocol driver
Mar 23 18:36:27 elch kernel:   Vendor: 01234567  Model: 89ABCDEFGHIJKLMN 
  Rev: OPQR
Mar 23 18:36:27 elch kernel:   Type:   Direct-Access 
   ANSI SCSI revision: 02
Mar 23 18:36:27 elch kernel: Attached scsi removable disk sdb at scsi2, 
channel 0, id 0, lun 0
Mar 23 18:36:27 elch kernel: SCSI device sdb: 9780750 512-byte hdwr 
sectors (5008 MB)
Mar 23 18:36:27 elch kernel: sdb: Write Protect is off
Mar 23 18:36:27 elch kernel:  sdb: [mac] sdb1 sdb2 sdb3

CU,
	FonkiE

