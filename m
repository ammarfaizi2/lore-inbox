Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTIKPT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTIKPT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:19:27 -0400
Received: from relay5.tp1rc.edu.tw ([163.28.16.35]:46340 "EHLO
	relay5.tp1rc.edu.tw") by vger.kernel.org with ESMTP id S261403AbTIKPTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:19:25 -0400
Date: Thu, 11 Sep 2003 23:19:15 +0800
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: ide-cs kernel panic on ThinkPad X30
Message-ID: <20030911151915.GA816@rho>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Chuan-kai Lin <b86506063@ntu.edu.tw>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings kernel developers,

I have a 30X Transcend 512MB CompactFlash card that I use with my
digital camera, and I have been trying to get it working under Linux
with the built-in CompactFlash reader on my ThinkPad X30 laptop.
According to the information on the web, the built-in reader is
implemented as a PCMCIA device, and it should work with the ide-cs
driver.  The driver does work well when I inserted a 8X Lexar 16MB card
into the reader; however, when I inserted the Transcend card, I got:

Aug 31 19:14:17 rho kernel: hde: Transcend, CFA DISK drive
Aug 31 19:14:17 rho kernel: PM: Adding info for No Bus:ide2
Aug 31 19:14:17 rho kernel: hdf: probing with STATUS(0x50)
  instead of ALTSTATUS(0x0a)
Aug 31 19:14:17 rho kernel: hdf: H, ATA DISK drive
Aug 31 19:14:17 rho kernel: ide2 at 0x100-0x107,0x10e on irq 3
Aug 31 19:14:17 rho kernel: PM: Adding info for ide:2.0
Aug 31 19:14:17 rho kernel: PM: Adding info for ide:2.1
Aug 31 19:14:17 rho kernel: hde: max request size: 128KiB
Aug 31 19:14:17 rho kernel: hde: 1006992 sectors (515 MB) w/0KiB Cache,
  CHS=999/16/63
Aug 31 19:14:17 rho kernel:  /dev/ide/host2/bus0/target0/lun0: p1
Aug 31 19:14:17 rho kernel: hdf: max request size: 128KiB
Aug 31 19:14:17 rho kernel: hdf: 0 sectors (0 MB) w/9216KiB Cache,
  CHS=18432/0/0
Aug 31 19:14:17 rho kernel: hdf: INVALID GEOMETRY: 0 PHYSICAL HEADS?
Aug 31 19:14:17 rho kernel: ide-default: hdf: Failed to register the
  driver with ide.c
Aug 31 19:14:17 rho kernel: Kernel panic: ide: default attach failed

And the machine promptly froze.  The problem, obviously, is that hdf
does not exist at all, so naturally the IDE driver had problem
extracting any reasonable information concerned about it.  I have tried
using both hdf=noprobe or hdf=none at the LILO prompt, but neither seems
to have any effect on this problem.

I am using linux-2.6.0-test5 kernel with ide-cs compiled in (i.e. not as
a loadable module), and I use APM instead of ACPI for power management.

I am sure this information would not be sufficient for proper problem
diagnostic, however I do not really know what else do you need... so
whatever information you need for further investigation, please let me
know and I will try to get them for you.

Thanks in advance for your help.

-- 
Chuan-kai Lin
http://www.csie.ntu.edu.tw/~b6506063/
