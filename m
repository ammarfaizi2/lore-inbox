Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTBGRWd>; Fri, 7 Feb 2003 12:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbTBGRWd>; Fri, 7 Feb 2003 12:22:33 -0500
Received: from rzcomm5.rz.tu-bs.de ([134.169.9.40]:37127 "EHLO
	rzcomm5.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id <S266308AbTBGRWc>; Fri, 7 Feb 2003 12:22:32 -0500
Date: Fri, 7 Feb 2003 18:32:10 +0100
From: Torsten Wolf <t.wolf@tu-bs.de>
To: linux-kernel@vger.kernel.org
Subject: CD-Writing and DMA problems with KT266A and 2.4.16-20
Message-ID: <20030207173210.GA11196@b147>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Mailer: Mutt http://www.mutt.org/
Organization: TU Braunschweig
X-Editor: Vim http://www.vim.org/
X-OpenPGP-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xEE27B69C
X-Fingerprint: 24EE 9FD9 5333 0206 541F  4602 C6A4 5F61 EE27 B69C
X-Uptime: 17:41:34 up  5:18,  8 users,  load average: 0.11, 0.13, 0.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

at present, I have an Epox 8KHA+ with VIA's KT266A chipset (VT8367,
VT8233) with 3 harddrives (hda,b,c) and a Teac IDE CD-RW (hdd) attached.
DMA ist activated on all devices via hdparm at boottime. Ripping a CD
eats half of the CPU (Athlon XP1600+), but as I have heard so far, this
is "normal", at least for 2.4.x. Unfortunately, the ide-akpm-patch gave
no improvement. What really makes me wonder is the following:

As soon as I enable CONFIG_BLK_DEV_VIA82CXXX and try to burn data
residing on hdc onto CD, I get the following messages:

hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
[...]
hdd: DMA disabled
hdd: drive not ready for command
hdd: ATAPI reset complete

Thus, burning fails. After removing the support for the chipset writing
to the CD is no problem, no matter which source is used. hdparm shows
DMA activated before and after the write process.

This happens with versions at least from 2.4.16 up to 2.4.20. Could you
please give me a hint, whether I'm doing something terribly wrong. Is
this yet another proof, that VIA-Hardware is under certain circumstances
somewhat... flaky?

Best wishes
Torsten
