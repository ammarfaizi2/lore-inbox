Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTFJHqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 03:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFJHqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 03:46:44 -0400
Received: from ugp.viaduk.net ([212.68.162.134]:63427 "EHLO ugp.viaduk.net")
	by vger.kernel.org with ESMTP id S262429AbTFJHqn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 03:46:43 -0400
From: =?koi8-r?b?68/O09TBztTJziDk1c7Bxdc=?= <kostya.nipi@naftogaz.net>
To: axboe@suse.de, andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: ide driver in 2.4.20 discards DMA on my CD-ROM
Date: Tue, 10 Jun 2003 11:01:23 +0300
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200306101101.23587.kostya.nipi@naftogaz.net>
X-MIMETrack: Itemize by SMTP Server on Lotus/Nipi(Release 5.0.9 |November 16, 2001) at
 10.06.2003 11:02:45,
	Serialize by Router on Lotus/Nipi(Release 5.0.9 |November 16, 2001) at 10.06.2003
 11:02:59,
	Serialize complete at 10.06.2003 11:02:59
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
  charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I have recently compiled kernel 2.4.20 and my Liteon 222 CD-ROM drive
doesn't work stable with this kernel. Problem is that in older kernels 
(2.2.13, 2.2.15, 2.4.2, 2.4.18, 2.4.19) it works only when DMA is enabled 
(hdparm -d1).

In PIO mode it produces a lot of messages "hdX: lost interrupt" (i have tried 
on /dev/hdb and /dev/hdc )and hangs sometimes when reading files >1 MB.

echo file_readahead:512000 >/proc/ide/hdX/settings
echo max_kb_per_request:120 >/proc/ide/hdX/settings

helps a little(doesn't hang, but some data was broken). The figures are 
empyrical.

In DMA mode it has worked well up to 2.4.19. No hangs, no data loss.

With 2.4.20 produces message "DMA interrupt recovery, hdx:lost interrupt" and
discards DMA mode on mount and each time, when I try to enable DMA and read 
something from CD.

gcc, that was used to compile :gcc-3.2 
(2.4.18 & 2.4.19 were compiled with it too)

IDE: PIIX3 (430VX motherboard)
CD-ROM: Liteon LTN222A

kernel 2.4.20, that I have compiled by gcc-3.2 on some other computer with 
other CD-ROM drive works well and DMA works with that drive

Help me, please!
Sorry for bad English

Best regards
Mr. Constantin Dunayev, Ukraine
mailto: kostya.nipi@naftogaz.net
