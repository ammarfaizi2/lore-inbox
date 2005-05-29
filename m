Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVE2PBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVE2PBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 11:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVE2PBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 11:01:13 -0400
Received: from customer-200-33-143-226.uninet.net.mx ([200.33.143.226]:6672
	"EHLO canela.sanfelipe.com.mx") by vger.kernel.org with ESMTP
	id S261334AbVE2PAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 11:00:51 -0400
Subject: [OFF TOPIC]? Maxtor disk problem
From: "Bob R. Taylor" <brtaylor@sanfelipe.com.mx>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117302005.3865.44.camel@ann.qtpi.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 May 2005 22:17:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before I get any egg on my face by returning this disk, I am asking the
IDE gurus opinion. I'm also sorry for bothering lkml.

I'm running FedoraCore 2 on a Alpha LX164 box with 512M RAM. The on
board IDE chip won't handle current IDE so I purchased a HighPoint
Rocket133 and a Maxtor 120G drive. On boot, the kernel panics after
probing the drive reporting "INVALID HEADS" etc. I then gave the kernel
hde=noprobe option via SRM to boot the system after adding "alias
block-major-33 ide-probe" to /etc/modprobe.conf. While fsdisk /dev/hde
reports "unable to read /dev/hde", hdparm -I reports the following:

/dev/hde:
 
ATA device, with non-removable media
        Model Number:       Maxtor CALYPSO
        Firmware Revision:  YAR43KJZ
Standards:
        Likely used: 1
Configuration:
        fixed drive
        Logical         max     current
        cylinders       0       0
        heads           0       0
        sectors/track   0       0
        --
        device size with M = 1024*1024:           0 MBytes
        device size with M = 1000*1000:           0 MBytes
Capabilities:
        IORDY not likely
        Cannot perform double-word IO
        R/W multiple sector transfer: not supported
        DMA: not supported
        PIO: pio0

I'm not familiar with IDE at all. I have always used SCSI. However, my
SCSI disk is full and I'm short of money.

My current opinion is the disk is bad. Could an expert please confirm
this or please tell me how to fix it? Sorry, printed on the disk is: LBA
240121728 which, I presume, is the total sectors.

Thanks in advance.

More data:

cat /proc/devices (edited)

Block devices:
  1 ramdisk
  2 fd
  8 sd
  9 md
 11 sr
 33 ide2
 65 sd
 
ls -l /proc/ide

-r--r--r--  1 root root 0 May 28 10:32 cmd64x
-r--r--r--  1 root root 0 May 28 10:32 drivers
lrwxrwxrwx  1 root root 8 May 28 10:32 hde -> ide2/hde
-r--r--r--  1 root root 0 May 28 10:32 hpt366
dr-xr-xr-x  3 root root 0 May 28 10:32 ide2

-- 
Bob R. Taylor <brtaylor@sanfelipe.com.mx>
