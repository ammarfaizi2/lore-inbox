Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283655AbRLYK43>; Tue, 25 Dec 2001 05:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283694AbRLYK4U>; Tue, 25 Dec 2001 05:56:20 -0500
Received: from 217-125-101-55.uc.nombres.ttd.es ([217.125.101.55]:53447 "EHLO
	jep.dhis.org") by vger.kernel.org with ESMTP id <S283655AbRLYK4H>;
	Tue, 25 Dec 2001 05:56:07 -0500
Message-ID: <3C285B40.91A83EC7@jep.dhis.org>
Date: Tue, 25 Dec 2001 11:56:00 +0100
From: Josep Lladonosa i Capell <jep@jep.net.dhis.org>
Reply-To: jlladono@pie.xtec.es
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre5 i686)
X-Accept-Language: ca, en, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.x kernels, big ide disks and old bios
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the problem is this:

bios only supports disks up to 32 Gb.

hard disk is 60 Gb.

kernel is 2.4.17

hard disk reports its correct size when reading parameters from the
disk, not from the bios

verd:/proc/ide/hdc# cat geometry
physical     65530/16/63
logical      119150/16/63


when booting (dmesg):

hdc: IC35L060AVER07-0, ATA DISK drive
hdc: 66055247 sectors (33820 MB) w/1916KiB Cache, CHS=119150/16/63,
UDMA(33)


Linux adopts the 'false' geometry (65530/16/63) ) to bypass the bios
boot.



I know that there are patches for 2.2 kernels and 2.3 kernels, so as
linux adopts the logical geometry (a kiddy trick with lba size). They
are very simple (a line), but 2.4 ide implementation is (a little more)
complicated. Any patch?

Bon Nadal - Merry Christmas

--
Salutacions...Josep
http://www.geocities.com/SiliconValley/Horizon/1065/
--



