Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTD3TQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTD3TQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:16:35 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:27151 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262341AbTD3TQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:16:32 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.5.68-mm3
Date: Wed, 30 Apr 2003 19:28:51 +0000 (UTC)
Organization: Cistron
Message-ID: <b8p85j$rq0$1@news.cistron.nl>
References: <20030429235959.3064d579.akpm@digeo.com>
X-Trace: ncc1701.cistron.net 1051730931 28480 62.216.30.38 (30 Apr 2003 19:28:51 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton  <akpm@digeo.com> wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm3/

On my laptop it doesn't compile with bluetooth enabled:

/usr/bin/make -f scripts/Makefile.build obj=drivers/bluetooth
  gcc -Wp,-MD,drivers/bluetooth/.hci_usb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=hci_usb -DKBUILD_MODNAME=hci_usb -c -o drivers/bluetooth/.tmp_hci_usb.o drivers/bluetooth/hci_usb.c
drivers/bluetooth/hci_usb.c: In function `hci_usb_send_bulk':
drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET' undeclared (first use in this function)
drivers/bluetooth/hci_usb.c:461: (Each undeclared identifier is reported only once
drivers/bluetooth/hci_usb.c:461: for each function it appears in.)
make[3]: *** [drivers/bluetooth/hci_usb.o] Error 1
make[2]: *** [drivers/bluetooth] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/extra/usr.src/linux-2.5.68-mm3'

I found another thread regarding hci_usb and am not sure
if this is related/same.

Danny
-- 
Miguel   | "I can't tell if I have worked all my life or if
de Icaza |  I have never worked a single day of my life,"

