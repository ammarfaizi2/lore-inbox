Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbTFRTOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbTFRTOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:14:09 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:64266 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265499AbTFRTOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:14:05 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: parport_pc does not enable DMA by default (both 2.5.72 and 2.4.21)
Date: Wed, 18 Jun 2003 23:26:54 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306182326.54918.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have CUSL2 motherboard (i815e based) that allows to select different 
parallel port modes; for ECP or ECP+EPP I also can choose DMA channel.

Neither 2.4.21 nor 2.5.72 would enable DMA by default. I have (currently ECP 
but the same for ECP_EPP)

parport0: PC-style at 0x378 (0x778), irq 7, using FIFO 
[PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)

and as options

{pts/1}% grep parport /etc/modprobe.conf
options parport_pc irq=auto dma=auto

IRQ is correctly autodeteted and it appears it is also correctly configured in 
BIOS:

{pts/1}% cat /sys/devices/pnp0/00:01/name
ECP printer port
{pts/1}% cat /sys/devices/pnp0/00:01/resources
mode = auto
state = active
io 0x378-0x37f
io 0x778-0x77f
irq 7
dma 3

Is it expected? Any additional info I can provide?

TIA

-andrey
