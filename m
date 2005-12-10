Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVLJI7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVLJI7y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbVLJI7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:59:54 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:9339 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S964961AbVLJI7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:59:52 -0500
X-ME-UUID: 20051210085942422.673331C0034B@mwinf0306.wanadoo.fr
Message-ID: <439A9973.6050009@wanadoo.fr>
Date: Sat, 10 Dec 2005 10:01:39 +0100
From: mahashakti89 <mahashakti89@wanadoo.fr>
Reply-To: mahashakti89@wanadoo.fr
Organization: none
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: mahashakti89@wanadoo.fr
Subject: udev problem ...
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi !

Here is a report bug I posted on bugs@debian.org , we'll make it short ,
I cannot activate udev at boot , if I do this  I get IDE errors on both
harddisks and if I can enter an X-session, I cannot open a terminal : I
get following error message :
"there was a problem with the child process of this terminal" . If I
desactivate udev at boot, eveything is going O.K.
The Debian package maintainer thinks it looks like a kernel bug ....
This is why I am posting here hoping for help in this matter.

mahashakti89

PS : Could you CC me your answer, I am not on the list .


THANKS


Package :  udev
Version  : 0.076-3


#dpkg --status udev
Package
Package : udev
Version:0.076-3
Status: install ok installed
Priority: optional
Section: admin
Installed-Size: 960
Maintainer: Marco d'Itri <md@linux.it>
Architecture: i386
Version: 0.076-3
Provides: hotplug
Depends: libc6 (>= 2.3.5-1), libselinux1 (>= 1.26), libsepol1 (>= 1.8),
initscripts (>= 2.85-16), makedev (>= 2.3.1-77), sed (>= 3.95), lsb-base
(>= 3.0-6)
Conflicts: lvm-common (<< 1.5.13), hotplug, module-init-tools (<<
3.2-pre9-1), initramfs-tools (<< 0.39)
Description: /dev/ and hotplug management daemon
 udev is a daemon which dynamically creates and removes device nodes from
 /dev/, handles hotplug events and loads drivers at boot time. It replaces
 the hotplug package and requires a kernel not older than 2.6.12.

II.Descritpion

If I activate udev at boot through some utility like sysvconfig or
sysvconfig I have problem with both IDE Disks
(Maxtor 80 G0 and 250 G0) , I get following error message : Drive Seek
Complete Data Request, Satus 0x 58, Drive not Ready
for command , and sometimes I cannot log into an X-session.

If I can log in, I cannot open a terminal - gnome-terminal , konsole,
xterm - I get following error message :
There was a problem with the child process of this terminal.
It is then impossible to type any command.

If I desactivate udev at boot , everything is O.K , no IDE-errors , no
problems with gnme-terminal, konsole or xterm.


III. Informations
KERNEL VERSION :

/home/claude# uname -a
Linux ishwara 2.6.14-ck6 #1 SMP Sun Nov 27 10:05:42 CET 2005 i686 GNU/Linux

LIBC6 VERSION :

:/home/claude# dpkg -s libc6 | grep ^Version
Version: 2.3.5-8.1

HARDWARE :
Processor = Pentium IV
Motherboard = ASUS P4P800
Chipset = I865 PE
Harddisk 1 =

hdparm -i /dev/hda

/dev/hda:

 Model=Maxtor 6Y080P0, FwRev=YAR41BW0, SerialNo=Y31PPXDE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3
ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

 * signifies the current active mode

Harddisk 2 =

 hdparm -i /dev/hdb

/dev/hdb:

 Model=Maxtor 6L250R0, FwRev=BAH41G10, SerialNo=L6132M9H
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=16384kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3
ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

 * signifies the current active mode

 I didn't  touch the basic configuration files of udev except some
personal rules for my modem
and USB-Sticks.


Hope you understand my english.

Thanks

mahashakti89
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDmplyPPuyRSaD7LoRAk7DAJ0ddxljwM2pRCLCB1ZZPaeeG23vvgCgiM7c
bw2MG2i6kDy2zM0xxV7jbNk=
=1uMy
-----END PGP SIGNATURE-----

