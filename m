Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUFQPww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUFQPww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266559AbUFQPwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:52:51 -0400
Received: from omr4.netsolmail.com ([216.168.230.140]:30892 "EHLO
	omr4.netsolmail.com") by vger.kernel.org with ESMTP id S266566AbUFQPwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:52:14 -0400
Message-ID: <40D1BE1C.2010507@vzavenue.net>
Date: Thu, 17 Jun 2004 11:51:56 -0400
From: Vincent van de Camp <vncnt@vzavenue.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.6/7: sym0:0:0:M_REJECT to send for : 1-2-3-1. in syslog
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a pretty old but still very usable machine using a Symbios Logic 
53c810 SCSI card that started spewing out these messages in kernel 2.6.6:

Jun 17 11:36:21 localhost kernel: sym0:0:0:M_REJECT to send for : 1-2-3-1.
Jun 17 11:36:52 localhost last message repeated 159 times
Jun 17 11:36:59 localhost last message repeated 11 times

Over and over again. 2.6.5 didn't do this. I hoped 2.6.7 would fix it, 
but apparently it doesn't. Information on the card:

00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 11)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b400 [size=256]
        Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=256]

it's configered in .config as:

CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set

Does anyone have pointers to stop this?

TIA,
Vincent
