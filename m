Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTIIS4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTIIS4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:56:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22542 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264312AbTIIS4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:56:17 -0400
Date: Tue, 9 Sep 2003 19:56:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Serial updates
Message-ID: <20030909195614.I4216@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a set of serial updates I'm planning to send to Linus shortly.
You can get a patch from the following URL:

	http://patches.arm.linux.org.uk/serial-20030909.diff

 drivers/serial/8250_cs.c     |  712 ------------
 drivers/serial/core.c        | 2432 -------------------------------------------
 drivers/serial/8250.c        |   24 
 drivers/serial/8250.h        |    4 
 drivers/serial/8250_pci.c    |   22 
 drivers/serial/Kconfig       |   32 
 drivers/serial/Makefile      |    4 
 drivers/serial/clps711x.c    |   12 
 drivers/serial/sa1100.c      |    8 
 drivers/serial/serial_core.c | 2420 ++++++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_cs.c   |  712 ++++++++++++
 include/linux/serial_core.h  |   10 
 12 files changed, 3198 insertions(+), 3194 deletions(-)

<rmk@flint.arm.linux.org.uk> (03/09/09 1.1243)
	[SERIAL] Introduce per-port capabilities.
	
	This allows us to maintain quirks or capabilities on a per-port basis,
	so we can handle buggy clones more effectively.

<rmk@flint.arm.linux.org.uk> (03/09/09 1.1242)
	[SERIAL] Fix another missing irqreturn_t (clps711x.c)

<rmk@flint.arm.linux.org.uk> (03/09/09 1.1241)
	[SERIAL] Convert serial config deps to select statements
	
	The dependencies for CONFIG_SERIAL_CORE / CONFIG_SERIAL_CORE_CONSOLE
	were becoming very messy.  This cset converts the dependencies to
	use "select" statements instead.

<rmk@flint.arm.linux.org.uk> (03/09/09 1.1240)
	[SERIAL] Drop "level" argument from serial PM calls.
	
	Since the driver model has transitioned away from using multi-level
	device suspend/resume, we also drop the multi-level support from
	the serial layer.
	
	Update the 8250 and sa1100 drivers for this change.

<rmk@flint.arm.linux.org.uk> (03/08/27 1.1153.59.2)
	[SERIAL] Rename core.o and 8250_cs.o
	
	core.ko is a bad name for a module - make it serial_core.ko
	8250_cs.ko continues to cause people compatibility problems with
	older kernels, so rename that back to serial_cs.ko

<rmk@flint.arm.linux.org.uk> (03/08/24 1.1123.33.1)
	[SERIAL] Add new port numbers.
	
	This adds the new port numbers which are in use in MAC and PARISC
	trees (so other people know they're taken.)


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
