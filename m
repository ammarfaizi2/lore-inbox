Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTGVClJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 22:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTGVClJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 22:41:09 -0400
Received: from www.opensource-ca.org ([168.234.203.30]:11989 "EHLO
	guug.galileo.edu") by vger.kernel.org with ESMTP id S262499AbTGVClF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 22:41:05 -0400
Date: Mon, 21 Jul 2003 20:51:42 -0600
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030722025142.GC25561@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ppl,

just reporting on 2.6.0-test1 on sparcs:

i am trying to compile linux-2.6.0-test1-{mm1,mm2,ac1,ac2)
on 2 differents sparcs, both latest debian sid & gcc-3.2.3:

ultra enterprise 1 (sun4u sparc64)
sparc station 4    (sun4m sparc32)

on both i need to enable PCI support even
when these boxes doesn't have a PCI bus,
i think the main bus is SBUS and i get
errors when compiling the Sun ESP scsi
controller about functions for DMA depending
on PCI.  I don't think is convenient for
these old boxes having support for PCI
because enlarge the kernel and it really
doesn't have that type of bus.

And when i enable PCI support the sparc32
compiles fine but hangs inmediately on boot.
The sparc64 doesn't compile with ac2 patch:

arch/sparc64/kernel/built-in.o(.init.text+0x3bcc): In function `pdev_cookie_fillin':
: referencia a `pci_remove_bus_device' sin definir
make: *** [vmlinux] Error 1

The others mentioned kernels hangs when booting.

Yes, i have selected proper configuration for the
CONFIG_INPUT_*=y layer, CONFIG_VT_CONSOLE=y,
CONFIG_HW_CONSOLE=y and CONFIG_PROM_CONSOLE=y.

I even tried both CONFIG_FRAMEBUFFER_CONSOLE set to y/n

Any help will be apreciated as i really want
the 2.6 kernels support both sparc32 and sparc64
boxes, googling i found osinvestor.com/sparc but
is down and in the sparclinux archives there are
patches but they appear to be applied on linus
2.6.0-test1 kernel.

Thanks.

-solca

