Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSGXNNX>; Wed, 24 Jul 2002 09:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSGXNNW>; Wed, 24 Jul 2002 09:13:22 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:55760 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S317110AbSGXNM4>; Wed, 24 Jul 2002 09:12:56 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Boot problem, 2.4.19-rc3-ac1
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 24 Jul 2002 09:16:05 -0400
Message-ID: <9cfu1mp5kru.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

2.4.19-rc3-ac1 hangs on boot on my laptop (Fujitsu P-series, TM5800
CPU), whereas plain[1] rc3 boots fine.  The hang appears to be during IDE
detection:

...
block: 704 slots per queue, batch=176
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=XX
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later

With rc-3, I get this same error unless I have 'ide0=ata66 ide1=ata66'
on the kernel command line.  However, -ac1 hangs with or without these
options.



[1] Actually, two one-liner patches... one to extend the ext3 journal
commit interval to 30 seconds, and another to fix suspend issues in
sound/trident.c.
