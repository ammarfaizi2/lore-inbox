Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUGHQzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUGHQzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUGHQzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:55:46 -0400
Received: from neptune.fsa.ucl.ac.be ([130.104.233.21]:34443 "EHLO
	neptune.fsa.ucl.ac.be") by vger.kernel.org with ESMTP
	id S264723AbUGHQzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:55:41 -0400
Message-ID: <40ED7C72.2090701@246tNt.com>
Date: Thu, 08 Jul 2004 18:55:14 +0200
From: Sylvain Munaut <tnt@246tnt.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 2/2] Freescale MPC52xx support for 2.6 - Serial part
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the PSCs of the Freescale MPC5200 to be used as UARTs.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>


The complete patch set is composed of two parts parts : 
 - [1/2] The base/core part ( include/asm-ppc & arch/ppc )
 - [2/2] The serial driver part ( include/linux & driver/serial )
They have to be applied in order.



Due to the size of the patch, it's not inlined or attached. It's available from either :

 - bksend generated patch : http://www.246tNt.com/linux-2.5-mpc52xx-pending-serial.bksend
 - diff -urN style patch  : http://www.246tNt.com/linux-2.5-mpc52xx-pending-serial.diff
 - bk tree ( contains both patchs ) : bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending


diffstat is included :

===================================================================


ChangeSet@1.1820, 2004-07-08 16:18:02+02:00, tnt@246tNt-laptop.lan.ayanami.246tNt.com
  Add support for MPC52xx PSCs.

  Can be used as serial port and console. Compliant with the OCP driver model.

  Signed-off-by: Sylvain Munaut <tnt@246tNt.com>


 drivers/serial/Kconfig        |   27 +
 drivers/serial/Makefile       |    1
 drivers/serial/mpc52xx_uart.c |  869 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_core.h   |    3
 4 files changed, 900 insertions(+)


