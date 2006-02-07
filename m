Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWBGInv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWBGInv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 03:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWBGInv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 03:43:51 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:46857 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S932456AbWBGInu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 03:43:50 -0500
From: Meelis Roos <mroos@linux.ee>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139244412.10437.32.camel@localhost.localdomain>
User-Agent: tin/1.8.0-20051224 ("Ronay") (UNIX) (Linux/2.6.16-rc2-g5b7b644c-dirty (i686))
Message-Id: <20060207084347.54CD01430C@rhn.tartu-labor>
Date: Tue,  7 Feb 2006 10:43:47 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried in Qemu with virtual PIIX3. Compiled in PIIX, OLDPIIX, MPIIX and
Generic. Enabled PATA support for libata in libata.h. Disabled
everything in ATA/IDE Kconfig menu.

ata1: PATA max PIO4 cmd 0x1F0 ctl 0x3F6 bmdma 0x0 irq 15
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00000246   (2.6.16-rc2-PATA)
EIP is at 0x0
eax: c1268280   ebx: c12a88e0   ecx: c1268280   edx: c02fd2e0
esi: 0000003c   edi: 00000001   ebp: c02ba272   esp: c1150cfc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1150000 task=c114fa30)
Stack: <0>c0232b6c fc000000 c1150d9c 00000000 00000001 00000000 00000000 c12a88e0
       c1268280 0000011a 00008000 c12ceb40 c1266408 c016cafb c12ceba0 c1266404
       c12a88e0 0000003c c1266430 c12cf340 00000000 ffffffff c01bd61a ffffffff
Call Trace:
 [<c0232b6c>] ata_device_add+0x34c/0xb00
 [<c016cafb>] create_proc_entry+0x5b/0xd0
 [<c01bd61a>] pci_get_subsys+0x6a/0xf0
 [<c03478d5>] legacy_init+0x1d5/0x3b0
 [<c0100311>] init+0x81/0x1e0
 [<c0100290>] init+0x0/0x1e0
 [<c0100bd5>] kernel_thread_helper+0x5/0x10
Code:  Bad EIP value.

This seems to be from the generic code but I'm not sure. First I enabled only
PIIX (+ATA_ENABLE_PATA) but it failed to detect any ATA devices at all.

-- 
Meelis Roos
