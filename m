Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285266AbRL2TBt>; Sat, 29 Dec 2001 14:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285250AbRL2TBc>; Sat, 29 Dec 2001 14:01:32 -0500
Received: from mail01g.rapidsite.net ([207.158.192.232]:45757 "HELO
	mail01g.rapidsite.net") by vger.kernel.org with SMTP
	id <S285226AbRL2TBS>; Sat, 29 Dec 2001 14:01:18 -0500
Date: Sat, 29 Dec 2001 14:01:02 -0500 (EST)
From: Peter Hartzler <pete@hartzler.net>
X-X-Sender: <ph@boink.hartzler.home>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Tim Hockin <thockin@sun.com>
Subject: Re: [PATCH] eepro100 - need testers
Message-ID: <Pine.LNX.4.33.0112282134050.2562-100000@boink.hartzler.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just applied Tim Hockin's eepro100 patch of Tue, 04 Dec 2001 against an
otherwise stock 2.4.17.  Result summary: no joy.  Stock or patched, a ping
-f against a neighboring machine causes the driver to fail after a short
while (time < coffee-run) with that old standby:

	eepro100: wait_for_cmd_done timeout!

Doing the ping -f test with the unpatched OR patched module loaded as:

	modprobe eepro100 debug=6

gives very dubious output along the lines of (unpatched module gives
similar output....):

----- cut here -----

kernel: eepro100.c: Debug level is 6.
kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
kernel: Found Intel i82557 PCI Speedo, MMIO at 0xff8ff000, IRQ 3.
kernel: PCI: Found IRQ 3 for device 01:08.0
kernel: eth0: Intel Corp. 82820 (ICH2) Chipset Ethernet Controller, 00:03:47:0E:62:F3, IRQ 3.
kernel:   Board assembly 000000-000, Physical connectors present: RJ45
kernel:   Primary interface chip i82555 PHY #1.
kernel:   General self-test: passed.
kernel:   Serial sub-system self-test: passed.
kernel:   Internal registers self-test: passed.
kernel:   ROM checksum self-test: passed (0x04f4518b).
sysctl: net.ipv4.ip_forward = 0
sysctl: net.ipv4.conf.default.rp_filter = 1
sysctl: kernel.sysrq = 0
network: Setting network parameters:  succeeded
network: Bringing up interface lo:  succeeded
network: Bringing up interface eth0:  succeeded
kernel: nterrupt  status=0x0050.
kernel: tatus=0x0050.
kernel: tatus=0x0050.
kernel: <nterrupt  status=0x0050.
kernel: eth0: exiting interrupt, status=0x0050.
kernel: <7nterrupt  status=0x0050.
kernel: nterrupt  status=0x0050.
kernel: <7rrupt  status=0x4050.
kernel: <x0050.
kernel:   status=0x0050.
kernel: nterrupt  status=0x0050.
kernel: x2050.
kernel: x0050.
kernel: t  status=0x0050.
kernel: nterrupt  status=0x2050.
kernel:  status=0x2050.
kernel: <7x0050.
kernel: nterrupt  status=0x0050.
kernel: nterrupt  status=0x0050.
kernel: <nterrupt  status=0x0050.
kernel: <x4050.
kernel: nterrupt  status=0x0050.
kernel: <7x2050.
kernel: th0: interrupt  status=0x0050.
kernel: <x0050.
kernel: e candidate 39 status 400ca000.
kernel: nterrupt  status=0x0050.
kernel: <7status=0x0050.
kernel: <7nterrupt  status=0x0050.
kernel: <7h0: interrupt  status=0x0050.
kernel: .
kernel: nterrupt, status=0x0050.
kernel: eepro100: wait_for_cmd_done timeout!
last message repeated 14 times
kernel: h0:    396 00000001.

----- cut here -----

Trying to balance the need to send details versus avoiding list-flood...  
Let me know if any other bits would be useful.  I wrote a cheezy network
watchdog script which *should* let me back in from home after the next
hare-brained experiment... :)

System Info:
 - Dell Dimension 4100 "EA81510A.10A.0022.P06.0008291722"
 - BIOS Version A04
 - i686 800MHz "Pentium(R)III 800EB MHz"
 - 256M PC133 RAM

 - Hub is 10Mb/s (no easy way to test w/ 100Mb/s hub.)
 - Int 3 (eth0) is not shared.

 - Fully patched RedHat 7.2
	gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
	glibc-2.2.4-19.3 (i386)

Regards,

Pete.

