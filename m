Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282547AbRLFTBw>; Thu, 6 Dec 2001 14:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282413AbRLFTBl>; Thu, 6 Dec 2001 14:01:41 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5523 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S282501AbRLFTBG>;
	Thu, 6 Dec 2001 14:01:06 -0500
Date: Thu, 6 Dec 2001 15:39:21 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Linux 2.4.17-pre5
Message-ID: <Pine.LNX.4.21.0112061536270.21518-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm going to release -pre versions more often from now on so people can
"see" what I'm doing with less latency: I hope that can make developer's
life easier.

So here goes pre5 with quite some changes... 

pre5:

- 8139too fixes					(Andreas Dilger)
- sym53c8xx_2 update				(Gerard Roudier)
- loopback deadlock bugfix			(Jan Kara)
- Yet another devfs update			(Richard Gooch)	
- Enable K7 SSE					(John Clemens)
- Make grab_cache_page return NULL instead 
  ERR_PTR: callers expect NULL on failure	(Christoph Hellwig)
- Make ide-{disk-floppy} compile without 
  PROCFS support				(Robert Love)
- Another ymfpci update				(Pete Zaitcev)
- indent NCR5380.{c,h}, g_NCR5380.{c,h}, plus 
  NCR5380 fix					(Alan Cox)
- SPARC32/64 update				(David S. Miller)
- Fix atyfb warnings				(David S. Miller)
- Make bootmem init code correctly align 
  bootmem data					(David S. Miller)
- Networking updates				(David S. Miller)
- Fix scanning luns > 7 on SCSI-3 devices 	(Michael Clark)
- Add sparse lun hint for Chaparral G8324 
	Fibre-SCSI controller			(Michael Clark)
- Really apply sg changes			(me)
- Parport updates				(Tim Waugh)
- ReiserFS updates				(Vladimir V. Saveliev)
- Make AGP code scan all kinds of devices:
  they are not always video ones		(Alan Cox)
- EXPORT_NO_SYMBOLS in floppy.c			(Alan Cox)
- Pentium IV Hyperthreading support		(Alan Cox)

pre4:

- Added missing tcp_diag.c and tcp_diag.h	(me)

pre3:

- Enable ppro errata workaround                 (Dave Jones)
- Update tmpfs documentation                    (Christoph Rohland)
- Fritz!PCIv2 ISDN card support                 (Kai Germaschewski)
- Really apply ymfpci changes                   (Pete Zaitcev)
- USB update                                    (Greg KH)
- Adds detection of more eepro100 cards         (Troy A. Griffitts)
- Make ftruncate64() compliant with SuS         (Andrew Morton)
- ATI64 fb driver update                        (Geert Uytterhoeven)
- Coda fixes                                    (Jan Harkes)
- devfs update                                  (Richard Gooch)
- Fix ad1848 breakage in -pre2                  (Alan Cox)
- Network updates                               (David S. Miller)
- Add cramfs locking                            (Christoph Hellwig)
- Move locking of page_table_lock on expand_stack
  before accessing any vma field                (Manfred Spraul)
- Make time monotonous with gettimeofday        (Andi Kleen)
- Add MODULE_LICENSE(GPL) to ide-tape.c         (Mikael Pettersson)
- Minor cs46xx ioctl fix                        (Thomas Woller)

pre2:

- Remove userland header from bonding driver	(David S. Miller)
- Create a SLAB for page tables on i386		(Christoph Hellwig)
- Unregister devices at shaper unload time	(David S. Miller)
- Remove several unused variables from various
  places in the kernel				(David S. Miller)
- Fix slab code to not blindly trust cc_data():
  it may be not valid on some platforms		(David S. Miller)
- Fix RTC driver bug				(David S. Miller)
- SPARC 32/64 update				(David S. Miller)
- W9966 V4L driver update			(Jakob Jemi)
- ad1848 driver fixes				(Alan Cox/Daniel T. Cobra)
- PCMCIA update					(David Hinds)
- Fix PCMCIA problem with multiple PCI busses 	(Paul Mackerras)
- Correctly free per-process signal struct	(Dave McCracken)
- IA64 PAL/signal headers cleanup		(Nathan Myers)
- ymfpci driver cleanup 			(Pete Zaitcev)
- Change NLS "licenses" to be "GPL/BSD" instead 
  only BSD.					(Robert Love)
- Fix serial module use count			(Russell King)
- Update sg to 3.1.22				(Douglas Gilbert)
- ieee1394 update				(Ben Collins)
- ReiserFS fixes				(Nikita Danilov)
- Update ACPI documentantion			(Patrick Mochel)
- Smarter atime update				(Andrew Morton)
- Correctly mark ext2 sb as dirty and sync it	(Andrew Morton) 
- IrDA update					(Jean Tourrilhes)
- Count locked buffers at
  balance_dirty_state(): Helps interactivity under
  heavy IO workloads				(Andrew Morton)
- USB update					(Greg KH)
- ide-scsi locking fix                          (Christoph Hellwig)

pre1:

- Change USB maintainer 			(Greg Kroah-Hartman)
- Speeling fix for rd.c				(From Ralf Baechle's tree)
- Updated URL for bigphysmem patch in v4l docs  (Adrian Bunk)
- Add buggy 440GX to broken pirq blacklist 	(Arjan Van de Ven)
- Add new entry to Sound blaster ISAPNP list	(Arjan Van de Ven)
- Remove crap character from Configure.help	(Niels Kristian Bech Jensen)
- Backout erroneous change to lookup_exec_domain (Christoph Hellwig)
- Update osst sound driver to 1.65		(Willem Riede)
- Fix i810 sound driver problems		(Andris Pavenis)
- Add AF_LLC define in network headers		(Arnaldo Carvalho de Melo)
- block_size cleanup on some SCSI drivers	(Erik Andersen)
- Added missing MODULE_LICENSE("GPL") in some   (Andreas Krennmair)
  modules
- Add ->show_options() to super_ops and 
  implement NFS method				(Alexander Viro)
- Updated i8k driver				(Massimo Dal Zoto)
- devfs update  				(Richard Gooch)


