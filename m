Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131523AbRAQVdp>; Wed, 17 Jan 2001 16:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131527AbRAQVd0>; Wed, 17 Jan 2001 16:33:26 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:22311 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S131523AbRAQVdX>; Wed, 17 Jan 2001 16:33:23 -0500
From: Paul Bristow <paul@paulbristow.net>
Reply-To: paul@paulbristow.net
Date: Wed, 17 Jan 2001 22:37:23 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3A65FD84.129CA315@Hell.WH8.TU-Dresden.De>
In-Reply-To: <3A65FD84.129CA315@Hell.WH8.TU-Dresden.De>
Subject: PCMCIA problem loading ide-floppy from ide_cs
Cc: David Hinds <dhinds@sonic.net>
MIME-Version: 1.0
Message-Id: <01011722372302.01013@zoltar.quantum.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to understand the new PCMCIA configuration.  So far I am trying 
to use the kernel PCMCIA driver.  The yenta_socket driver is working fine. 

Using 2.4.0, and cardmgr 3.1.23

When I insert my Iomega Clik drive, cardmgr correctly identifies it as an ATA 
Fixed Disk and loads ide_cs.  ide_cs does the ide_probe and correctly assumes 
that the drive is an ide-floppy.  However at this point it doesn't seem to 
even try to load the module.  KMOD is set to y in .config

If I preload the ide-floppy module everything loads up fine and I can use the 
drive perfectly.  However, when I do a cardctl eject 0, everything screws up. 
The eject command says it works, unlinks ide_cs, but seems to leave 
ide-floppy working!  and yes, I have run depmod -a about a zillion times.

modprobe -nv finds the modules no problem.

Any pointers on where or what is wrong here?

Thanks

-- 

Paul Bristow
ide-floppy maintainer
http://paulbristow.net/linux/idefloppy.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
