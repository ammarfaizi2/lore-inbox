Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288891AbSBDK4R>; Mon, 4 Feb 2002 05:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288914AbSBDK4I>; Mon, 4 Feb 2002 05:56:08 -0500
Received: from gneiss.popnet.de ([194.195.135.5]:3343 "HELO gneiss.popnet.de")
	by vger.kernel.org with SMTP id <S288891AbSBDKz5>;
	Mon, 4 Feb 2002 05:55:57 -0500
Message-ID: <001201c1ad6a$89514d70$9a641fac@popnet.de>
From: =?ISO-8859-1?Q? "Ren=E9?= Camu" <rene.camu@isc4u.de>
To: "Fabrice Eudes" <fabrice.eudes@free.fr>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020204113949.A1695@corwin.ambre.fr>
Subject: Re: Can't boot 2.4.17 or 2.5.1 kernel
Date: Mon, 4 Feb 2002 11:56:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If you are using potato you need the two following entries in your
sources.list
deb http://people.debian.org/~bunk/debian potato main
deb-src http://people.debian.org/~bunk/debian potato main

For woody you need the following
#
deb http://ftp.de.debian.org/debian testing main contrib non-free
deb-src http://ftp.de.debian.org/debian testing main contrib non-free
#
deb http://ftp.de.debian.org/debian-non-US
dists/testing/non-US/main/binary-$(ARCH)/
deb-src http://ftp.de.debian.org/debian-non-US
dists/testing/non-US/main/source/#
deb http://ftp.de.debian.org/debian-non-US
dists/testing/non-US/contrib/binary-$(ARCH)/
deb-src http://ftp.de.debian.org/debian-non-US
dists/testing/non-US/contrib/source/
#
deb http://ftp.de.debian.org/debian-non-US
dists/testing/non-US/non-free/binary-$(ARCH)/
deb-src http://ftp.de.debian.org/debian-non-US
dists/testing/non-US/non-free/source/
#

First update your system before ionstallnig 2.4.*

Best regards

René Camu
----- Original Message -----
From: "Fabrice Eudes" <fabrice.eudes@free.fr>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, February 04, 2002 11:39 AM
Subject: Can't boot 2.4.17 or 2.5.1 kernel


Hello,

I am a french guy living in Lille and using/practising Linux for 6ish
years. Please could you Cc me any answer. thanks a lot.

I had a -long- look in the mailing list archives but couldn't find an
answer to the following question:

[Short] I boot 2.2.19 kernels without any problems but can't boot any
2.4.17 neither a 2.5.1.

[Details] I have a PC Packard-Bell imédia6007a
- AMD Athlon 1.4GHz
- Motherboard "Explorer" from Packard-Bell
- Chipset VIA KM133: VT8365A Northbridge (AGP,PCI) and VT686B
  Southbridge (IDE,USB) (BIOS recently upgraded)
- ATIRadeonVE 32MB
- Debian GNU/Linux Woody (non-official isos from 20/07/2001) with
  XFree86 upgraded from 4.0.3 to 4.1.0 (xfree86-common, xserver-common,
  xserver-xfree86) for radeon support.

Firstly, I want a 2.4.x kernel for the sound (alsa), the framebuffer and
the dri (I'd like to be able to play tuxracer ;o)

I boot my system with grub and there is no problem for the 2.2.19 kernel
packaged with the woody neither for the lighter one I compiled myself
from the debian packaged sources.

However, I hadn't any success booting a 2.4.17 kernel; I hadn't tried
every possibility but I tried:
- a 2.4.13 kernel compiled from the "generic" (I mean not the debian
  package, see below) sources.
- the kernel-image-2.4.17-k7_2.4.17-1_i386.deb debian package.
- many kernels compiled from kernel-source-2.4.17_2.4.17-1_all.deb
  debian package.
- a few kernels compiled from the 2.4.17 "generic" sources.
- a 2.5.1 kernel compiled from the "generic" sources (non patched).

I tried to compile for Athlon, PentiumPro, 386 -> same behavior
I tried with/out initrd support -> same behavior
I tried "mem=nopentium" boot option related to the radeon -> same
behavior
I also tried lilo and boot disks both for grub and lilo -> same behavior

please help ! thanks a million.

[begin grub output]
  Booting command-list

root  (hd0,0)
  Filesystem type is ext2fs, partition type 0x83
kernel  /boot/vmlinuz-2.4.17-k7 root=/dev/hda1 ro
  [Linux-bzImage, setup=0x1400, size=0x9b512]
initrd  /boot/initrd.img
  [Linux-initrd @ 0x17cb4000, 0x32c000 bytes]

Uncompressing Linux... Ok, booting the kernel.
[end grub output]
and the machine is stucked there...
It seems to me that grub loads the kernel ok but when grub gives it the
hand, the problem occurs...
--
Stéphanie, Fabrice et Fiona -o)
stephanie.dupuis@free.fr /\\
fabrice.eudes@free.fr _\_V
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

