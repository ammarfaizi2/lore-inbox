Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTBOPgv>; Sat, 15 Feb 2003 10:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTBOPgv>; Sat, 15 Feb 2003 10:36:51 -0500
Received: from mrw.demon.co.uk ([194.222.96.226]:22144 "HELO mrw.demon.co.uk")
	by vger.kernel.org with SMTP id <S262602AbTBOPgu> convert rfc822-to-8bit;
	Sat, 15 Feb 2003 10:36:50 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.61 and ELSA Passive Isdn cards...
Date: Sat, 15 Feb 2003 15:46:51 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302151546.51952.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to compile 2.5.61 on an Athlon. (with K7 optimisations)

make && make modules_install appear to work fine, but the last thing I see 
before being dumped back to the prompt is this:

WARNING: /lib/modules/2.5.61/kernel/drivers/isdn/hisax/hisax.ko needs unknown 
symbol kstat__per_cpu


FIrst question - has anyone had this card working in 2.5.x ?
Second, is this a known problem or am I doing something daft?


I've grepped the kernel tree and the only references I can find are:

[root@rebecca linux-2.5.61]# grep -R kstat__per_cpu *
Binary file arch/i386/kernel/irq.o matches
Binary file arch/i386/kernel/built-in.o matches
arch/m68knommu/platform/5307/entry.S:   leal    kstat__per_cpu+STAT_IRQ,%a0
arch/m68knommu/platform/5307/entry.S:   leal    kstat__per_cpu+STAT_IRQ,%a0
Binary file drivers/isdn/hisax/config.o matches
Binary file drivers/isdn/hisax/hisax.o matches
Binary file drivers/isdn/hisax/hisax.ko matches
Binary file fs/proc/proc_misc.o matches
Binary file fs/proc/proc.o matches
Binary file fs/proc/built-in.o matches
Binary file fs/built-in.o matches
Binary file kernel/sched.o matches
Binary file kernel/built-in.o matches
System.map:c03b2c40 D kstat__per_cpu
Binary file vmlinux matches


I have modutils-2.4.21-14 and module-init-tools-0.9.9 (both from rusty on 
kernel.org)

Under 2.4.20, the card is reported by lspci -v as:

00:0d.0 Network controller: Elsa AG QuickStep 1000 (rev 02)
        Subsystem: Elsa AG QuickStep 1000
        Flags: medium devsel, IRQ 11
        Memory at eb001000 (32-bit, non-prefetchable) [size=128]
        I/O ports at e400 [size=128]
        I/O ports at e800 [size=4]
        Expansion ROM at <unassigned> [disabled] [size=64K]


Thanks,

Mark.

