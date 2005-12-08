Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVLHSnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVLHSnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbVLHSnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 13:43:11 -0500
Received: from ns1.heckrath.net ([213.239.205.18]:8074 "EHLO mail.heckrath.net")
	by vger.kernel.org with ESMTP id S932195AbVLHSnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 13:43:10 -0500
Date: Thu, 8 Dec 2005 19:44:08 +0100
From: Sebastian =?ISO-8859-15?Q?K=E4rgel?= <mailing@wodkahexe.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.{14,15-rc4} harddrive cache not detected
Message-Id: <20051208194408.77e17f64.mailing@wodkahexe.de>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

after installing a new harddrive, the kernel does no longer detect the
harddrives cache.

Old one:
ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
hda: ST94019A, ATA DISK drive
hda: 78140160 sectors (40007 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA
(33)

New one:
ide0: BM-DMA at 0x1100-0x1107, BIOS settings: hda:DMA, hdb:pio
hda: TOSHIBA MK4025GAS, ATA DISK drive
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(33)

Note, that there is nothing printed about the cache size.
According to the manufactor the new harddrive should have 8mb cache.
/proc/ide/ide0/hda/cache also show "0"

hdparm gives the following:
...
BuffType=unknown, BuffSize=0kB
...

I verified this problem with 2.6.14 and 2.6.15-rc4.

Thanks for your help,
Sebastian
