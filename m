Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWGMSBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWGMSBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWGMSBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:01:11 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:12226 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964786AbWGMSBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:01:10 -0400
Date: Thu, 13 Jul 2006 20:00:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: pcmcia IDE broken in 2.6.18-rc1
In-Reply-To: <20060708094746.943d8926.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0607131953410.10286@yvahk01.tjqt.qr>
References: <20060708145541.GA2079@elf.ucw.cz> <20060708094746.943d8926.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-187468061-1152813613=:10286"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-187468061-1152813613=:10286
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>> When I insert the card, I get
>> 
>> pccard: PCMCIA card inserted into slot 0
>> cs: memory probe 0xe8000000-0xefffffff: excluding
>> 0xe8000000-0xefffffff
>> cs: memory probe 0xc0200000-0xcfffffff: excluding
>> 0xc0200000-0xc11fffff 0xc1a00000-0xc61fffff 0xc6a00000-0xc71fffff
>> 0xc7a00000-0xc81fffff 0xc8a00000-0xc91fffff 0xc9a00000-0xca1fffff
>> 0xcaa00000-0xcb1fffff 0xcba00000-0xcc1fffff 0xcca00000-0xcd1fffff
>> 0xcda00000-0xce1fffff 0xcea00000-0xcf1fffff 0xcfa00000-0xd01fffff
>> pcmcia: registering new device pcmcia0.0
>> PM: Adding info for pcmcia:0.0
>> ide2: I/O resource 0xF887E00E-0xF887E00E not free.
>> ide2: ports already in use, skipping probe
>> ide2: I/O resource 0xF887E01E-0xF887E01E not free.
>> ide2: ports already in use, skipping probe
>> ...
>> 
>> it ends with
>> 
>> ide-cs: ide_register() at 0xf999c000 & 0xf999c00e, irq 7 failed
>> 
>> :-(. Back to 2.6.17 once again, I'm afraid...
>
>Appears to be the same bug as http://lkml.org/lkml/2006/6/15/155

As I am one of the probably few people who have some PCMCIA-IDE-drive (Sony 
PCGA-CD51/A), running 2.6.18-rc1 gives me no problems.

pccard: PCMCIA card inserted into slot 0
kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
Probind IDE interface ide2...
hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI CD/DVD-ROM drive
ide2 at 0x180-0x198,0x386 on irq 3
ide-cs: hde: Vpp = 0.0
pcmcia: Detected deprecated PCMCIA ioctl usage from process: hald

Seems fine. I can mount and read it w/o problems.

$ rpm -q pcmciautils
pcmciautils-012-11 (SUSE Linux 10.1)

CONFIG_ISA=y
# CONFIG_RESOURCES_64BIT is not set

Just 2¢, ask for more if needed :)


Jan Engelhardt
-- 
--1283855629-187468061-1152813613=:10286--
