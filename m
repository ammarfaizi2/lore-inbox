Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129505AbRBIBHX>; Thu, 8 Feb 2001 20:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129758AbRBIBHD>; Thu, 8 Feb 2001 20:07:03 -0500
Received: from expanse.dds.nl ([194.109.10.118]:43794 "EHLO expanse.dds.nl")
	by vger.kernel.org with ESMTP id <S129505AbRBIBG5>;
	Thu, 8 Feb 2001 20:06:57 -0500
Date: Fri, 9 Feb 2001 02:06:54 +0100
From: Ookhoi <ookhoi@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: Oops when loading airo.o, 2.4.1-ac7
Message-ID: <20010209020653.A4103@ookhoi.dds.nl>
Reply-To: ookhoi@dds.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.14i
X-Uptime: 3:35pm  up 10 days,  2:39, 15 users,  load average: 0.07, 0.35, 0.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

root@tilde:~# lsmod
Module                  Size  Used by
root@tilde:~# lsmod
Module                  Size  Used by
root@tilde:~# insmod airo
Using /lib/modules/2.4.1-ac7/pcmcia/airo.o
root@tilde:~# lsmod
Module                  Size  Used by
airo                   25232   0  (unused)
root@tilde:~# cat /proc/driver/aironet/eth1/Config 
Segmentation fault
root@tilde:~# uname -a
Linux tilde 2.4.1-ac7 #1 Fri Feb 9 01:02:00 CET 2001 i586 unknown

airo is a module for the cisco aironet wireless network cards. I have a
pcmcia 342, and a pci 342 (which just looks like a pcmcia card mounted
on a pci board). The pcmcia cards in my notebook seemes to work ok
(can't test, but the /proc interface works fine and the card reacts on
that), but the pci in my pc gives the above problem. Also tried -ac5.

/var/log/syslog only says:
Feb  9 01:52:52 tilde kernel: airo:  Probing for PCI adapters
Feb  9 01:52:52 tilde kernel: airo: Doing fast bap_reads
Feb  9 01:52:52 tilde kernel: airo: MAC enabled eth1 0:40:96:45:be:e6
Feb  9 01:52:52 tilde kernel: airo:  Finished probing for PCI adapters
Feb  9 01:53:05 tilde kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000034
Feb  9 01:53:05 tilde kernel:  printing eip:
Feb  9 01:53:05 tilde kernel: c48ec688
Feb  9 01:53:05 tilde kernel: *pde = 00000000
Feb  9 01:53:05 tilde kernel: Oops: 0000
Feb  9 01:53:05 tilde kernel: CPU:    0

The system sometimes seemes to be fine after this, and sometimes it
freezes. The nic doesn't work. 

What can I do to provide more info?

		Ookhoi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
