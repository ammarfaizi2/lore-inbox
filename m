Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTK1R2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTK1R2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:28:05 -0500
Received: from tartutest.cyber.ee ([193.40.6.70]:11014 "EHLO
	tartutest.cyber.ee") by vger.kernel.org with ESMTP id S262729AbTK1R2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:28:01 -0500
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: aic7xxx problem on sparc64 (2.6)
In-Reply-To: <Pine.GSO.4.44.0311281452110.6614-100000@math.ut.ee>
User-Agent: tin/1.7.2-20031104 ("Eriskay") (UNIX) (Linux/2.6.0-test10 (i686))
Message-Id: <E1APmPJ-00078V-CP@rhn.tartu-labor>
Date: Fri, 28 Nov 2003 19:27:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MR> I inserted my known working 2940 (7880) into a Sun Ultra 5 (32-bit PCI).
MR> modprobe aic7xxx gave some errors and asked to report the bug.
MR> modprobe sd_mod gave a lot more errors and put the disk offline. The
MR> same hardware (host, HBA and disk) works fine with latest 2.4 kernel
MR> (2.4.23-rc5 currently). The problem is with 2.6.0-test11.

Probably it's not a aic7xxx specific problem at all. I replaced it with
Symbios 53c875 (again with PC ROM, no OpenFirmware ROM) and the results
are the same: 2.4 works OK, 2.6 gets timeouts. NetBSD 1.6.1 and OpenBSD
3.4 also get timeouts with this card. NetBSD also gets timeouts with the
Adaptec card, OpenBSD does not support the Adaptec on sparc64 so it is
not tested.

Something with sparc64 PCI or IRQs??

SCSI subsystem initialized
sym0: <875> rev 0x3 at pci 0000:02:01.0 irq 4,7d0
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18b
  Vendor: FUJITSU   Model: M2954ESP SUN4.2G  Rev: 2545
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:2:0: tagged command queuing enabled, command queue depth 16.
sym0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
SCSI device sda: 8385121 512-byte hdwr sectors (4293 MB)
sym0:2:0: ABORT operation started.
sym0:2:0: ABORT operation timed-out.
sym0:2:0: DEVICE RESET operation started.
sym0:2:0: DEVICE RESET operation timed-out.
sym0:2:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0:2:0: BUS RESET operation complete.
sym0:2:0: ABORT operation started.
sym0:2:0: ABORT operation timed-out.
sym0:2:0: DEVICE RESET operation started.
sym0:2:0: DEVICE RESET operation timed-out.
sym0:2:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0:2:0: BUS RESET operation complete.
sym0:2:0: ABORT operation started.
sym0:2:0: ABORT operation timed-out.
sym0:2:0: DEVICE RESET operation started.
sym0:2:0: DEVICE RESET operation timed-out.
sym0:2:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0:2:0: BUS RESET operation complete.
sym0:2:0: ABORT operation started.
sym0:2:0: ABORT operation timed-out.
sym0:2:0: DEVICE RESET operation started.
sym0:2:0: DEVICE RESET operation timed-out.
sym0:2:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0:2:0: BUS RESET operation complete.
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: sda1 sda3
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0

-- 
Meelis Roos (mroos@linux.ee)
