Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262549AbTC0NKA>; Thu, 27 Mar 2003 08:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbTC0NJ7>; Thu, 27 Mar 2003 08:09:59 -0500
Received: from 13.2-host.augustakom.net ([80.81.2.13]:4736 "EHLO phoebee")
	by vger.kernel.org with ESMTP id <S262549AbTC0NJ4>;
	Thu, 27 Mar 2003 08:09:56 -0500
Date: Thu, 27 Mar 2003 14:21:01 +0100
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: Damjan Bole <damjanbole@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre6: usb ports/mouse not detected
Message-Id: <20030327142101.6a414743.martin.zwickel@technotrend.de>
In-Reply-To: <20030327130546.1f1d6d1f.damjanbole@gmx.net>
References: <20030327130546.1f1d6d1f.damjanbole@gmx.net>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-pre5-ac3 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.KIT,Z192P4(io+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.KIT,Z192P4(io+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2003 13:05:46 +0100
Damjan Bole <damjanbole@gmx.net> bubbled:

> Hi
> 
> Switching from 2.4.21pre5 to pre6 I've found out my usb mouse is dead
> and no usb port is detected on my msi kt266pro2. I used same (make
> oldconfig) as in pre5. I included dmesg logs below. regards

I had the same problem few hours ago.
Loading usb-ohci/ehci-hcd as a module fixed it for me ...
But it's just a "It Works for Me(tm)" ...

> 
> 
> 
> Here's pre6 dmesg part wih missing port detection:
> ...
> ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb.c: registered new driver hiddev
> usb.c: registered new driver hid
> hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> hid-core.c: USB HID support drivers
> mice: PS/2 mouse device common for all mice
> NET4: Linux TCP/IP 1.0 for NET4.0
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 256k freed
> Adding Swap: 353420k swap-space (priority -1)
> ...
> 
> 
> And here is dmesg from pre5:
> ...
> ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.275 $ time 13:00:46 Mar 22 2003
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 12
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 12
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 12
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 3
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> usb.c: registered new driver hiddev
> usb.c: registered new driver hid
> hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> hid-core.c: USB HID support drivers
> mice: PS/2 mouse device common for all mice
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Mounted devfs on /dev
> Freeing unused kernel memory: 256k freed
> hub.c: new USB device 00:11.2-2, assigned address 2
> input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb3:2.0
> Adding Swap: 353420k swap-space (priority -1)
> ...
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Martin Zwickel <martin.zwickel@technotrend.de>

Research & Development

TechnoTrend AG <http://www.technotrend.de>
Werner-von-Siemens-Str. 6
86159 Augsburg (Germany)

Tel: [+49-821-450448-16] <---> Fax: [+49-821-450448-11]

--------------------------------------------------------------------
This email, together with any attachments,  is for the exclusive and
confidential use of the addressee(s). Any other distribution, use or
reproduction without the sender's prior consent is  unauthorised and
strictly  prohibited.  If  you have received this message  in error,
please notify the sender by email immediately and delete the message
from your computer without making copies.

--=.KIT,Z192P4(io+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gvrAmjLYGS7fcG0RApyoAJ0dFk2Cn2Vu5LFWQAgFCjBSEPNS8ACfUvcU
0Fr1X4XbSyxTDgsKuQi9VVY=
=Yv17
-----END PGP SIGNATURE-----

--=.KIT,Z192P4(io+--
