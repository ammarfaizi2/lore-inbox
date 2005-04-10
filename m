Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVDJMIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVDJMIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 08:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVDJMIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 08:08:16 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:17012 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261481AbVDJMIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 08:08:07 -0400
Message-ID: <42591914.2000800@yahoo.it>
Date: Sun, 10 Apr 2005 14:16:20 +0200
From: TommyDrum <mycooc@yahoo.it>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: el, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: r8169 native module problems on 2.6.11
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello, I've got a problem with usrobotics r8169 based gigabit ethernet;
kernel module doesn't properly startup, with modprobe r8169; module gets
correctly loaded, but ifconfig doesn't see it, and startup scripts deny
existence of an eth0 dev; meanwhile the r8169 module taken from the
cdrom compiles installs and functions correctly; here's the modinfo for
both:

kernel native module:

author:         Realtek and the Linux r8169 crew <netdev@oss.sgi.com>
description:    RealTek RTL-8169 Gigabit Ethernet driver
parmtype:       media:array of int
parmtype:       rx_copybreak:int
parmtype:       use_dac:int
parm:           use_dac:Enable PCI DAC. Unsafe on 32 bit PCI slot.
license:        GPL
version:        2.2LK
vermagic:       2.6.11-gentoo-r5 preempt PENTIUMIII gcc-3.3
depends:
alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
srcversion:     017DC70C1E25F3AB2CA0324

USrobotics cdrom module:

author:         Realtek
description:    U.S. Robotics 10/100/1000 PCI NIC driver
license:        GPL
vermagic:       2.6.11-gentoo-r5 preempt PENTIUMIII gcc-3.3
depends:
alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*

and dmesg for both:

kernel native:

ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: U.S. Robotics 10/100/1000 PCI NIC driver version 2.0 at
0xe08ee000, 00:c0:49:f2:86:1e, IRQ 11
eth0: Auto-negotiation Enabled.

USR module:

ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: U.S. Robotics 10/100/1000 PCI NIC driver version 2.0 at
0xe08e6000, 00:c0:49:f2:86:1e, IRQ 11
eth0: Auto-negotiation Enabled.

I don't understand exactly the difference between the two, thought I
could help by posting this fact. Please if you find it irrelevant don't
flame me, since it's my first post to the kernel mailing list, I'd
welcome any suggestions and I will try to post any other information you
request.

Keep on the good work,
Ciao!

Tommy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCWRkRgpUvhTIUBAERApE1AJ9aju0Np0VWGD8ItP30fchnXSwSfQCeLbS4
1EimT1GM7TfC2yWrurNFg24=
=j5ge
-----END PGP SIGNATURE-----

