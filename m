Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135203AbREBNDJ>; Wed, 2 May 2001 09:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135248AbREBNDA>; Wed, 2 May 2001 09:03:00 -0400
Received: from michal.it-media.cz ([62.24.69.86]:33267 "EHLO
	miklin.it-media.cz") by vger.kernel.org with ESMTP
	id <S135203AbREBNCk> convert rfc822-to-8bit; Wed, 2 May 2001 09:02:40 -0400
Date: Wed, 2 May 2001 15:02:24 +0200 (CEST)
From: Michal Kaspar <xkasm08@vse.cz>
X-X-Sender: <mkaspar@miklin.doma>
To: <linux-kernel@vger.kernel.org>
Subject: ISSUE: fs corruption under 2.4.4
Message-ID: <Pine.LNX.4.33.0105021439500.1842-100000@miklin.doma>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Filesystem corruption under 2.4.4
2. I encountered fs corruption shortly after upgrade from 2.4.3 to 2.4.4.
I found it after turning on my computer. The partitions seemed clean, but
a lot of files needed for system start could not be found.
The day before I turned it off correctly. I do not know what exactly
trggered the situation. Before turning it off I coppied some large (600+
MiB) from network via samba to slave harddisk on primary IDE channell. My
root partition is on primary master, the chipset is VIA KT133 (VT82C686).
3. filesystem, ext2fs, samba, networking, FAT
4. 2.4.4
7.1.
	-- Versions installed: (if some fields are empty or looks
	-- unusual then possibly you have very old versions)
	Linux miklin 2.4.3 #8 Ne dub 1 19:28:25 CEST 2001 i686 unknown
	Kernel modules         found
	ver: eucho: command not found
	Binutils               2.10.91.0.2
	Linux C Library        2.2.so
	ldd: missing file arguments
	Try `ldd --help' for more information.
	ls: /usr/lib/libg++.so: No such file or directory
	Procps                 2.0.7
	Mount                  2.10r
	Net-tools              (2000-05-21)
	Kbd                    [option...]
	Sh-utils               2.0
	Sh-utils               Parker.
	Sh-utils
	Sh-utils               Inc.
	Sh-utils               NO
7.2
	processor	: 0
	vendor_id	: AuthenticAMD
	cpu family	: 6
	model		: 3
	model name	: AMD Duron(tm) Processor
	stepping	: 0
	cpu MHz		: 600.044
	cache size	: 64 KB
	fdiv_bug	: no
	hlt_bug		: no
	f00f_bug	: no
	coma_bug	: no
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 1
	wp		: yes
	flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
	pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
	bogomips	: 1196.03
7.3.
	emu10k1                44752   1 (autoclean)
	usbmouse                1920   0 (unused)
	NVdriver              627216  17 (autoclean)
	ne2k-pci                4736   1 (autoclean)
	8390                    6144   0 (autoclean) [ne2k-pci]
	ipchains               33056   0 (unused)
	ntfs                   36528   1 (autoclean)
	nls_iso8859-2           3392   1 (autoclean)
	nls_cp852               3616   1 (autoclean)
	vfat                   11408   1 (autoclean)
	fat                    31040   0 (autoclean) [vfat]
	md                     41408   0 (unused)
	mousedev                4160   1
	hid                    11744   0 (unused)
	input                   3168   0 [usbmouse mousedev hid]
	usb-uhci               21904   0 (unused)
	usbcore                48112   1 [usbmouse hid usb-uhci]
7.5. The system board is MSI K7T Pro vith VIA KT133 chipset. Ide
interface VT82C686. Ethernet controller is RTL-8029(AS). Graphic card
NVidia GeForce MX with NVidia drivers.
X. The distribution I use is RedHat 7.1 upgraded from previous versions.
Running e2fsck helped little. I had to remove some files with debugfs and
create them again from backup. Mainly symlinks were affected.

-- 
Michal Ka¹par

V©E Praha

