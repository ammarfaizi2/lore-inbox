Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbTANGH0>; Tue, 14 Jan 2003 01:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbTANGH0>; Tue, 14 Jan 2003 01:07:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5130 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267474AbTANGHU>; Tue, 14 Jan 2003 01:07:20 -0500
Date: Mon, 13 Jan 2003 22:14:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.58
Message-ID: <Pine.LNX.4.44.0301132205550.6784-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 I'm still on my accelerated release schedule, trying to make slightly
smaller patches more frequently, instead of having humungous patches and
having people forced to either wait or use the BK trees.

 HOWEVER, that's going to change. I'm actually leaving for a two-week
vacation on Friday, so not only will we have a lull in the merges due to
that (I probably won't be on the 'net at all, since I'm travelling with my
family), but I'll also have to slow down patches before leaving to try to
leave with a fairly stable kernel.

 While I'm away, I'm sure the regular suspects are going to work on
merging stuff (Andrew & co), so it shouldn't be a big deal, but it still
helps to not have major quakes just before going away for a while.

 The 2.5.58 stuff is largely a merge of a lot of smaller stuff (tons of
trivial patches, for example), with some bigger things: a parisc update,
IPMI driver, USB updates, sysfs updates, and RPCSEC_GSS support.

		Linus


Summary of changes from v2.5.57 to v2.5.58
============================================

<cobra@compuserve.com>:
  o Trivial USB doc patch
  o ohci/ehci debug updates for 2.5.56

<cubic@miee.ru>:
  o Fix AMD device ID table bug

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o sd.c

Christoph Hellwig <hch@lst.de>:
  o allow NULL dev argument to scsi_add_host

Corey Minyard <cminyard@mvista.com>:
  o IPMI (Intelligent Platform Management Interface) driver

Dominik Brodowski <linux@brodo.de>:
  o cpufreq: add sysfs interface
  o cpufreq: add driver for NatSemi Geode / Cyrix MediaGX
  o cpufreq: per-CPU initialization

Douglas Gilbert <dougg@torque.net>:
  o SG_IO ioctl in block layer

Duncan Sands <baldrick@wanadoo.fr>:
  o get rid of speedtouch kernel thread
  o eliminate global minor array in speedtouch
  o remove redundant casts in speedtouch
  o remove duplicate spinlocks from speedtouch

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: fix error message when loading the digi_acceleport driver
  o USB: Fix problem of sending the wrong device_id to the usb serial
    driver on probe()
  o USB: visor driver, add the proper structure for the palm request 4
    command
  o USB visor: Split up the initialization command logic to handle
    different device types better
  o USB bluetty: fix incorrect url in help text
  o USB: usb-skeleton MINOR_BASE change
  o USB midi: fix typo in previous patch
  o Cset exclude: greg@kroah.com|ChangeSet|20030112082136|46568

Greg Ungerer <gerg@snapgear.com>:
  o use C99 initializers in m68knommu setup.c
  o add missing do_coredump() arg to m68knommu arch signal.c
  o use _etext in 68EZ328 ucsimm target start code
  o use _etext in 68VZ328 de2 target start code
  o use _etext in 68VZ328 ucdimm target start code
  o set default console baud rate in 68360serial.c
  o remove obsolete code from mcfserial.h
  o add smp_read_barrier_depends() for m68knommu
  o remove obsolete code from comempci.c
  o combine all m68knommu arch linker scripts into one
  o common m68knommu arch entry.S

James Bottomley <jejb@mulgrave.(none)>:
  o remove SCSI's use of signals for killing the error handler thread
  o [SCSI] add missing eh_thread kill instruction

James Bottomley <jejb@raven.il.steeleye.com>:
  o Update the generic DMA API to take GFP_ flags on allocation
  o Update x86 DMA API implementation to take GFP_ flags
  o Update arm implementation of DMA API to include GFP_ flags
  o update drivers using dma_alloc_[non]coherent for GFP_ flags
  o generic/dma-mapping.h: remove BUG_ON flags not GFP_ATOMIC
  o Add GFP_ flags to parisc DMA API implementation

Jaroslav Kysela <perex@suse.cz>:
  o PnP update

Jens Axboe <axboe@suse.de>:
  o rbtree core for io scheduler

Jochen Friedrich <jochen@scram.de>:
  o NFSv2 READDIR encoding fix

John Stultz <johnstul@us.ibm.com>:
  o linux-2.5.57_timer-none_A0.patch
  o linux-2.5.57_delay-cleanup_A1.patch

