Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129537AbRB0VZi>; Tue, 27 Feb 2001 16:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbRB0VZ2>; Tue, 27 Feb 2001 16:25:28 -0500
Received: from mail.eunet.ch ([146.228.10.7]:7172 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S129537AbRB0VZP>;
	Tue, 27 Feb 2001 16:25:15 -0500
Message-ID: <3A9C2948.506897B8@dial.eunet.ch>
Date: Tue, 27 Feb 2001 22:25:12 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 3c59x new version, help me please with the new kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI 3COM 3C905B COMBO Etherlink XL 10/100Mbit BNC+RJ-45
running a LAN with 3 machines 10MB with BNC/RG-58U cable.

2.2.12 ... 2.2.19pre7aa1 no problems,

kernel with modules, /etc/modules.conf:
alias eth0 3c59x
options 3x59x options=0

kernel _without_ modules, my usual and preferred mode,
with the following little patch from Andrea
in /usr/src/linux/drivers/net/3c59x.c, original:
static int options[MAX_UNITS] = { -1, -1, -1, -1, -1, -1, -1, -1,};
always manually changed to:
static int options[MAX_UNITS];

booting message without modules:

eth0: 3Com 3c905B Cyclone 10/100/BNC at 0xa000,  00:50:04:9b:f0:b8 IRQ11
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  Media override to transceiver type 0 (10baseT)
  Enabling bus-master transmits and whole-frame receives.
(the 1st line after 00:50 ... is different on all 3 machines!)

Works since over an year perfectly.
-----------------------------------

2.2.19pre15aa1 (same effect with 2.4.2pre?):

neither telnet nor mount -t nfs work,
rebooting to 2.2.19pre7aa1, _all_ works always perfectly.

Checked with 3c59x as module, without modules,
with/without Andrea's change, rien ne va plus.

gcc-2.95.3.test3, all kernels since test1 compiled with in
/usr/src/linux/arch/i386/Makefile:
ifdef CONFIG_M686
CFLAGS := ... -march=i686 ... in place of -m486
(stolen from 2.4.2pre?)

All machines PIII550, 2 UP's 512MB mem, 1 SMP Dual 1024MB.
glib-2.1.3
base old SuSE 6.4 with many updgrades via sources
*.tar.gz/*tar.bz2, never with rpm!

Not in lkml, CC if necessary.

I will do every test is needed/requested !!!

Regards and many thanks
Mario

PS Why _all_ machines swap copying 545MB, 5 files ~115MB,
   from a mounted /cdrom to /tmp?  With the newest kernels!
   AT&T SVR2...3.2 in over 12 years newer swapped with cp(1).
