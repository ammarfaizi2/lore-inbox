Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTFPKju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 06:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTFPKjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 06:39:49 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:37393 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263676AbTFPKjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 06:39:45 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.71-mm1 PCMCIA Yenta socket nonfunctional
Date: Mon, 16 Jun 2003 18:48:38 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306161343.03663.mflt1@micrologica.com.hk> <20030616082549.B5004@flint.arm.linux.org.uk>
In-Reply-To: <20030616082549.B5004@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306161848.38745.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 June 2003 15:25, Russell King wrote:
> On Mon, Jun 16, 2003 at 01:58:30PM +0800, Michael Frank wrote:
> > 2.5.71-mm1 Problem: does not init
>
> Could you check whether plain 2.5.71 (or 2.5.71-bkcurr) works?

2.5.71 had a compile problem - posted seperately
see 2.5.71 net/built-in.o : undefined reference to `register_cpu_notifier'

2.5.71 PCMCIA works, modem tested and now used to send this message, 
_but_ must start cardmgr manualy.

2.5.71 log

Jun 16 18:26:59 mhfl2 kernel: Linux Kernel Card Services 3.1.22
Jun 16 18:26:59 mhfl2 kernel:   options:  [pci] [cardbus] [pm]
Jun 16 18:26:59 mhfl2 kernel: Intel PCIC probe: not found.
Jun 16 18:26:59 mhfl2 kernel: Intel PCIC probe: not found.
Jun 16 18:28:24 mhfl2 kernel: PCI: Enabling device 00:12.0 (0000 -> 0002)
Jun 16 18:28:24 mhfl2 kernel: Yenta IRQ list 0000, PCI irq5
Jun 16 18:28:24 mhfl2 kernel: Socket status: 30000007
Jun 16 18:31:26 mhfl2 cardmgr[1988]: watching 1 sockets
Jun 16 18:31:26 mhfl2 kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jun 16 18:31:26 mhfl2 kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jun 16 18:31:26 mhfl2 kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x1e0-0x1e7 0x3c0-0x3df 0x408-0x40f 0x480-0x48f 0x4d0-0x4d7
Jun 16 18:31:26 mhfl2 kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jun 16 18:31:26 mhfl2 cardmgr[1989]: starting, version is 3.2.4
Jun 16 18:31:26 mhfl2 kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Jun 16 18:31:26 mhfl2 cardmgr[1989]: socket 0: Serial or Modem
Jun 16 18:31:27 mhfl2 kernel: ttyS0 at I/O 0x3f8 (irq = 5) is a 16550A
Jun 16 18:31:27 mhfl2 cardmgr[1989]: executing: './serial start ttyS0'

2.5.71 devices:
$ cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
 10 misc
 13 input
 29 fb
108 ppp
128 ptm
136 pts
202 cpu/msr
203 cpu/cpuid
254 pcmcia

Block devices:
  1 ramdisk
  3 ide0
  7 loop
 43 nbd

pcmcia entry missing in -mm1 (see earlier msg)

Why must start cardmgr manualy now?

Regards
Michael

-- 
Powered by linux-2.5.71, compiled with gcc-2.95-3 because it's rock solid

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting up 2.5 kernel at 
http://www.codemonkey.org.uk/post-halloween-2.5.txt

