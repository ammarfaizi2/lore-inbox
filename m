Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSIAAD6>; Sat, 31 Aug 2002 20:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSIAAD6>; Sat, 31 Aug 2002 20:03:58 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:62994 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S317341AbSIAAD5>; Sat, 31 Aug 2002 20:03:57 -0400
Date: Sat, 31 Aug 2002 19:07:34 -0500 (CDT)
Message-Id: <200209010007.g8107Yt38476@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org
To: Terry Barnaby <terry@beam.ltd.uk>
Subject: Re: Linux kernel lockup with BVM SCSI controller on MCPN765 PPC board
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To=<3D6F4A3A.50806@beam.ltd.uk>

We have been using the sym63c8xx_2 driver in 2.5 since it came out with
1010-66 chips using ppc64 kernels and haven't seen problems (its the
standard scsi controller in the IBM p690).   We use the driver in 32 bit
addressing mode (CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE 0) because we
only use 32 bit addresses with our IO translations.  (Error recovery was
broken until recently in 2.5 because of the locking changes, but you got
a printk there, it was just a software deadlock).

You said you appeared to be serial_console_write, I guess this is from
some kind of JTAG or BDM tool?   Can you find the string that its trying
to print?   Sounds like your pci bus may be hanging, have you tried to
probe there?

milton
