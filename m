Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTJNScv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTJNScv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:32:51 -0400
Received: from [62.12.146.226] ([62.12.146.226]:46610 "EHLO server6.fpw.ch")
	by vger.kernel.org with ESMTP id S262747AbTJNScp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:32:45 -0400
Subject: 2.6.0-test7 on Asus M3N, PCMCIA problem
From: Alexey Goldin <ab_goldin@swissmail.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066156364.13247.15.camel@hobbit>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 14 Oct 2003 11:32:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried the latest new and shining 2.6.0-test7 on my new and shining
carbonlinux.com Asus M3N. Mostly works Ok,except for a few small
problems. The most annoying is PCMCIA: it does not work.

Here is a snip from dmesg +- few lines:

--------------------------------------------------------
Freeing unused kernel memory: 136k freed
Adding 1959888k swap on /dev/hda1.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:01:05.0 [1043:1744]
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
Yenta: ISA IRQ list 0000, PCI irq5
Socket status: 5fc5ccc7
PCMCIA: socket f7c9b82c: time out after reset.
PCMCIA: socket f7c9b82c: *** DANGER *** unable to remove socket power
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
---------------------------------------------------------

A snip from /proc/config.gz:
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y
                                                                                
#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_I82092=m
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
                                                                                
#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
                                                                                
#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
----------------------------------------------

The same problem was present in 2.6.0-test6. This is debian testing,
vanilla source from kernel.org. ACPI is enabled. Please tell me where to
dig deeper for a problem. Thank you!
                                                                                

2.4.21 hangs keyboard for few second each time ACPI detects that CPU
temperature gets close to 55C trip point, in 2.4.22 keyboard does not 
work in X if Synaptic touchpad is activated. PCMCIA works fine in 2.4.21
and 2.4.22.  pcmcia-cs tools version is  3.2.2-1.3.



P.S. I am not subscribed to the list, but it is not necessary to CC: me
--- I will continue browsing archives.

P.P.S. New xconfig is really cool.

-- 
Alexey Goldin <ab_goldin@swissmail.org>

