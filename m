Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289916AbSAWRLT>; Wed, 23 Jan 2002 12:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289917AbSAWRLM>; Wed, 23 Jan 2002 12:11:12 -0500
Received: from scully-a0.index.hu ([217.20.130.10]:44293 "HELO dap.index")
	by vger.kernel.org with SMTP id <S289916AbSAWRK7>;
	Wed, 23 Jan 2002 12:10:59 -0500
Subject: IDE rescan => DISABLED, NO IRQ
From: Pallai Roland <dap@omnis.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 23 Jan 2002 18:10:55 +0100
Message-Id: <1011805855.621.13.camel@dap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I want to check my new kernel to see what changed about IDE
hotswapping, but I've got this message just after the rescan request:

Jan 23 15:54:19 WishMaster hdi: probing with STATUS(0x50) instead of
ALTSTATUS(0xff) 
Jan 23 15:54:19 WishMaster hdi: WDC WD153BA, ATA DISK drive 
Jan 23 15:54:19 WishMaster hdi: IRQ probe failed (0xfff83eb8) 
Jan 23 15:54:19 WishMaster hdj: probing with STATUS(0x50) instead of
ALTSTATUS(0xff) 
Jan 23 15:54:19 WishMaster hdj: ST320423A, ATA DISK drive 
Jan 23 15:54:19 WishMaster hdj: IRQ probe failed (0xfff83eb8) 
Jan 23 15:54:19 WishMaster ide4: DISABLED, NO IRQ 
Jan 23 15:54:40 WishMaster hdi: ERROR, PORTS ALREADY IN USE 
Jan 23 15:54:40 WishMaster hdj: ERROR, PORTS ALREADY IN USE 

 the kernel say " ide4: ports already in use, skipping probe " and do
nothing if I try to rescan once again

 I've 5 IDE controllers (three on board and a PCI card), interrupts are
assigned by the following order:
           CPU0       
  0:     448638    IO-APIC-edge  timer
  1:        518    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
 14:     123503    IO-APIC-edge  ide0
 15:      21569    IO-APIC-edge  ide1
 16:     245384   IO-APIC-level  ide2, ide3
 17:       9538   IO-APIC-level  aic7xxx
 18:    4319591   IO-APIC-level  ide4, eth0


 kernel 2.4.18pre2, if you need other informations, tell me



-- 
  DaP
