Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTDQAqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTDQAqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:46:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55246 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261839AbTDQAqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:46:06 -0400
Message-ID: <3E9DFC0D.6010808@pobox.com>
Date: Wed, 16 Apr 2003 20:57:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] net driver stuff
Content-Type: multipart/mixed;
 boundary="------------040900060005070707010508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040900060005070707010508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------040900060005070707010508
Content-Type: text/plain;
 name="net-drivers-2.5.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers-2.5.txt"

Linus, please do a

	bk pull http://gkernel.bkbits.net/net-drivers-2.5

This will update the following files:

 drivers/char/epca.c              |   12 ++----------
 drivers/net/e1000/e1000_main.c   |   26 ++++++++++++++++----------
 drivers/net/e1000/e1000_param.c  |    2 +-
 drivers/net/fc/iph5526.c         |    4 ++--
 drivers/net/macmace.c            |    4 ++--
 drivers/net/rcpci45.c            |   10 +++-------
 drivers/net/tokenring/tms380tr.c |    4 ++--
 drivers/net/tulip/tulip_core.c   |    8 ++------
 drivers/net/wan/pc300_tty.c      |    1 +
 drivers/net/wan/sdla_chdlc.c     |    1 +
 include/linux/pci_ids.h          |    3 +++
 11 files changed, 35 insertions(+), 40 deletions(-)

through these ChangeSets:

<cramerj@intel.com> (03/04/07 1.971.81.10)
   [E1000] Fixed syntax error for C99 initializers
   
   * Fixed syntax error for C99 initializers

<rusty@rustcorp.com.au> (03/04/07 1.971.81.9)
   [PATCH] [PATCH 2.5.63] epca tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT
   
   [ Arjan: you touched it last AFAICT.  Seems trivial. --RR ]
   
   From:  Hanna Linder <hannal@us.ibm.com>

<scott.feldman@intel.com> (03/04/07 1.971.81.8)
   [E1000] Revert NAPI back to interrupt disable/enable mode
   
   * Undo botched attempt to run NAPI without
     disabling/enabling interrupts.
     [Robert.Olssen@data.slu.se]

<rusty@rustcorp.com.au> (03/04/07 1.971.81.7)
   [PATCH] [2.5 patch] fix the compilation of drivers_net_tokenring_tms380tr.c
   
   [ Guys, assume this is OK? ]
   
   From:  Adrian Bunk <bunk@fs.tum.de>
   
     Since 2.5.61 compilation of drivers/net/tokenring/tms380tr.c fails with
     the following error:
   
     <--  snip  -->
   
     ...
       gcc -Wp,-MD,drivers/net/tokenring/.tms380tr.o.d -D__KERNEL__ -Iinclude
     -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
     -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
     -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
     -DKBUILD_BASENAME=tms380tr -DKBUILD_MODNAME=tms380tr -c -o
     drivers/net/tokenring/tms380tr.o drivers/net/tokenring/tms380tr.c
     drivers/net/tokenring/tms380tr.c: In function `tms380tr_open':
     drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
     drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
     drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
     drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
     drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
     drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
     drivers/net/tokenring/tms380tr.c: In function `tms380tr_init_adapter':
     drivers/net/tokenring/tms380tr.c:1461: warning: long unsigned int format, different type arg (arg3)
     make[3]: *** [drivers/net/tokenring/tms380tr.o] Error 1
   
     <--  snip  -->
   
   
     The following patch by Jochen Friedrich fixes both the compile error and
     the warning:

<rusty@rustcorp.com.au> (03/04/07 1.971.81.6)
   [PATCH] [PATCH 2.5.63] net_wan_pc300_tty tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT
   
   From:  Hanna Linder <hannal@us.ibm.com>

<rusty@rustcorp.com.au> (03/04/07 1.971.81.5)
   [PATCH] [PATCH 2.5.63] net_wan_sdla_chdlc tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT
   
   From:  Hanna Linder <hannal@us.ibm.com>

<rusty@rustcorp.com.au> (03/04/07 1.971.81.4)
   [PATCH] Clear up GFP confusion in rcpci45.c
   
   [ Jeff, Pete: looks correct.  Please check. --RR ]
   
   From:  Matthew Wilcox <willy@debian.org>
   
   
      - Move PCI ID definitions to pci_ids.h
      - The GFP_DMA in rcpci45_init_one should be GFP_KERNEL because it's a
        pci_driver ->probe method, so it can sleep.
      - The GFP_DMA in RC_allocate_and_post_buffers should be GFP_ATOMIC
        because it's called from a timer function, so it must not sleep.

<rusty@rustcorp.com.au> (03/04/07 1.971.81.3)
   [PATCH] Remove naked GFP_DMA from drivers_net_macmace.c
   
   From:  Matthew Wilcox <willy@debian.org>
   
   
     Can use GFP_KERNEL since this is a netdevice ->open routine.

<rusty@rustcorp.com.au> (03/04/07 1.971.81.2)
   [PATCH] Unreachable code in drivers_net_fc_iph5526.c
   
   From:  Scott Russell <scott@pantastik.com>
   
     - Rearranged unreachable printk code reported at kbugs.org

<zwane@linuxpower.ca> (03/04/07 1.971.81.1)
   [PATCH] SET_MODULE_OWNER for tulip_core
   
   Tested with a pcmcia tulip


--------------040900060005070707010508--

