Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274156AbRISUCp>; Wed, 19 Sep 2001 16:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274157AbRISUC2>; Wed, 19 Sep 2001 16:02:28 -0400
Received: from hera.society.de ([195.227.57.7]:19977 "EHLO hera.society.de")
	by vger.kernel.org with ESMTP id <S274156AbRISUCE>;
	Wed, 19 Sep 2001 16:02:04 -0400
Date: Wed, 19 Sep 2001 22:02:42 +0200
From: Bernfried Molte <bbm@studioorange.de>
To: linux-kernel@vger.kernel.org
Subject: RTL8139too in linux-2.4.10-pre12
Message-Id: <20010919220242.5d310810.bbm@studioorange.de>
Organization: Studioorange
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i get this message with CONFIG_8139TOO_PIO *not* set:

Sep 19 21:39:43 lichee kernel: Symbols match kernel version 2.4.10.
Sep 19 21:39:43 lichee kernel: Loaded 4 symbols from 1 module.
Sep 19 21:39:43 lichee kernel: 8139too Fast Ethernet driver 0.9.18a
Sep 19 21:39:43 lichee kernel: eth0: RealTek RTL8139 Fast Ethernet at 0xd0826000, 00:e0:7d:7c:f8:d8, IRQ 11
Sep 19 21:39:43 lichee kernel: eth0:  Identified 8139 chip type 'RTL-8139B'
Sep 19 21:39:43 lichee kernel: eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability 45e1.

Sep 19 21:39:43 lichee kernel: task `ifconfig' exit_signal 17 in reparent_to_init

******

This message comes with CONFIG_8139TOO_PIO set:

Sep 19 14:44:25 lichee kernel: Assertion failed! ioaddr != NULL,8139too.c,rtl8139_init_one,line=944
Sep 19 17:27:17 lichee kernel: Assertion failed! ioaddr != NULL,8139too.c,rtl8139_init_one,line=944
Sep 19 17:33:17 lichee kernel: Assertion failed! ioaddr != NULL,8139too.c,rtl8139_init_one,line=944

This kernel is patched with 'patch-rml-2.4.10-pre12.patch'.

Cheers,
   Bernfried
