Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTAAXBc>; Wed, 1 Jan 2003 18:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTAAXBc>; Wed, 1 Jan 2003 18:01:32 -0500
Received: from smtp2.sooninternet.net ([212.246.17.84]:6046 "EHLO
	smtp2.sooninternet.net") by vger.kernel.org with ESMTP
	id <S265169AbTAAXBb>; Wed, 1 Jan 2003 18:01:31 -0500
Date: Thu, 2 Jan 2003 01:09:42 +0200
From: Kari Hameenaho <khaho@koti.soon.fi>
To: linux-kernel@vger.kernel.org
Cc: system_lists@nullzone.org
Subject: Re: Highpoint HPT370 not working in 2.4.18+ versions
Message-Id: <20030102010942.357248fc.khaho@koti.soon.fi>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

system_lists@nullzone.org wrote:

>* BOOTing using 2.4.20 (or 2.4.21-pre2)
>--------------------
>...
>Linux agpgart interface v0.99 (c) Jeff Hartmann
>agpgart: Maximum main memory to use for agp memory: 96M
>agpgart: Detected Via Apollo Pro chipset
>agpgart: AGP aperture is 64M @ 0xd8000000
>Highpoint HPT370 Softwareraid driver for linux version ...
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP Protocols: ICMP, UDP, TCP
>...
>
>You can notice how the driver for HPT is loaded but nothing is found.
>OF COURSE hde hdf etc is NOT found .. (at the begining of the boot).

Maybe you have selected only RAID part of HPT370 in your kernel config, 
not the driver part at all.

RAID part in menuconfig (this seems to be on): 
<*> Support for IDE Raid controllers (EXPERIMENTAL)
  ...
  <*>    Highpoint 370 software RAID (EXPERIMENTAL)

But you also need the driver, as in menuconfig (this seems to be off):
[*]     HPT366/368/370 chipset support

Maybe the RAID part should not be selectable without the driver,
but when making own kernels you should know about many options
anyway.

---
Kari Hämeenaho

