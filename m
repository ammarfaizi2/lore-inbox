Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314487AbSDRXEX>; Thu, 18 Apr 2002 19:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314486AbSDRXEW>; Thu, 18 Apr 2002 19:04:22 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:29624 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S314489AbSDRXEV>; Thu, 18 Apr 2002 19:04:21 -0400
Date: Thu, 18 Apr 2002 19:04:20 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: COM1 became ttyS01 in 2.4.19-pre7
Message-ID: <Pine.LNX.4.44.0204181855430.21502-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The serial ports have changed their names after upgrading from 2.4.19-pre4
to 2.4.19-pre7.  What used to be /dev/ttyS0 is /dev/ttyS1 now.

This is from the kernel log:

Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS01 at 0x03f8 (irq = 4) is a 16550A
ttyS02 at 0x02f8 (irq = 3) is a 16550A

$ ls -l /dev/tts/
total 0
crw-rw-rw-    1 root     root       4,  65 Apr 18 18:50 1
crw-rw-rw-    1 root     root       4,  66 Dec 31  1969 2

I'm using AMD K7, SMP is disabled, serial ports are enabled, ACPI is
disabled, APM is enabled, devfs is enabled and used, CONFIG_SERIAL_CONSOLE
is enabled but not currently used.  The motherboard is AOpen KT-133.  The
ports are set in BIOS to standard COM1 and COM2 settings.

I'm ready to provide more information if needed.

-- 
Regards,
Pavel Roskin

