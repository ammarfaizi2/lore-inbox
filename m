Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274131AbRI3Uc6>; Sun, 30 Sep 2001 16:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274134AbRI3Ucs>; Sun, 30 Sep 2001 16:32:48 -0400
Received: from ns1.austin.rr.com ([24.93.35.63]:24074 "EHLO ns2.austin.rr.com")
	by vger.kernel.org with ESMTP id <S274131AbRI3Ucj>;
	Sun, 30 Sep 2001 16:32:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: linux-kernel@vger.kernel.org
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset 
Date: Sun, 30 Sep 2001 15:37:16 -0500
X-Mailer: KMail [version 1.2]
Cc: timm@fnal.gov
MIME-Version: 1.0
Message-Id: <01093015371606.00965@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The error :

Curious - OSB4 thinks the DMA is still running.
OSB4 wait exit

appears to occur during the "rewrite" phase of Bonnie++ every time we run it.
The setup is a Tyan 2515 with a Seagate ST310211A drive. Bonnie ran for ~48 
hours on 2.4.10 without slowdown (I assume this is because the extra check in 
-ac isn't present) but there was some file system corruption after the 1st 24 
hours:

EXT2-fs error (device ide0(3,6)): ext2_free_blocks: Freeing blocks not in 
datazone - block = 2138996092, count = 1

Here's the lspci:

00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
	Flags: bus master, medium devsel, latency 32

00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
	Flags: bus master, medium devsel, latency 16

[snip]

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
	Subsystem: ServerWorks OSB4
	Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master 
SecP PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at ffa0 [size=16]


-- 
Marvin Justice
Software Developer
BOXX Technologies, Inc.
www.boxxtech.com
512-235-6318 (V)
412-835-0434 (F)
