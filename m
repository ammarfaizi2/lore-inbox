Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTKUWlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTKUWlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 17:41:55 -0500
Received: from ns.tasking.nl ([195.193.207.2]:59915 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S261602AbTKUWlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 17:41:52 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: IDE lockup after floppy access
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <2535.3fbe9484.4f0e6@altium.nl>
Date: Fri, 21 Nov 2003 22:41:08 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After accessing a floppy disk, the kernel blocks on the first harddisk
access. After a couple of seconds, the following messages appear:

  hda: dma_time_expiry: dma status = 0x61
  hda: DMA timeout error

I can only reset at this point. This is reproducible. I'm running
kernel 2.6.0-test9 on an SMP system, but the problem doesn't go away
when I boot with "nosmp". The kernel was built with CONFIG_PREEMPT.
Here are the IDE startup messages:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL CR13.0A, ATA DISK drive
hdb: TOSHIBA CD-ROM XM-6602B, ATAPI CD/DVD-ROM drive

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

