Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSBKQbi>; Mon, 11 Feb 2002 11:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287828AbSBKQb3>; Mon, 11 Feb 2002 11:31:29 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:47493 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S287770AbSBKQbM>; Mon, 11 Feb 2002 11:31:12 -0500
Date: Mon, 11 Feb 2002 17:27:49 +0100
From: Kristian <kristian.peters@korseby.net>
To: linux-kernel@vger.kernel.org
Subject: APIC error on CPU0
Message-Id: <20020211172749.2bdadec7.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Since I converted one box to Debian 3.0 I'm getting strange errors related to APM.
When I push the power button (or do "apm -s") the box suspends normally. But it comes back almost immediately with this error:

APIC error on CPU0: 00(40)

I grepped the kernel source and found that "40" means reserved APIC error. What does that mean exactly ? BTW: I enabled "local APIC on uniprocessors" but this behaviour also appears without enabling that option.

Strangely this error won't appear with Redhat 7.2 and earlier versions. (I've never had any problems.)

$ dmesg:

Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: auto BOOT_IMAGE=linux ro root=305 console=ttyS0,57600n8,vt1
02 console=tty0
Initializing CPU#0
Detected 349.187 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 696.32 BogoMIPS
Memory: 61808k/65536k available (1354k kernel code, 3340k reserved, 480k data, 2
32k init, 0k highmem)
[...]

$ lspci:

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 02)
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
00:0f.0 Token ring network controller: IBM 16/4 Token ring UTP/STP controller (rev 05)
00:14.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:14.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:14.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:14.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)

BTW: I already tried the specified list for apmd but it seems to be down since years..

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
