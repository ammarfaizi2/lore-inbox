Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSHBOll>; Fri, 2 Aug 2002 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSHBOll>; Fri, 2 Aug 2002 10:41:41 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:38367 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S314634AbSHBOll>; Fri, 2 Aug 2002 10:41:41 -0400
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@redhat.com>
Subject: Booting problem, 2.4.19-rc5-ac1, ali15x3
References: <9cfu1mp5kru.fsf@rogue.ncsl.nist.gov>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 02 Aug 2002 10:45:10 -0400
In-Reply-To: <9cfu1mp5kru.fsf@rogue.ncsl.nist.gov>
Message-ID: <9cfd6t1nwuh.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

2.4.19-rc5-ac1 hangs on boot on my laptop (Fujitsu P-series, TM5800
CPU), whereas plain[1] rc5 boots fine.  The hang appears to be during IDE
detection:

...
block: 704 slots per queue, batch=176
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=XX
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later

With rc5, I get this same error unless I have 'ide0=ata66 ide1=ata66'
on the kernel command line.  However, -ac1 hangs with or without these
options.

I had this same problem under rc3-ac1, and rc2-ac2 (last two -ac
kernels I tried), so this looks to be a long-term problem.  I'm hoping
maybe I can help debug it before it gets into Marcelo's tree.

ian

[1] Actually, one one-liner patche to extend the ext3 journal
commit interval to 30 seconds.
