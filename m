Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSIHVrR>; Sun, 8 Sep 2002 17:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSIHVrR>; Sun, 8 Sep 2002 17:47:17 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:55502
	"EHLO awak") by vger.kernel.org with ESMTP id <S315279AbSIHVrR>;
	Sun, 8 Sep 2002 17:47:17 -0400
Subject: 2.4.19: nosmp=1 => hde: lost interrupt
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Sep 2002 23:51:58 +0200
Message-Id: <1031521918.702.4.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a VIA VP6 (Apollo Pro133x) dual-pIII (hde is on a HPT370), using 2.4.19-rc1-ac1 or
2.4.20-pre5, if I boot using "nosmp=1", I have

hde: lost interrupt
(followed by a system stall for a few seconds)

each time hde is accessed (starting with partition table read). When
hde7 is mounted, I see a never-ending series of:

hde: 0 bytes in FIFO
ide_dmaprobe: chipset supported ide_dma_lostirq func only: 13
hde: lost interrupt

The boot takes forever (I didn't even try to boot completely). This
doesn't happen when booting normally.
nosmp=1 noacpi=1 doesn't help.

	Xav

