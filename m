Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbVIVI77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbVIVI77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVIVI77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:59:59 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:59849 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965239AbVIVI76 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:59:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gA44Eut7cFsMtJUyTfA/6QaqfoKRNxQHEt9ZMrGvt7NQ2CR/2JmQd4EWvi1LI4GCffOiPRDaftuB/5yf2Dww1EIyGRg+tZvQlEp88pY6jXXOzStC3p/waSfUAxBLo/bxUPOSu5cPXu1qtxsTf+w5pLRx0BydGDvdW0uK4AzsIl0=
Message-ID: <6278d222050922015937890366@mail.gmail.com>
Date: Thu, 22 Sep 2005 09:59:56 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
Reply-To: Daniel J Blueman <daniel.blueman@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [tg3] failing to detect NIC when built statically...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PCI express BCM5751 NIC using the tg3 driver. If I build the
driver statically, it fails to identify the network card - no kernel
log messages or anything. It works as expected when built modular.
Platform is x86_64 running native 64bit code.

# lspci -vvxs 2:0.0
0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5751 Gigabit Ethernet PCI Express (rev 01)
        Subsystem: Broadcom Corporation NetXtreme BCM5751 Gigabit
Ethernet PCI Express
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 201
        Region 0: Memory at d0000000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at 40100000 [disabled] [size=64K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
                Address: d258788c36d7592c  Data: f7f6
        Capabilities: [d0] #10 [0001]
00: e4 14 77 16 06 00 10 00 01 00 00 02 08 00 00 00
10: 04 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 e4 14 77 16
30: 00 00 00 00 48 00 00 00 00 00 00 00 0c 01 00 00

Any ideas? Please CC.
___
Daniel J Blueman
