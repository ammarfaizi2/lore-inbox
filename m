Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293515AbSCKWPC>; Mon, 11 Mar 2002 17:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293503AbSCKWOo>; Mon, 11 Mar 2002 17:14:44 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:38673 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293527AbSCKWOd> convert rfc822-to-8bit; Mon, 11 Mar 2002 17:14:33 -0500
Date: Mon, 11 Mar 2002 18:08:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.19-pre3
Message-ID: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes -pre3, with the new IDE code. It has been stable enough time in
the -ac tree, in my and Alan's opinion.

The inclusion of the new IDE code makes me want to have a longer 2.4.19
release cycle, for stress-testing reasons.

Please stress test it with huge amounts of data ;)

pre3:

- -ac merge (including new IDE)				(Alan Cox)
- S390 merge						(IBM)
- More cciss fixes					(Stephen Cameron)
- Eicon SMP race fix					(Armin Schindler)
- w9966 driver update					(Jakob Kemi)
- Unify crc32 routine (removes lots of duplicated 
  code from drivers)					(Matt Domsch)
- Lanstreamer bugfixes					(Kent Yoder)
- Update scsi_debug					(Douglas Gilbert)
- MCE Configure.help update				(Paul Gortmaker)
- Fix SMB NLS oops					(Urban Widmark)
- AGP Config.in update					(Daniele Venzano)
- Fix small thinko in UFS set_blocksize return handling	(me)
- Avoid unecessary cache flushes on PPC			(Paul Mackerras)
- PPP deadlock fixes					(Paul Mackerras)
- Signal changes for thread groups			(Dave McCracken)
- Make max_threads be based on normal zone size		(Dave McCracken)
- ray_cs wireless extension fix				(Jean Tourrilhes)
- irda bugfixes and enhancements			(Jean Tourrilhes)
- USB update						(Greg KH)
- Fix through-8259A mode for IRQ0 routing on APIC 	(Maciej W. Rozycki/Joe Korty)
- Add Dell Inspiron 2500 to broken APM blacklist	(Arjan van de Ven)
- Fix off-by-one error in bluesmoke			(Dave Jones)
- Reiserfs update					(Oleg Drokin)
- Fix PCI compile without /proc support			(Eric Sandeen)
- Fix problem with bad inode handling			(Alexander Viro)
- aic7xxx update					(Justin T. Gibbs)
- Do not consider SCSI recovered errors as fatal errors	(Justin T. Gibbs)
- Add Memory-Write-Invalidate support to PCI		(Jeff Garzik)
- Starfire update					(Ion Badulescu)
- tulip update						(Jeff Garzik)


pre2:

- -ac merge						(Alan Cox)
- Huge MIPS/MIPS64 merge				(Ralf Baechle)
- IA64 update						(David Mosberger)
- PPC update						(Tom Rini)
- Shrink struct page					(Rik van Riel)
- QNX4 update (now its able to mount QNX 6.1 fses)	(Anders Larsen)
- Make max_map_count sysctl configurable		(Christoph Hellwig)
- matroxfb update					(Petr Vandrovec)
- ymfpci update						(Pete Zaitcev)
- LVM update						(Heinz J . Mauelshagen)
- btaudio driver update					(Gerd Knorr)
- bttv update						(Gerd Knorr)
- Out of line code cleanup				(Keith Owens)
- Add watchdog API documentation			(Christer Weinigel)
- Rivafb update						(Ani Joshi)
- Enable PCI buses above quad0 on NUMA-Q		(Martin J. Bligh)
- Fix PIIX IDE slave PCI timings			(Dave Bogdanoff)
- Make PLIP work again					(Tim Waugh)
- Remove unecessary printk from lp.c			(Tim Waugh)
- Make parport_daisy_select work for ECP/EPP modes	(Max Vorobiev)
- Support O_NONBLOCK on lp/ppdev correctly		(Tim Waugh)
- Add PCI card hooks to parport				(Tim Waugh)
- Compaq cciss driver fixes				(Stephen Cameron)
- VFS cleanups and fixes				(Alexander Viro)
- USB update (including USB 2.0 support)		(Greg KH)
- More jiffies compare cleanups				(Tim Schmielau)
- PCI hotplug update					(Greg KH)
- bluesmoke fixes					(Dave Jones)
- Fix off-by-one in ide-scsi				(John Fremlin)
- Fix warnings in make xconfig				(René Scharfe)
- Make x86 MCE a configure option			(Paul Gortmaker)
- Small ramdisk fixes					(Christoph Hellwig)
- Add missing atime update to pipe code			(Christoph Hellwig)
- Serialize microcode access				(Tigran Aivazian)
- AMD Elan handling on serial.c				(Robert Schwebel)

pre1:

- Add tape support to cciss driver			(Stephen Cameron)
- Add Permedia3 fb driver				(Romain Dolbeau)
- meye driver update					(Stelian Pop)
- opl3sa2 update					(Zwane Mwaikambo)
- JFFS2 update						(David Woodhouse)
- NBD deadlock fix					(Steven Whitehouse)
- Correct sys_shmdt() return value on failure		(Adam Bottchen)
- Apply the SET_PERSONALITY patch missing from 2.4.18 	(me)
- Alpha update						(Jay Estabrook)
- SPARC64 update					(David S. Miller)
- Fix potential blk freelist corruption			(Jens Axboe)
- Fix potential hpfs oops				(Chris Mason)
- get_request() starvation fix				(Andrew Morton)
- cramfs update						(Daniel Quinlan)
- Allow binfmt_elf as module				(Paul Gortmaker)
- ymfpci Configure.help update				(Pete Zaitcev)
- Backout one eepro100 change made in 2.4.18: it 
  was causing slowdowns on some cards			(Jeff Garzik)
- Tridentfb compilation fix				(Jani Monoses)
- Fix refcounting of directories on renames in tmpfs	(Christoph Rohland)
- Add Fujitsu notebook to broken APM implementation 
  blacklist						(Arjan Van de Ven)
- "do { ... } while(0)" cleanups on some fb drivers	(Geert Uytterhoeven)
- Fix natsemi's ETHTOOL_GLINK ioctl			(Tim Hockin)
- Fix clik! drive detection code in ide-floppy		(Paul Bristow)
- Add additional support for the 82801 I/O controller	(Wim Van Sebroeck)
- Remove duplicates in pci_ids.h			(Wim Van Sebroeck)



