Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287831AbSBKKqm>; Mon, 11 Feb 2002 05:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287860AbSBKKqd>; Mon, 11 Feb 2002 05:46:33 -0500
Received: from adsl-63-198-217-24.dsl.snfc21.pacbell.net ([63.198.217.24]:7428
	"EHLO hp.masroudeau.com") by vger.kernel.org with ESMTP
	id <S287831AbSBKKqR>; Mon, 11 Feb 2002 05:46:17 -0500
Date: Mon, 11 Feb 2002 02:38:37 -0800 (PST)
From: Etienne Lorrain <etienne@masroudeau.com>
To: <linux-kernel@vger.kernel.org>
Subject: Gujin 0.6 i386 bootloader/Linuxloader feedback?
Message-ID: <Pine.LNX.4.33.0202110140420.18506-100000@hp.masroudeau.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

 Gujin is a bootloader/Linux system loader, it is still improving
 and can be downloaded at:
http://sourceforge.net/projects/gujin/
 Documentation at:
http://sourceforge.net/docman/display_doc.php?docid=1989&group_id=15465

 In three words, this GPL produces 3 bootloaders:
  - a simple FAT12 floppy bootloader (tiny.img.gz) and if you "zcat"
  it to a floppy, you just need to copy a bzImage/initrd to the
  floppy (by mcopy or mounting the floppy) to have a bootable system.
  - a simple DOS executable (tiny.exe) which can be run from a DOS
  rescue disk, you just type at a DOS prompt:
  tiny c:\vmlinuz.245 d:\initrd.245 root=/dev/hda2 other_params=...
  - a full menu based boot-floppy or DOS executable which scans
  all the disk partitions (FAT12/16/32, ext2/3fs) and propose a
  graphical+mouse menu to select what you want to boot. A lot
  of configurations are available for this last choice.

 It is still not perfect, but can already be used in some cases,
 like rescue disk or probably bootable CDROMs (virtual floppy).

 I am planning to do the hard disk installer RSN, but I lack
 some feeback - like on which systems Gujin fails to work -
 even if I know people are downloading it from SourceForge counters.

 Also, I heard about having all modules in a cpio archive, I am
 wondering about considering the i386 real mode initialiser as
 a module - and copying it / running it in low memory before
 jumping to the protected mode entry point.


 Finally, and as a side effect, Gujin is also an improved "memtest".
 If you download the source (and E2fs source) and type:
make testall > log
 it will test the compilation/link of a lot of configuration.
 That means 1 hour of 100% CPU time compilation with nearly no
 hard drive access on a Athlon 1.4Ghz KT266 system. Then I learned
 that having a-very/the-most expensive single CPU motherboard
 and a said "very good memory", I do not have a stable system
 when selecting "BIOS defaults", I need to reduce the memory speed
 to 100 MHz - test your own system!


  Etienne.

--
 The right length, for the legs, is when the foots touch
 perfectly the floor. (Coluche - free translation)

