Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUGHQy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUGHQy7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUGHQy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:54:59 -0400
Received: from neptune.fsa.ucl.ac.be ([130.104.233.21]:19083 "EHLO
	neptune.fsa.ucl.ac.be") by vger.kernel.org with ESMTP
	id S264697AbUGHQy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:54:57 -0400
Message-ID: <40ED7C51.90103@246tNt.com>
Date: Thu, 08 Jul 2004 18:54:41 +0200
From: Sylvain Munaut <tnt@246tnt.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] Freescale MPC52xx support for 2.6 - Base part
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Freescale MPC5200 and it's LITE5200 platform.
Only basic boot support is included here.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>


The complete patch set is composed of two parts parts : 
 - [1/2] The base/core part ( include/asm-ppc & arch/ppc )
 - [2/2] The serial driver part ( include/linux & driver/serial )
They have to be applied in order.



Due to the size of the patch (>80k), it's not inlined or attached. It's available from either :

 - bksend generated patch : http://www.246tNt.com/linux-2.5-mpc52xx-pending-main.bksend
 - diff -urN style patch  : http://www.246tNt.com/linux-2.5-mpc52xx-pending-main.diff
 - bk tree ( contains both patchs ) : bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending


diffstat is included :

===================================================================


ChangeSet@1.1819, 2004-07-08 16:11:09+02:00, tnt@246tNt-laptop.lan.ayanami.246tNt.com
  Add basic support for the Freescale MPC52xx embedded CPU and the LITE5200 platform.

  Signed-off-by: Sylvain Munaut <tnt@246tNt.com>


 Documentation/powerpc/mpc52xx.txt   |   48 +++
 arch/ppc/Kconfig                    |   28 +-
 arch/ppc/boot/common/misc-common.c  |   10
 arch/ppc/boot/simple/Makefile       |    7
 arch/ppc/boot/simple/mpc52xx_tty.c  |  138 +++++++++++
 arch/ppc/configs/lite5200_defconfig |  436 ++++++++++++++++++++++++++++++++++++
 arch/ppc/kernel/cputable.c          |    4
 arch/ppc/platforms/Makefile         |    1
 arch/ppc/platforms/lite5200.c       |  152 ++++++++++++
 arch/ppc/platforms/lite5200.h       |   23 +
 arch/ppc/platforms/mpc5200.c        |   29 ++
 arch/ppc/syslib/Makefile            |    1
 arch/ppc/syslib/mpc52xx_pic.c       |  252 ++++++++++++++++++++
 arch/ppc/syslib/mpc52xx_setup.c     |  228 ++++++++++++++++++
 include/asm-ppc/mpc52xx.h           |  380 +++++++++++++++++++++++++++++++
 include/asm-ppc/mpc52xx_psc.h       |  191 +++++++++++++++
 include/asm-ppc/ocp_ids.h           |    1
 include/asm-ppc/ppcboot.h           |    7
 18 files changed, 1921 insertions(+), 15 deletions(-)