Linus Torvalds <torvalds@home.transmeta.com>:
  o reiserfs/hashes.c used to include <asm/page.h> in order to get the
    definition of BUG().

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o USB storage: clean up debugging

Matthew Wilcox <willy@debian.org>:
  o parisc updates for 2.5.56
  o More parisc updates

Miles Bader <miles@lsi.nec.co.jp>:
  o Use `--unique=.gnu.linkonce.this_module' linker flag for modules on
    v850
  o Update v850 nb85e_uart serial driver to set baud min/max
  o Define smp_read_barrier_depends on v850

Oliver Neukum <oliver@oenone.homelinux.org>:
  o USB midi fixes
  o USB audio: using GFP_KERNEL with a spinlock held
  o USB xpad: fix URB leak in open error path

Patrick Mansfield <patmans@us.ibm.com>:
  o add scsi_level to scsi_device sysfs attributes

Patrick Mochel <mochel@osdl.org>:
  o sysfs: return -EFAULT if copy_{to,from}_user() doesn't copy all
    bytes
  o sysfs: restore count parameter to struct sysfs_ops::store()
  o sysfs: reinstate count parameter for sysfs_ops.store() methods
  o sysfs: reinstate count parameter to sysfs_ops.store() methods
  o sysfs: reinstate count parameter for PNP store() methods
  o sysfs: fixup SCSI sysfs files
  o sysfs: Fixup s390 sysfs files
  o sysfs: Fixup MCA sysfs files
  o sysfs: Fixup NUMA sysfs file
  o cpufreq: sysfs interface update
  o sysfs: Fixup deadline iosched sysfs files
  o fix cpufreq compilation

Richard Henderson <rth@kanga.twiddle.net>:
  o [MODULES] Centralize undefined symbol checks; handle undef weak

Russell King <rmk@arm.linux.org.uk>:
  o use <asm/bug.h> for BUG() defines

Rusty Russell <rusty@rustcorp.com.au>:
  o namespace pollution in skfddi driver
  o move snd_legacy_find_free_ioport to opti92x-ad1848.c
  o Module state and address in /proc/modules
  o namespace pollution in eth bridge driver
  o namespace pollution in HDLC driver
  o Remove compile warning from drivers_ide_pci_cs5520.c
  o remove check_region from drivers_atm_ambassador.c
  o cli_sti in drivers_net_hamradio_bpqether.c
  o duplicate extern char _stext
  o namespace pollution in Dell SMM driver
  o namespace pollution in OSS_pas2 driver
  o remove check_region from drivers_ide_legacy_umc8672.c
  o driver_char_Kconfig bug (fwd)
  o remove check_region from drivers_scsi_cpqfcTSinit.c
  o Janitoring drivers_acorn_scsi_fas216.c
  o Correct kmalloc check: drivers_scsi_dpt_i2o.c
  o Remove compile warning from drivers_ide_pci_sc1200.c
  o namespace pollution in 'backpack' paride
  o namespace pollution in cosa driver
  o namespace pollution in sunrpc
  o namespace pollution in reiserfs
  o namespace pollution in ide-probe.c
  o namespace pollution in netfilter_ebt_log
  o Remove compile warning from drivers_ide_pci_generic.h
  o namespace pollution in irda qos
  o namespace pollution in tr.c
  o namespace pollution in opti92x driver
  o namespace pollution in procfs
  o MODULE_FORCE_UNLOAD must depend on MODULE_UNLOAD (fwd)
  o Handle kmalloc fails: drivers_net_fec.c
  o Drain local pages to make swsusp work
  o namespace pollution in Maxi Radio driver
  o namespace pollution in irda_irias
  o Memory leak in drivers_net_rruner.c
  o remove check_region from sound_oss_awe_wave.c
  o Handle kmalloc fails: drivers_isdn_i4l_isdn_ppp_ccp.c
  o namespace pollution in korg 1212 driver

Tom Rini <trini@kernel.crashing.org>:
  o Don't ask about "Enhanced Real Time Clock Support" on some archs

Trond Myklebust <trond.myklebust@fys.uio.no>:
  o Clean up RPC client credcache lookups [1/6]
  o XDR 'encode' phase move [2/6]
  o RPCSEC upcall mechanism [3/6]
  o RPCSEC_GSS authentication framework [4/6]
  o RPCSEC_GSS client upcall user [5/6]
  o minimal Kerberos V5 client support [6/6]

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>:
  o Clustered APIC setup for >8 CPU systems

Willem Riede <wrlk@riede.org>:
  o Change signal used to exit scsi error handlers

Zwane Mwaikambo <zwane@holomorphy.com>:
  o sound/oss/opl3sa2.c compile fix


