Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319009AbSHQCRp>; Fri, 16 Aug 2002 22:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHQCRp>; Fri, 16 Aug 2002 22:17:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39692 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S319009AbSHQCRn>; Fri, 16 Aug 2002 22:17:43 -0400
Date: Fri, 16 Aug 2002 22:31:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre3
Message-ID: <Pine.LNX.4.44.0208162231060.8044-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here goes -pre3.


Summary of changes from v2.4.20-pre2 to v2.4.20-pre3
============================================

<alex_williamson@hp.com>:
  o fix raid on GPT partitions

<andersen@codepoet.org>:
  o cdrom sane fallback vs 2.4.20-pre1

<garloff@suse.de>:
  o IBM 4000R needs LARGELUN

<gsromero@alumnos.euitt.upm.es>:
  o isofs multi volume compliance fix

<hch@lst.de>:
  o convert to yield() usage

Adrian Bunk <bunk@fs.tum.de>:
  o fix a typo in the description of CONFIG_BLK_STATS

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o PCI enable handling
  o fill in siginfo on alpha
  o ARM cpufreq hooks
  o update reiserfsprogs
  o document an acpi bogon
  o fix firestream gcc 3.1 warnings
  o fix io accounting on cpqarray
  o error check DAC960 copy*user
  o whoops
  o use proper macros in analog joystick
  o use proper tsc macros in random driver
  o add help button to sonypi driver, fix gcc 3.1 warnings
  o flip the vt ifdef the sane way around
  o fix the gcc warnings in cpqphp_nvram
  o make the st usb compile again
  o fix broken ifdef
  o Update CPIA driver (this has been in ac for a bit)
  o fix a gcc warning and a thinko
  o [resend] revert broken atarilance change
  o fix net/Config.in formatting, 83820 typo
  o fix eepro deeply broken code formatting (no other change)
  o latest mpt fusion update from author
  o update serverworks idents
  o fix extern->static inline on sbus
  o allow Zalon to be selected for HP
  o add hp tachyons to cpqfc driver + fix warnings
  o fix dpt_i2o warnings
  o fix esp driver to static inline
  o update scsi makefile for hp stuff
  o make NCR53c9x use inline not extern inline
  o update ncr asm assembler
  o switch scsi.h to static inline
  o fix incorrect read10 to read6 handling on error
  o sgiserial to static inline
  o usb to static inline
  o kaweth new ident (silicom usb)
  o ov511 driver updates
  o update pwc to new map handing too
  o update se401 the same way
  o same again for stv
  o update ohci driver to handle strange natsemi bits
  o update usbvideo and vicam
  o use static inline in clgenfb
  o allow people to select befs
  o make the dnotify cache consistent with other naming
  o make the fasync_cache also named in accordance tonorms
  o make file_lock cache also match default format
  o fix a problem where fsync of an nfs dir gives wrong code
  o small nls tidying
  o update to new ldm partition code
  o add sem_getcount to stop people poking in semaphore
  o allow DMA0 on isapnp
  o allow reporting of 3rd/4th codec
  o ALi 5455 audio
  o files_init - set file limit based on ram
  o get the types right on lib/inflate.c constants
  o add down_read_trylock/write_trylock
  o add befs maintainer
  o update hfs maintainer
  o remove dead url
  o format fix
  o add parisc directories to build
  o remainign minor atm bits
  o fix gcc 3 warning
  o make semaphores gcc 3.1 safe
  o the wbinvd is safe anyway
  o this fixes the remaining vm86/tf screwups
  o add HIL to serio
  o headers for SOM (HP) binary format
  o missed earlier - header change for sonypi
  o second item I found testing - misse scsi.h macro add
  o first bits of ps2esdi cleanup
  o fix depca warnings
  o revert wrong change to isicom
  o first pass xd.c clean up

Andi Kleen <ak@muc.de>:
  o pageattr for 2.4

Andrew Morton <akpm@zip.com.au>:
  o copy_strings speedup
  o fix lru_cache_add vs activate_page race

Bjorn Wesen <bjorn.wesen@axis.com>:
  o arch/cris update

Douglas Gilbert <dougg@torque.net>:
  o lk2.4.19 sg driver header file synchronization
  o scsi_debug driver update

Geert Uytterhoeven <geert@linux-m68k.org>:
  o m68k: PCI DMA updates
  o m68k: add page_to_phys()

jack_hammer@adaptec.com <Jack_Hammer@adaptec.com>:
  o ServeRAID driver update

Jean Tourrilhes <jt@bougret.hpl.hp.com>:
  o ir240_usb_fix_greg.diff
  o ir240_usb_disconnect-3.diff

Jens Axboe <axboe@suse.de>:
  o elevator seek accounting fixes

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o Add support for ISDN card Eicon Diva 2.02
  o Move PCI device id to include/linux/pci_ids.h
  o Add support for ISDN card Formula-n enter:now, a.k.a. Gerdes Power ISDN
  o Add in-kernel ISAPnP support to HiSax driven ISDN cards
  o Doc changes / Cleanup for ISDN ISAPnP changes
  o ISDN MPPP crash fix
  o Update README.HiSax for the added card
  o Update README.HiSax for the added card
  o ISDN: LED support for netjet driver
  o ISDN: Add Data Over Voice support
  o ISDN: Cisco HDLC update
  o ISDN: Fix DoV (Data over Voice)

Marc Boucher <marc@mbsi.ca>:
  o yet another VAIO dmi_blacklist entry

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o Revert 2.4.19's AMD Athlon prefetch workaround
  o Revert APIC error message silencing: APIC errors can be fatal
  o Makefile

Martin Mares <mj@ucw.cz>:
  o pci.ids for 2.4.20-pre2

Neil Brown <neilb@cse.unsw.edu.au>:
  o resend - Enable NFS over TCP via config option

Stephen Rothwell <sfr@canb.auug.org.au>:
  o [2.4.20-pre1] File lease fixes

Steven Cole <elenstev@mesatop.com>:
  o 2.4.20-pre2 update Documentation/sysctl/vm.txt
  o 2.4.20-pre2 remove 8 duplicate help texts from

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Fix NFS locking bug
  o Teach RPC client to send pages rather than iovecs. [1/3]
  o Teach RPC client to send pages rather than iovecs. [2/3]
  o Teach RPC client to send pages rather than iovecs. [3/3]
  o Fix typo in the RPC reconnect code
  o Clean up RPC receive code [1/2]
  o Clean up RPC receive code [2/2]
  o fixup conflict between NFS kmap patches and 2.4.20-pre

Urban Widmark <urban@teststation.com>:
  o smbfs poll


