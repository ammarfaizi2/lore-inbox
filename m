Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUG2UBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUG2UBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUG2UBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:01:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:2290 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S265086AbUG2UBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:01:31 -0400
Date: Thu, 29 Jul 2004 13:01:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sylvain Munaut <tnt@246tnt.com>
Subject: [PPC32] Board updates ready for you
Message-ID: <20040729200128.GH16468@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes are ready for you at:
bk://ppc.bkbits.net/for-linus-ppc

ChangeSet@1.1817, 2004-07-29 08:17:53-07:00, trini@kernel.crashing.org
  [PPC32] Merge MPC52xx changes with recent CPM changes.

ChangeSet@1.1814.1.99, 2004-07-29 15:12:57+02:00, tnt@246tNt-laptop.lan.ayanami.246tNt.com
  [serial/ppc] Add support for MPC52xx PSCs.
  
  Can be used as serial port and console. Compliant with the OCP driver model.
  
  Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

ChangeSet@1.1814.1.98, 2004-07-29 15:09:03+02:00, tnt@246tNt-laptop.lan.ayanami.246tNt.com
  [ppc] Add basic support for the Freescale MPC52xx embedded CPU and the LITE5200 platform
  
  Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

ChangeSet@1.1816, 2004-07-27 14:46:47-07:00, trini@kernel.crashing.org
  PPC32: Finish support for the EmbeddedPlanet RPX8260 board.
  From Dan Malek <dan@embeddededge.com> and myself.

ChangeSet@1.1815, 2004-07-19 09:47:34-07:00, trini@kernel.crashing.org
  PPC32: Typo fix in m8xx serial driver.

With a diffstat of:
 Documentation/powerpc/mpc52xx.txt       |   48 +
 arch/ppc/Kconfig                        |   32 -
 arch/ppc/boot/common/misc-common.c      |   15 
 arch/ppc/boot/simple/Makefile           |   11 
 arch/ppc/boot/simple/embed_config.c     |    6 
 arch/ppc/boot/simple/head.S             |    4 
 arch/ppc/boot/simple/m8260_tty.c        |   25 
 arch/ppc/boot/simple/misc-embedded.c    |    4 
 arch/ppc/boot/simple/mpc52xx_tty.c      |  138 +++++
 arch/ppc/configs/lite5200_defconfig     |  436 ++++++++++++++++
 arch/ppc/configs/rpx8260_defconfig      |  556 ++++++++++++++++++++
 arch/ppc/kernel/cputable.c              |    4 
 arch/ppc/platforms/Makefile             |    2 
 arch/ppc/platforms/lite5200.c           |  152 +++++
 arch/ppc/platforms/lite5200.h           |   23 
 arch/ppc/platforms/mpc5200.c            |   29 +
 arch/ppc/platforms/rpx8260.c            |   65 ++
 arch/ppc/platforms/rpx8260.h            |   74 ++
 arch/ppc/platforms/rpxsuper.h           |   72 --
 arch/ppc/syslib/Makefile                |    1 
 arch/ppc/syslib/mpc52xx_pic.c           |  252 +++++++++
 arch/ppc/syslib/mpc52xx_setup.c         |  228 ++++++++
 drivers/serial/Kconfig                  |   27 
 drivers/serial/Makefile                 |    1 
 drivers/serial/cpm_uart/cpm_uart_cpm1.c |    2 
 drivers/serial/mpc52xx_uart.c           |  869 ++++++++++++++++++++++++++++++++
 include/asm-ppc/mpc52xx.h               |  380 +++++++++++++
 include/asm-ppc/mpc52xx_psc.h           |  191 +++++++
 include/asm-ppc/mpc8260.h               |    4 
 include/asm-ppc/ocp_ids.h               |    1 
 include/asm-ppc/ppcboot.h               |    7 
 include/linux/serial_core.h             |    3 
 32 files changed, 3555 insertions(+), 107 deletions(-)

The mpc52xx work has been in Andrews tree for a few weeks now, and all
parties involved with it are happy with it.  The rpx8260 changes make a
long-existing 8260 board finally work.  No changes have been made to
previously working systems.  Please apply, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
