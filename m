Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUAZDXl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 22:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUAZDXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 22:23:41 -0500
Received: from auemail1.lucent.com ([192.11.223.161]:18865 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265471AbUAZDXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 22:23:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16404.34836.753760.759367@gargle.gargle.HOWL>
Date: Sun, 25 Jan 2004 22:23:00 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Andi Kleen <ak@muc.de>
Cc: John Stoffel <stoffel@lucent.com>, Adrian Bunk <bunk@fs.tum.de>,
       Valdis.Kletnieks@vt.edu, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
In-Reply-To: <20040125234756.GF28576@colin2.muc.de>
References: <200401251811.27890.cova@ferrara.linux.it>
	<20040125173048.GL513@fs.tum.de>
	<20040125174837.GB16962@colin2.muc.de>
	<200401251800.i0PI0SmV001246@turing-police.cc.vt.edu>
	<20040125191232.GC16962@colin2.muc.de>
	<16404.9520.764788.21497@gargle.gargle.HOWL>
	<20040125202557.GD16962@colin2.muc.de>
	<16404.10496.50601.268391@gargle.gargle.HOWL>
	<20040125214920.GP513@fs.tum.de>
	<16404.20183.783477.596431@gargle.gargle.HOWL>
	<20040125234756.GF28576@colin2.muc.de>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

I applied the early-printk patch to 2.6.2-rc1 and here's the serial
output I got, before the system just stopped booting:

    Linux version 2.6.2-rc1 (john@jfsnew) (gcc version 3.3.3 20040110
    (prerelease) (Debian)) #4 SMP Sun Jan 25 22:13:38 EST 2004
    BIOS-provided physical RAM map:
     BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
     BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
     BIOS-e820: 0000000000100000 - 000000002fffe000 (usable)
     BIOS-e820: 000000002fffe000 - 0000000030000000 (reserved)
     BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
     BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
     BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
    767MB LOWMEM available.
    found SMP MP-table at 000fe710
    hm, page 000fe000 reserved twice.
    hm, page 000ff000 reserved twice.
    hm, page 000f0000 reserved twice.
    On node 0 totalpages: 196606
      DMA zone: 4096 pages, LIFO batch:1
      Normal zone: 192510 pages, LIFO batch:16
      HighMem zone: 0 pages, LIFO batch:1

Here's the copied odwn output from tty0, my regular console:

       Booting '2.6.2-rc1'

     root (hd0,0)
      Filesystem type is ext2fs, partition type 0x83
     kernel /vmlinux-2.6.2-rc1 root=sda2 ro console=ttyS0,38400n8
      console=tty0 earlyprintk=serial
	[linux-bzImage, setup=0xa00, size=0x1d3b38]
     savedefault
     boot
     Uncompressing Linux... Ok, booting the kernel.

And that's it.  I'll see about applying the patch to the various
2.6.2-rc1-mm kernels as well, and possibly to 2.6.2-rc2, which I just
got downloaded.  Hmmm... I'll try that one first actually and try to
get more info out tonight.

John
