Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268254AbTBSBap>; Tue, 18 Feb 2003 20:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268255AbTBSBap>; Tue, 18 Feb 2003 20:30:45 -0500
Received: from havoc.daloft.com ([64.213.145.173]:54253 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268254AbTBSBao>;
	Tue, 18 Feb 2003 20:30:44 -0500
Date: Tue, 18 Feb 2003 20:40:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] net driver changes
Message-ID: <20030219014041.GA7897@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
Mostly removing aironet4500 driver, and moving drivers to
drivers/net/wireless directory.

Has approval of:  aironet4500 maintainer, wireless maintainer, and me :)





Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/net/aironet4500.h            | 1607 -----------------
 drivers/net/aironet4500_card.c       | 1019 -----------
 drivers/net/aironet4500_core.c       | 3234 -----------------------------------
 drivers/net/aironet4500_proc.c       |  719 -------
 drivers/net/aironet4500_rid.c        | 2205 -----------------------
 drivers/net/arlan-proc.c             | 1274 -------------
 drivers/net/arlan.c                  | 2077 ----------------------
 drivers/net/arlan.h                  |  577 ------
 drivers/net/pcmcia/ray_cs.c          | 3012 --------------------------------
 drivers/net/pcmcia/ray_cs.h          |   78 
 drivers/net/pcmcia/rayctl.h          |  732 -------
 drivers/net/strip.c                  | 2877 -------------------------------
 Documentation/networking/8139too.txt |    2 
 drivers/net/Kconfig                  |  168 -
 drivers/net/Makefile                 |    7 
 drivers/net/pcmcia/Kconfig           |   28 
 drivers/net/pcmcia/Makefile          |    1 
 drivers/net/setup.c                  |   21 
 drivers/net/wireless/Kconfig         |   97 +
 drivers/net/wireless/Makefile        |    7 
 drivers/net/wireless/airo.c          |    4 
 drivers/net/wireless/arlan-proc.c    | 1274 +++++++++++++
 drivers/net/wireless/arlan.c         | 2077 ++++++++++++++++++++++
 drivers/net/wireless/arlan.h         |  577 ++++++
 drivers/net/wireless/ray_cs.c        | 3012 ++++++++++++++++++++++++++++++++
 drivers/net/wireless/ray_cs.h        |   78 
 drivers/net/wireless/rayctl.h        |  732 +++++++
 drivers/net/wireless/strip.c         | 2877 +++++++++++++++++++++++++++++++
 28 files changed, 10737 insertions(+), 19636 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/02/18 1.1055)
   Move the old wireless drivers into drivers/net/wireless:
   arlan, ray_cs, and strip.
   
   Contributed by Randy Dunlap.

<willy@debian.org> (03/02/17 1.1054)
   [wireless airo] call pci_enable_device, pci_set_master as needed

<jgarzik@redhat.com> (03/02/17 1.1053)
   [netdrvr] Remove superceded wireless driver aironet4500
   
   From the maintainer, Elmer Joandi(sp?):
   	aironet4500 is superseded by cisco340 drivers (airo.c) by Ben Reed
   and the  only strenght of my driver is that it allows to access absolutely
   all registers on card. Which is useful for developers only. Besides there
   is no normal interface to configure crypto in my driver, as the general
   interface is not userfriendly at all. So in fact, I use Bens driver for my
   ISP bussiness in general cases and my driver for troubleshooting.

<jgarzik@redhat.com> (03/02/17 1.1035.1.1)
   [netdrvr 8139too] add to the list of supported boards

