Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTABSMk>; Thu, 2 Jan 2003 13:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTABSMj>; Thu, 2 Jan 2003 13:12:39 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:43970 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266285AbTABSMg>; Thu, 2 Jan 2003 13:12:36 -0500
Date: Thu, 2 Jan 2003 19:20:38 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: torvalds@transmeta.com, jgarzik@pobox.com, zaitcev@redhat.com,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
       netfilter-devel@lists.samba.org, phillim2@comcast.net,
       rmk@arm.linux.org.uk
Subject: [PATCHSET] Multiarch kconfig cleanup
Message-ID: <20030102182038.GZ17053@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On with the [mainly networking oriented] Kconfig clean-up saga.

This is the first time I'm trying to get more than 3 people to work
together so I'd be grateful if you didn't kick me too hard should I have
screwed up.

I'm not including the patches, because that would mean everyone receives
a 115K bundle.  Instead,

wget -r http://www.pinerecords.com/kala/linux/2.5.54-config-cleanup/

will get you:

    #  filename (s/\.diff//)  short description
(BEGIN yesterday's stuff)
 1/36  x01                    Create a parent entry for gigabit eth interfaces
 2/36  x02                    Show the 10/100 megabit eth submenu conditionally
 3/36  x03                    Show the arcnet submenu conditionally
 4/36  x04                    Show the wireless LAN submenu conditionally
 5/36  x05                    Show the tokenring submenu conditionally
 6/36  x06                    Show the WAN submenu conditionally
 7/36  x07                    Show the NET_PCMCIA submenu conditionally
 8/36  x08                    Show the ATM drivers submenu conditionally
 9/36  x09                    Make CONFIG_ACPI the parent of the ACPI submenu
10/36  x10                    Show the PCMCIA/CardBus submenu conditionally
11/36  x11                    Show the PCI hotplug submenu conditionally
12/36  x12                    Show the PCMCIA SCSI submenu conditionally
13/36  x13                    Show the QOS submenu conditionally
14/36  x14                    Overhaul netfilter configuration
(END yesterday's stuff)
(START netdev unification)
15/36  x15-arch-alpha         Tear down alpha NETDEVICES config
16/36  x15-arch-arm           Tear down arm NETDEVICES config
17/36  x15-arch-cris          Tear down cris NETDEVICES config
18/36  x15-arch-ia64          Tear down ia64 NETDEVICES config
19/36  x15-arch-m68k          SPECIAL: Tear down m68k NETDEVICES config 
20/36  x15-arch-m68k_nommu    Tear down m68k_nommu NETDEVICES config
21/36  x15-arch-mips32        Tear down mips32 NETDEVICES config
22/36  x15-arch-mips64        Tear down mips64 NETDEVICES config
23/36  x15-arch-parisc        Tear down parisc NETDEVICES config
24/36  x15-arch-ppc           Tear down ppc NETDEVICES config
25/36  x15-arch-ppc64         Tear down ppc64 NETDEVICES config
26/36  x15-arch-sparc32       SPECIAL: Tear down sparc32 NETDEVICES config
27/36  x15-arch-sparc64       Tear down sparc64 NETDEVICES config
28/36  x15-arch-superh        Tear down superh NETDEVICES config
29/36  x15-arch-v850          Tear down v850 NETDEVICES config
30/36  x15-arch-x86           Tear down x86 NETDEVICES config
31/36  x15-arch-x86_64        Tear down x86_64 NETDEVICES config
32/36  x15-net.0              Show the atm submenu depending on architecture
33/36  x15-net.1-sparc        1/2 Add missing bus dependencies to netdev menus
34/36  x15-net.2-m68k         2/2 -""- (and re-add m68k specific drivers)
35/36  x16                    Add the unified NETDEVICES submenu
36/36  x17                    Bring the "Networking support" menu to life
(END netdev unification)

sparc32 and m68k are special in that they define their specific netdevices
in arch/{sparc,m68k}/Kconfig.

ACKLIST is as follows, i.e. people listed please ACK at least:
	Jeff Garzik		more or less all (sorry)
	Pete Zaitcev		#26, #32, #33, #35
	David Miller		#26, #27, #32, #33, #35
	Russell King		#16, #35
	Mike Phillips		#5
	(m68k people)		#19, #20, #34, #35
	(ACPI team)		#9
	(netfilter team)	#14
	Linus Torvalds		all (sorry)

The patches are to be applied sequentially.  Everything is against 2.5.54.

If you want to just test the patchset, grab & apply
http://www.pinerecords.com/kala/linux/2.5.54-config-cleanup/all/all.diff.gz

x86 seems to work as expected.  I also tried to compile sparc32 but found
out 2.5.54 vanilla itself was broken for it -- the .config looked sane,
though.

-- 
Tomas Szepe <szepe@pinerecords.com>
