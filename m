Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbTH3Qau (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 12:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbTH3Qau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 12:30:50 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:48540 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261981AbTH3Qak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 12:30:40 -0400
Date: Sat, 30 Aug 2003 17:22:28 +0100
From: Dave Bentham <dave.bentham@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre2
Message-Id: <20030830172228.59368d83.dave@telekon>
In-Reply-To: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last Wednesday I posted here that when mounting /dev/scd0 CDROM
(hdd=ide-scsi) the new kernel 2.4.22 panicked as 2.4.21 did before that.
2.4.20 is fine in this regard. If I remove the 'hdd=ide-scsi' appendage
then my CD is fine.

Someone has also reported his SCSI Megaraid killed the 2.4.22 too,
looking a similar, if not the same, issue.

So far there's been no response.

It looked to me (a layman as far as the kernel software is concerned)
that email's after the 2.4.21 SCSI problem were posted and that the
issue was being looked at and even perhaps fixed. Is it believed to have
been fixed in 2.4.22 (i.e. I've not built my kernel properly) or is it
still a known problem?

Thanks

Dave



On Sat, 30 Aug 2003 12:48:22 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> Hello,
> 
> Here goes -pre2. It contains an USB update, PPC merge, m68k merge, IDE
> changes from Alan, network drivers update from Jeff, amongst other
> fixes and updates.
> 
> 
> 
> Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
> ============================================
> 
> <cw:sgi.com>:
>   o Add SGI IOC4 IDE Driver
>   o SGI SN Serial/Console Driver
> 
> <davej:redhat.com>:
>   o USB: Add Minolta Dimage F300 to unusual_devs
> 
> <gaa:ulticom.com>:
>   o USB: new ids for io_ti driver
> 
> <javier:tudela.mad.ttd.net>:
>   o [wireless airo] add support for MIC and latest firmwares
> 
> <kevino:asti-usa.com>:
>   o USB: bug in EHCI device reset through transaction
> 
> <malte.d:gmx.net>:
>   o USB: support for Zaurus 750/760 to usbnet.c (2.4.22-pre8) + code
>   cleanup backport from 2.6
> 
> <marcelo:logos.cnet>:
>   o Changed hch contact information
>   o Fix compilation warning in panic.c
>   o Delete unused drivers/scsi/aic79xx (now aic7xxx supports it)
>   o add sysctl bits for setuid core
>   o Changed EXTRAVERSION to -pre2
> 
> <masanari.iida:hp.com>:
>   o SCSI blacklist HP Va7140
> 
> <mike.miller:hp.com>:
>   o cciss multi-path failover in md
> 
> <mporter:kernel.crashing.org>:
>   o PPC32: Add support for the IBM PPC 440 family of processors
>   o PPC32: Add support for DMA controllers on PPC 4xx processors
> 
> <russell_d_cagle:mindspring.com>:
>   o USB: add Garmin iQue support to visor driver
> 
> <thomas:winischhofer.net>:
>   o sisfb update
> 
> <vmlinuz386:yahoo.com.ar>:
>   o PCI Hotplug: fix __FUNCTION__ warnings
> 
> Alan Cox:
>   o remove all the 440gx broken bios stuff
>   o replace the pci router logic with working code
>   o update INDEX for docs
>   o wolfson touchscreen docs
>   o amd watchdog update
>   o update i8xx watchdog
>   o improved extra key bounce fix
>   o fix a missing rocket card
>   o warning fix
>   o fix nowayout handling on softdog
>   o fix missing formatting info in ide-cd
>   o add open/close methods to ide-default for hotplug
>   o move sibyte driver into the right dir
>   o Add Intel ICH3 hotplug support
>   o siimage: set a sata flag on the hwif so we can do cable det
>   o update ide raid for info pointer changes
>   o update ide headers for hotplug
>   o fix cable detect issue with sata
>   o split ide probe code up
>   o Add disk hotplug to the IDE core
>   o update cpia driver to fix warnings
>   o aacraid update
>   o wolfson ac97 touchscreen driver
>   o ad1889 error handling fixes
>   o ALi5455 update
>   o cmpci update
>   o fix i810 audio leak
>   o makefile/config update for sound changes
>   o USB audio fixes for OSS API compliance
>   o VGA also works on IA64
>   o tdfxfb updates for 24/32 and big endian
>   o allow setuid core dumps
>   o add sysctl number for setuid core
>   o Add headers for wolfson codecs
>   o Fix the file sharing/initrd bug
>   o resend - mm checks have precedence bugs
> 
> Alan Stern:
>   o USB: More unusual_devs.h entry updates
>   o USB: More unusual_devs.h stuff
>   o USB: Another unusual_devs.h entry update
> 
> Andrea Arcangeli:
>   o vmalloc allocations in ipc needs smp initialized
> 
> Andrew Morton:
>   o fix possible busywait in rtc_read()
>   o tty oops fix
> 
> Dan Streetman:
>   o USB: backport usbfs 'disconnect'
> 
> David Brownell:
>   o USB: ehci needs a readb() on IDP425 PCI (ARM)
>   o USB: ehci-hcd and period=1frame hs interrupts
> 
> David S. Miller:
>   o [TG3]: Update to irqreturn_t
>   o [TG3]: Sync TSO changes from base 2.5.x
>   o [TG3]: Merge comment typo fixes from 2.5.x
>   o [TG3]: Initial implementation of 5705 support
>   o [TG3]: Fix statistics on 5705
>   o [TG3]: Do not reset the RX_MAC unless PHY is Serdes
>   o [TG3]: More missing PCI IDs
>   o [TG3]: Reset PHY more reliably on 570{3,4,5} chips
>   o [TG3]: Fix 5788/5901, update TSO code
>   o [TG3]: Differentiate between TSO capable and TSO enabled
>   o [TG3]: Add {get,set}_tso ethtool_ops support
>   o [TG3]: Bump version/reldate
>   o [TG3]: Fix tg3_phy_reset_5703_4_5 chip rev test
>   o [TG3]: Bump version/reldate
>   o [TG3]: More fixes and enhancements
> 
> Geert Uytterhoeven:
>   o M68k ptrace
>   o Isapnp warning
>   o fb_cmap and transparency
>   o M68k RTC updates
>   o Rename ariadne2 to zorro8390
>   o M68k mm cleanup
>   o M68k free_io_area()
>   o M68k invalid vs. illegal
>   o Dmasound invalid vs. illegal
>   o M68k cpu_relax()
>   o dmasound SOUND_PCM_READ_RATE
>   o M68k FPU emulator
>   o dmasound core fixes
>   o lmc_proto.c includes <asm/smp.h>
>   o Sonic Ethernet unsafe interrupt
> 
> Greg Kroah-Hartman:
>   o USB: added support for TIOCM_RI and TIOCM_CD to pl2303 driver and
>   fix stupid bug o USB: remove some vendor specific stuff from the
>   pl2303 driver to get other devices to work o [TG3]: pci_device_id
>   can not be marked __devinitdata o [netdrvr sis900] don't call
>   pci_find_device from irq context o USB: fix up a bunch of copyrights
>   that were incorrectly declared o PCI hotplug: fix up a bunch of
>   copyrights that were incorrectly declared o PCI: add PCI_DEVICE()
>   macro to make pci_device_id tables easier to read o PCI: add
>   PCI_DEVICE_CLASS() macro to match PCI_DEVICE() macro
> 
> Henning Meier-Geinitz:
>   o USB: New vendor/product ids for scanner driver
>   o USB: fix check for SCN_MAX_MNR in scanner driver
>   o USB: Fix crash when scanners are disconnected while open
>   o USB: unlink interrupt URBs in scanner driver
> 
> Hirofumi Ogawa:
>   o [netdrvr 8139too] lwake unlock fix
>   o [netdrvr 8139too] remove unused RxConfigMask
>   o [netdrvr 8139too] add more h/w revision ids
> 
> Ian Abbott:
>   o USB: ftdi_sio - additional pids
>   o USB: ftdi_sio - VID/PID for ID TECH IDT1221U USB to RS-232 adapter
>   o USB: ftdi_sio - tidy up write bulk callback
> 
> James Morris:
>   o [TG3]: skb_headlen() cleanup
> 
> Jeff Garzik:
>   o [TG3]: Detect shared (and screaming) interrupts
>   o [TG3]: Convert to using ethtool_ops
>   o [TG3]: Bug fixes for 5705 support
>   o [TG3]: More 5705 updates
>   o [TG3]: More 5705 fixes
>   o [TG3]: Another 5705 fix: enable eeprom write prot as needed
>   o [TG3]: Only write the on-nic sram addr on non-5705
>   o [TG3]: Add 5782 pci id
>   o [netdrvr sis900] ethtool_ops support
>   o [netdrvr sis900] minor bits from 2.6
>   o [netdrvr 8139cp] minor bits from 2.6
>   o [netdrvr 8139cp] ethtool_ops support
>   o [netdrvr 3c59x] add a piece missed in previous ethtool_ops patch
>   o [netdrvr 3c501] ethtool_ops support
>   o [netdrvr] ethtool_ops support in 3c503, 3c505, 3c507
>   o [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe
>   o [netdrvr pcmcia] ethtool_ops for 3c574, 3c589, aironet4500, axnet
>   o [NET] add SET_ETHTOOL_OPS back-compat hook
>   o [netdrvr pcmcia] use SET_ETHTOOL_OPS in 3c574, 3c589, aironet4500,
>   and axnet o [netdrvr pcmcia] ethtool_ops support for several more
>   pcmcia drivers o [netdrvr 8139too] minor bits from 2.6
>   o [wireless airo] build fixes
>   o [scsi] add SCSI opcodes and SAM status codes to scsi/scsi.h
> 
> Judd Montgomery:
>   o USB: visor.h[c] USB device IDs documentation
> 
> Marc-Christian Petersen:
>   o DRM menu the right fix
> 
> Matthew Wilcox:
>   o [netdrvr 3c59x] ethtool_ops support
> 
> Nemosoft Unv.:
>   o USB: PWC 8.11
> 
> Paul Mackerras:
>   o PPC32: Add support for DMA mapping on non-cache-coherent machines
>   o PPC32: Add the infrastructure to allow for 64-bit PTEs
>   o PPC32: Fix typo in arch/ppc/Makefile
>   o PPC32: Use CONFIG_IBM_OPENBIOS instead of CONFIG_TREEBOOT
>   o PPC32: Add support for the PPC970 processor
>   o PPC32: Minor cleanups and fixes for 4xx/BookE systems
>   o PPC32: Restructure signal code, new ucontext structure, add
>   swapcontext syscall o PPC32: Implement semtimedop system call
> 
> Paul Mundt:
>   o Add Paul Mundt to CREDITS
> 
> Randy Dunlap:
>   o add seq_file "single" interfaces
> 
> Stefan Becker:
>   o USB: acm.c update for new devices
> 
> Stefan Rompf:
>   o [netdrvr 8139too] use mii_check_media lib function, instead of
>   homebrew MII bitbanging.
> 
> Steven Cole:
>   o Add 39 Configure.help texts from -ac tree
>   o Add six more Configure.help texts from the -ac tree
> 
> Tom Rini:
>   o PPC32: Change the default behavior of a kernel with KGDB
>   o PPC32: Fix KGDB and userland GDB interactions
> 
> Willy Tarreau:
>   o Fix log buffer length issues
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
A computer without Microsoft is like chocolate cake without mustard.

