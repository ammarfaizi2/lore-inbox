Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbTIGVXw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbTIGVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:23:52 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:33521 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261423AbTIGVXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:23:50 -0400
Date: Sun, 7 Sep 2003 14:23:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 3c59x problem with 2.4.6-test[34]
Message-ID: <20030907212348.GA836@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I've run into an odd problem with the 3c59x driver on
2.6.0-test[34] (and 2.6.0-test4-mm6).  First, from scripts/ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux opus 2.6.0-test4 #2 SMP Sat Sep 6 20:43:52 MST 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.35-WIP
PPP                    2.4.1
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.90
Modules Loaded         parport_pc lp parport ipt_REJECT iptable_filter ipt_MASQUERADE ip_nat_ftp ip_conntrack_ftp iptable_nat ip_conntrack ip_tables 8250 core soundcore microcode rtc tulip crc32 af_packet 3c59x hid uhci_hcd usbcore ext2

and lspci:
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:0c.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 01)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

What seems to happen on every other boot (and just rebooting the machine
will 'fix' this) is that when 3c59x is loaded I get:
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe480. Vers LK1.1.19
  ***WARNING*** No MII transceivers found!

and then dhcp never gets an IP.   Virtually all of 2.4 has run just fine
in this particular setup.

-- 
Tom Rini
http://gate.crashing.org/~trini/
