Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRCaSrL>; Sat, 31 Mar 2001 13:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132485AbRCaSrB>; Sat, 31 Mar 2001 13:47:01 -0500
Received: from s340-modem2142.dial.xs4all.nl ([194.109.168.94]:24714 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S132482AbRCaSqu>;
	Sat, 31 Mar 2001 13:46:50 -0500
Date: Sat, 31 Mar 2001 20:42:50 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Karl Heinz Kremer <khk@khk.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE Disk Corruption with 2.4.3 / NOT with AC kernels
In-Reply-To: <20010331084212.A11393@khk.net>
Message-ID: <Pine.LNX.4.31.0103312019450.2081-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just got my first fs corruption too(2.4.3), but using reiserfs on LVM ,
and the volume group is also on IDE.

Accessing some /usr/src/linux/... file my system "hang" or just rebooted.
using reiserfsck "fixed" this for me.

I'm using the Asus A7V board, but comparable chipset, with the athlon
1.1GHz.


 # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875J (rev 04)
00:0c.0 Ethernet controller: 3Com Corporation 3c985 1000BaseSX (rev 01)
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
00:0d.1 Input device controller: Creative Labs SB Live! (rev 07)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 [NV5] (rev 15)

On Sat, 31 Mar 2001, Karl Heinz Kremer wrote:

> I run into some major disk corruptions on my IDE disk with the new
> 2.4.3 kernel version. I did see the same corruptions with 2.4.2
> - but back then I blamed reiserfs and went back to 2.4.1.
>
> Now I did some more testing and found out that the Alan Cox
> series of kernel patches does not show these problems. I tried
> one from the 2.4.1-ac series (I think it was ac8) and 2.4.2-ac20
> with nothing but success. I was using the same .config file for
> all tests to make sure that the problem was not caused by
> a kernel configuration issue.
>
> This is my hardware:
>
> 	- ABit KT7 board (KT133 chipset reported by lspci)
> 	- 1GHz Athlon
> 	- QUANTUM FIREBALLP AS40.0 disk (cat /proc/ide/hda/model)
>
> Here is the output of lspci:
>
> khk@specht:~ > /sbin/lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> 00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
> 00:09.0 Multimedia video controller: Zoran Corporation ZR36057PQC Video cutting chipset (rev 02)
> 00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
> 00:0f.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
> 00:11.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)
>
> I can provide more information on request, I can also test patches - I have a test
> partition that I'm using to test new kernel configurations without affecting my
> "normal" system.
>
> I am following the list only through the archives on the web, so if you want to
> get in touch with me, please CC khk@khk.net.
>
> Karl Heinz
>
>

-- 
Arjan Filius
mailto:iafilius@xs4all.nl

