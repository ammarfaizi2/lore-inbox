Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264255AbTCXPlu>; Mon, 24 Mar 2003 10:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264256AbTCXPlu>; Mon, 24 Mar 2003 10:41:50 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.28]:14214 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264255AbTCXPlt>; Mon, 24 Mar 2003 10:41:49 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: rmk@arm.linux.org.uk
Subject: drivers/serial/Makefile
Date: Mon, 24 Mar 2003 16:52:50 +0100
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Spang Oliver <oliver.spang@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303241652.50213.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial driver is now compiled as "8250", rather than
the traditional "serial" (Kconfig says "serial" as well).
Assuming this was a mistake in the Makefile, I went and
had a look, but my brain exploded.  What exactly is this
intended to do?

All the best,

"Confused"

PS: 8250_gsc, 8250_pci can be compiled as modules in their
own right.

#
# Makefile for the kernel serial device drivers.
#
#  $Id: Makefile,v 1.8 2002/07/21 21:32:30 rmk Exp $
#

serial-8250-y :=
serial-8250-$(CONFIG_GSC) += 8250_gsc.o
serial-8250-$(CONFIG_PCI) += 8250_pci.o
serial-8250-$(CONFIG_PNP) += 8250_pnp.o
obj-$(CONFIG_SERIAL_CORE) += core.o
obj-$(CONFIG_SERIAL_21285) += 21285.o
obj-$(CONFIG_SERIAL_8250) += 8250.o $(serial-8250-y)
obj-$(CONFIG_SERIAL_8250_CS) += 8250_cs.o
obj-$(CONFIG_SERIAL_8250_ACORN) += 8250_acorn.o
obj-$(CONFIG_SERIAL_ANAKIN) += anakin.o
obj-$(CONFIG_SERIAL_AMBA) += amba.o
obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
obj-$(CONFIG_SERIAL_UART00) += uart00.o
obj-$(CONFIG_SERIAL_SUNCORE) += suncore.o
obj-$(CONFIG_SERIAL_SUNZILOG) += sunzilog.o
obj-$(CONFIG_SERIAL_SUNSU) += sunsu.o
obj-$(CONFIG_SERIAL_SUNSAB) += sunsab.o
obj-$(CONFIG_SERIAL_MUX) += mux.o
obj-$(CONFIG_SERIAL_68328) += 68328serial.o
obj-$(CONFIG_SERIAL_68360) += 68360serial.o
obj-$(CONFIG_SERIAL_COLDFIRE) += mcfserial.o
obj-$(CONFIG_V850E_NB85E_UART) += nb85e_uart.o
