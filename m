Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbULHLg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbULHLg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 06:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbULHLg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 06:36:29 -0500
Received: from mail.broadpark.no ([217.13.4.2]:40648 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S261190AbULHLgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 06:36:23 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <62697744-490D-11D9-90F0-000D932A43BC@karlsbakk.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: DMA problems with ICH5 in ATA mode
Date: Wed, 8 Dec 2004 12:36:21 +0100
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I have a disk connected to one of the below controllers in ATA mode, 
but I can't enable DMA on it. Intel ATA support is in kernel, but when 
hdparm -d1 /dev/hdc I get the following (extracted from strace)

write(4, " HDIO_SET_DMA failed: Operation "..., 46 HDIO_SET_DMA failed: 
Operation not permitted

lspci -vvvvvv gave this

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: Micro-Star International Co., Ltd.: Unknown device 
7650
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 0
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at fc00 [size=16]


please cc: to me as I'm not on the list

roy

