Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbRAXWiY>; Wed, 24 Jan 2001 17:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAXWiO>; Wed, 24 Jan 2001 17:38:14 -0500
Received: from users.724.com ([209.226.22.12]:35265 "EHLO inftormail04.724.com")
	by vger.kernel.org with ESMTP id <S129375AbRAXWiB>;
	Wed, 24 Jan 2001 17:38:01 -0500
Message-ID: <3A6F59C9.52740813@724.com>
Date: Wed, 24 Jan 2001 14:40:09 -0800
From: Charles-Edouard Ruault <cruault@724.com>
Organization: ezlogin.com a 7x24 solutions company
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext2 corruption in 2.4.0 (again)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen on Kernel Traffic that some people have reported an ext2
corruption with kernel 2.4.0.
It happened to me yesterday with a different configuration than the one
reported on the original posting so i just want to report the problem
again :
I was doing some standard work on my system and after issuing a ls in /
i saw some weird info displayed ( very huge files, strange permissions
etc ... ),
after a while i had a kernel panic with the following message :

ext2-fs panic ( device ide0(3,1)) : load_block_bitmap : block_group >=
groups_count - block_group =302292 group_count=226
and the system died.
I tried to reboot, i did not work ( unable to mount root partition )
I booted in redhat-rescue mode and tried to run fsck on my root
filesystem, it did not recognized the superblock so  i used another
superblock and it was reporting almost all the inodes corrupted. I tried
to repair what could be repaired without success. I ended up
reformatting my HD and reinstalling the system ( first time it happens
to me in 6 years of Linux ).

Here's some info on my system :

Hardware :
Pentium III 550Mhz
384 MB RAM
IDE hard drive : FUJITSU MPC3064AT ( /dev/hda )

here's the content of /proc/pci :
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel 440BX - 82443BX Host (rev 3).
      Medium devsel.  Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xf8000000 [0xf8000008].
  Bus  0, device   1, function  0:
    PCI bridge: Intel 440BX - 82443BX AGP (rev 3).
      Medium devsel.  Master Capable.  Latency=128.  Min Gnt=140.
  Bus  0, device   7, function  0:
    ISA bridge: Intel 82371AB PIIX4 ISA (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No
bursts.
  Bus  0, device   7, function  1:
    IDE interface: Intel 82371AB PIIX4 IDE (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.
Latency=64.
      I/O at 0x1060 [0x1061].
  Bus  0, device   7, function  2:
    USB Controller: Intel 82371AB PIIX4 USB (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master
Capable.  Latency=64.
      I/O at 0x1040 [0x1041].
  Bus  0, device   7, function  3:
    Bridge: Intel 82371AB PIIX4 ACPI (rev 2).
      Medium devsel.  Fast back-to-back capable.
  Bus  0, device  12, function  0:
    Multimedia audio controller: Unknown vendor Unknown device (rev 3).
      Vendor id=1073. Device id=c.
      Medium devsel.  IRQ 10.  Master Capable.  Latency=64.  Min
Gnt=5.Max Lat=25.
      Non-prefetchable 32 bit memory at 0xf4000000 [0xf4000000].
  Bus  0, device  15, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master
Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xf4008000 [0xf4008000].
      I/O at 0x1000 [0x1001].
      Non-prefetchable 32 bit memory at 0xf4100000 [0xf4100000].
  Bus  1, device   0, function  0:
    VGA compatible controller: Intel Unknown device (rev 33).
      Vendor id=8086. Device id=7800.
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master
Capable.  No bursts.
      Prefetchable 32 bit memory at 0xf5000000 [0xf5000008].
      Non-prefetchable 32 bit memory at 0xf4200000 [0xf4200000].

Software:
kernel 2.4.0 on a redhat 7.0 (compiled with kgcc).
I upgraded the following packages ( following the
/usr/src/linux/Documentation/Changes document ) :
e2fsprogs-1.19-0.2.i386.rpm
iptables-1.1.1-2.i386.rpm
util-linux-2.10p-2.i386.rpm
e2fsprogs-devel-1.19-0.2.i386.rpm
modutils-2.4.0-1.i386.rpm

that's about it ....
I hope this helps !
keep on the great work !

regards
Charles-Edouard Ruault

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
