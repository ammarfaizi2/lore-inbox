Return-Path: <linux-kernel-owner+w=401wt.eu-S932870AbXAABjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbXAABjR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 20:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932853AbXAABjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 20:39:16 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:53926 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933245AbXAABjP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 20:39:15 -0500
Date: Sun, 31 Dec 2006 20:39:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
In-reply-to: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Message-id: <200612312039.03960.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
Content-disposition: inline
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 December 2006 20:19, Linus Torvalds wrote:
>In order to not get in trouble with MADR ("Mothers Against Drunk
>Releases") I decided to cut the 2.6.20-rc3 release early rather than
> wait for midnight, because it's bound to be new years _somewhere_ out
> there. So here's to a happy 2007 for everybody.
>
>The big thing at least for me personally is that nasty shared mmap
>corruption fix, but there's a number of other changes in here, many of
>them just documentation (and some media and network drivers). Shortlog
> and diffstat appended..
>
>The git trees have been updated, and the tar-tree and patches seem to
> have finisged crawling out my poor DSL connection too.
>
>As usual, mirroring might take a while, although the delay has not been
>all that horrible lately, so it's probably going to be up-to-date by the
>time the hangovers are mostly gone.
>
>At which point the first thing on any self-respecting geek's mind should
>obviously be: "is there a new kernel release for me to try?"
>
>Right?
>
Right.  Have a Happy New Year yourself, Linus.

>			Linus
>
>----
>Adrian Bunk (2):
>      V4L/DVB (4959): Usbvision: possible cleanups
>      V4L/DVB (4991): Cafe_ccic.c: fix NULL dereference
>
>Akinobu Mita (5):
>      V4L/DVB (4994): Vivi: fix use after free in list_for_each()
>      V4L/DVB (4995): Vivi: fix kthread_run() error check
>      V4L/DVB (4996): Msp3400: fix kthread_run error check
>      V4L/DVB (4997): Bttv: delete duplicated ioremap()
>      module: fix mod_sysfs_setup() return value
>
>Al Viro (1):
>      page_mkclean_one(): fix call to set_pte_at()
>
>Alexey Dobriyan (2):
>      V4L/DVB (5012): Usbvision fix: It was using "&&" instead "&"
>      fuse: fix typo
>
>Amit Choudhary (1):
>      V4L/DVB (4990): Cpia2/cpia2_usb.c: fix error-path leak
>
>Amit S. Kale (8):
>      NetXen: Adding new device ids.
>      NetXen: driver reload fix for newer firmware.
>      NetXen: Using correct CHECKSUM flag.
>      NetXen: Multiple adapter fix.
>      NetXen: Link status message correction for quad port cards.
>      NetXen: work queue fixes.
>      NetXen: Fix for PPC machines.
>      NetXen: Reducing ring sizes for IOMMU issue.
>
>Andreas Schwab (1):
>      Fix compilation of via-pmu-backlight
>
>Andrew Morton (2):
>      cpuset procfs warning fix
>      lockdep: printk warning fix
>
>Ang Way Chuang (1):
>      V4L/DVB (4972): Dvb-core: fix bug in CRC-32 checking on 64-bit
> systems
>
>Arnaud Patard (Rtp (1):
>      spi_s3c24xx_gpio: use right header
>
>Avi Kivity (6):
>      KVM: Use boot_cpu_data instead of current_cpu_data
>      KVM: Simplify is_long_mode()
>      KVM: Implement a few system configuration msrs
>      KVM: Move common msr handling to arch independent code
>      KVM: More msr misery
>      KVM: Fix oops on oom
>
>Ayaz Abdulla (1):
>      forcedeth: modified comment header
>
>Brice Goglin (5):
>      myri10ge: match number of save_state and restore
>      myri10ge: move request_irq to myri10ge_open
>      myri10ge: make msi configurable at runtime through sysfs
>      myri10ge: no need to save MSI and PCIe state in the driver
>      myri10ge: handle failures in suspend and resume
>
>Bruce Allan (2):
>      e1000: fix to set the new max frame size before resetting the
> adapter e1000: Fix PBA allocation calculations
>
>David Brownell (4):
>      V4L/DVB (5014): Allyesconfig build fixes on some non x86 arch
>      SPI: define null tx_buf to mean "shift out zeroes"
>      m25p80 build fixes (with MTD debug)
>      SPI/MTD: mtd_dataflash oops prevention
>
>David S. Miller (5):
>      [SPARC64]: Fix "mem=xxx" handling.
>      [SPARC64]: Fix of_iounmap() region release.
>      [SPARC64]: Update defconfig.
>      [SPARC64]: Handle ISA devices with no 'regs' property.
>      [NET]: Add memory barrrier to netif_poll_enable()
>
>David Woodhouse (1):
>      [NET]: Don't export linux/random.h outside __KERNEL__.
>
>Dimitri Gorokhovik (2):
>      ramfs breaks without CONFIG_BLOCK
>      MM: SLOB is broken by recent cleanup of slab.h
>
>Dwaine Garden (1):
>      V4L/DVB (4979): Fixes compilation when CONFIG_V4L1_COMPAT is not
> selected
>
>Eric Moore (1):
>      MAINTAINERS: email addr change for Eric Moore
>
>Francois Romieu (3):
>      netpoll: drivers must not enable IRQ unconditionally in their NAPI
> handler r8169: use the broken_parity_status field in pci_dev
>      r8169: extraneous Cmd{Tx/Rx}Enb write
>
>Hans Verkuil (6):
>      V4L/DVB (4967): Add missing tuner module option pal=60 for PAL-60
> support. V4L/DVB (4968): Add PAL-60 support for cx2584x.
>      V4L/DVB (4982): Fix broken audio mode handling for line-in in
> msp3400. V4L/DVB (4983): Force temporal filter to 0 when scaling to
> prevent ghosting. V4L/DVB (4984): LOG_STATUS should show the real
> temporal filter value. V4L/DVB (4988): Cx2341x audio_properties is an
> u16, not u8
>
>Herbert Xu (1):
>      e1000: Do not truncate TSO TCP header with 82544 workaround
>
>Hynek Petrak (1):
>      PHY probe not working properly for ibm_emac (PPC4xx)
>
>Ingo Molnar (4):
>      change WARN_ON back to "BUG: at ..."
>      rcu: rcutorture suspend fix
>      sched: fix cond_resched_softirq() offset
>      kvm: fix GFP_KERNEL allocation in atomic section in
> kvm_dev_ioctl_create_vcpu()
>
>Jan Andersson (1):
>      sparc32: add offset in pci_map_sg()
>
>Jean Delvare (1):
>      V4L/DVB (5010): Cx88: Fix leadtek_eeprom tagging
>
>Jeff Garzik (5):
>      e1000: For sanity, reformat e1000_set_mac_type(), struct
> e1000_hw[_stats] e1000: omit stats for broken counter in 82543
>      e1000: consolidate managability enabling/disabling
>      e1000: workaround for the ESB2 NIC RX unit issue
>      e1000: 3 new driver stats for managability testing
>
>Jeff Kirsher (1):
>      e1000: fix ethtool reported bus type for older adapters
>
>Jesse Brandeburg (7):
>      e1000: The user-supplied itr setting needs the lower 2 bits masked
> off e1000: dynamic itr: take TSO and jumbo into account
>      e1000: Fix Wake-on-Lan with forced gigabit speed
>      e1000: disable TSO on the 82544 with slab debugging
>      e1000: narrow down the scope of the tipg timer tweak
>      e1000: Make the copybreak value a module parameter
>      e1000: No-delay link detection at interface up
>
>Jiri Slaby (2):
>      Char: mxser, fix oops when removing opened
>      Char: isicom, eliminate spinlock recursion
>
>Judith Lebzelter (1):
>      powerpc iseries link error in allmodconfig
>
>KAMEZAWA Hiroyuki (1):
>      fix oom killer kills current every time if there is
> memory-less-node take2
>
>Kyungmin Park (2):
>      ARM: OMAP: fix GPMC compiler errors
>      ARM: OMAP: fix missing header on apollon board
>
>Lennert Buytenhek (1):
>      Update CREDITS and MAINTAINERS entries for Lennert Buytenhek
>
>Linus Torvalds (2):
>      VM: Fix nasty and subtle race in shared mmap'ed page writeback
>      Linux 2.6.20-rc3
>
>Mario Rossi (2):
>      V4L/DVB (4955): Fix autosearch index
>      V4L/DVB (4956): [NOVA-T-USB2] Put remote-debugging in the right
> place
>
>Mark Fasheh (4):
>      ocfs2: don't print error in ocfs2_permission()
>      ocfs2: Allow direct I/O read past end of file
>      ocfs2: ignore NULL vfsmnt in ocfs2_should_update_atime()
>      ocfs2: always unmap in ocfs2_data_convert_worker()
>
>Martin Willi (1):
>      [XFRM]: Algorithm lookup using .compat name
>
>Mauro Carvalho Chehab (3):
>      V4L/DVB (4960): Removal of unused code from usbvision-i2c.c
>      V4L/DVB (4980): Fixes bug 7267: PAL/60 is not working
>      V4L/DVB (5001): Add two required headers on kernel 2.6.20-rc1
>
>Melissa Howland (1):
>      [S390] Change max. buffer size for monwriter device.
>
>Michael Holzheu (1):
>      [S390] cio: fix stsch_reset.
>
>Michael Krufky (1):
>      V4L/DVB (4973): Dvb-core: fix printk type warning
>
>Michael S. Tsirkin (1):
>      IB/mthca: Fix FMR breakage caused by kmemdup() conversion
>
>Mikael Pettersson (1):
>      fix mrproper incompleteness
>
>Mike Frysinger (1):
>      respect srctree/objtree in Documentation/DocBook/Makefile
>
>Nguyen Anh Quynh (1):
>      KVM: Rename some msrs
>
>Oleg Nesterov (1):
>      restore ->pdeath_signal behaviour
>
>Ralf Baechle (1):
>      V4L/DVB (4958): Fix namespace conflict between w9968cf.c on MIPS
>
>Randy Dunlap (3):
>      via-velocity uses INET interfaces
>      pci/probe: fix macro that confuses kernel-doc
>      cciss: build with PROC_FS=n
>
>Sebastien DuguÃ© (1):
>      Fix IPMI watchdog set_param_str() using kstrdup
>
>Sergei Shtylyov (2):
>      PIIX: remove check for broken MW DMA mode 0
>      PIIX/SLC90E66: PIO mode fallback fix
>
>Shantanu Goel (1):
>      Buglet in vmscan.c
>
>Soeren Sonnenburg (1):
>      make fn_keys work again on power/macbooks
>
>Stefan Richter (2):
>      ieee1394: sbp2: pass REQUEST_SENSE through to the target
>      ieee1394: sbp2: fix bogus dma mapping
>
>Stephan Berberig (1):
>      V4L/DVB (4992): Fix typo in saa7134-dvb.c
>
>Stephen Hemminger (4):
>      netxen: remove private ioctl
>      sky2: dual port NAPI problem
>      sky2: power management/MSI workaround
>      sky2: phy power down needs PCI config write enabled
>
>Thierry MERLE (1):
>      V4L/DVB (4970): Usbvision memory fixes
>
>Thomas Meyer (1):
>      Add .gitignore file for relocs in arch/i386
>
>Tilman Schmidt (1):
>      Update to Documentation/tty.txt on line disciplines
>
>Ulrich Kunitz (3):
>      zd1211rw: Call ieee80211_rx in tasklet
>      ieee80211softmac: Fix errors related to the work_struct changes
>      ieee80211softmac: Fix mutex_lock at exit of
> ieee80211_softmac_get_genie
>
>Yan Burman (1):
>      ep93xx: some minor cleanups to the ep93xx eth driver
>
>Yoshimi Ichiyanagi (1):
>      KVM: Initialize kvm_arch_ops on unload
>
>Zach Brown (1):
>      Fix lock inversion aio_kick_handler()
>
>Zhen Wei (1):
>      ocfs2: export heartbeat thread pid via configfs
>
>audetto@tiscali.it (1):
>      V4L/DVB (4964): VIDEO_PALETTE_YUYV and VIDEO_PALETTE_YUV422 are
> the same palette
>
>---
> CREDITS                                         |    7 +-
> Documentation/DocBook/Makefile                  |    4 +-
> Documentation/filesystems/fuse.txt              |    4 +-
> Documentation/tty.txt                           |  111 +++++++-
> MAINTAINERS                                     |  132 +++++++++-
> Makefile                                        |    4 +-
> arch/arm/mach-omap2/board-apollon.c             |    1 +
> arch/arm/mach-omap2/gpmc.c                      |   21 +-
> arch/i386/boot/compressed/.gitignore            |    1 +
> arch/i386/defconfig                             |    2 +-
> arch/sparc/kernel/ioport.c                      |    5 +-
> arch/sparc64/defconfig                          |   36 ++-
> arch/sparc64/kernel/isa.c                       |   20 +-
> arch/sparc64/kernel/of_device.c                 |    7 +-
> arch/sparc64/mm/init.c                          |  147 ++++++++--
> arch/x86_64/defconfig                           |    2 +-
> drivers/block/cciss.c                           |    3 +-
> drivers/char/ipmi/ipmi_watchdog.c               |   11 +-
> drivers/char/isicom.c                           |  103 ++++----
> drivers/char/mxser.c                            |    1 +
> drivers/char/mxser_new.c                        |    1 +
> drivers/ide/pci/piix.c                          |   66 ++----
> drivers/ide/pci/slc90e66.c                      |   20 +-
> drivers/ieee1394/sbp2.c                         |   83 +++---
> drivers/infiniband/hw/mthca/mthca_provider.c    |    3 +-
> drivers/input/serio/i8042-sparcio.h             |    6 +-
> drivers/kvm/kvm.h                               |   18 +-
> drivers/kvm/kvm_main.c                          |   98 ++++++-
> drivers/kvm/mmu.c                               |   26 +-
> drivers/kvm/paging_tmpl.h                       |    4 +-
> drivers/kvm/svm.c                               |   52 +----
> drivers/kvm/vmx.c                               |   75 ++----
> drivers/kvm/vmx.h                               |   10 +-
> drivers/macintosh/via-pmu-backlight.c           |    2 +-
> drivers/media/common/ir-functions.c             |    1 +
> drivers/media/dvb/dvb-core/dvb_net.c            |    4 +-
> drivers/media/dvb/dvb-usb/nova-t-usb2.c         |    4 +-
> drivers/media/dvb/frontends/dib3000mc.c         |    2 +-
> drivers/media/video/Kconfig                     |    2 +-
> drivers/media/video/bt8xx/bttv-driver.c         |    4 +-
> drivers/media/video/cafe_ccic.c                 |    2 +-
> drivers/media/video/cpia2/cpia2_usb.c           |    4 +
> drivers/media/video/cx2341x.c                   |   21 +-
> drivers/media/video/cx25840/cx25840-vbi.c       |    9 +-
> drivers/media/video/cx88/cx88-cards.c           |    2 +-
> drivers/media/video/cx88/cx88-core.c            |   35 ++-
> drivers/media/video/cx88/cx88.h                 |    2 +-
> drivers/media/video/em28xx/em28xx-video.c       |    4 +-
> drivers/media/video/meye.c                      |    4 +-
> drivers/media/video/msp3400-driver.c            |    8 +-
> drivers/media/video/msp3400-kthreads.c          |   11 +-
> drivers/media/video/saa7134/saa7134-dvb.c       |    8 +-
> drivers/media/video/tuner-core.c                |    4 +
> drivers/media/video/usbvision/usbvision-cards.c |   11 +-
> drivers/media/video/usbvision/usbvision-core.c  |   83 ++----
> drivers/media/video/usbvision/usbvision-i2c.c   |   35 +--
> drivers/media/video/usbvision/usbvision-video.c |  150 ++++++----
> drivers/media/video/usbvision/usbvision.h       |   27 --
> drivers/media/video/vivi.c                      |    8 +-
> drivers/media/video/w9966.c                     |    2 +-
> drivers/media/video/w9968cf.c                   |   24 +-
> drivers/media/video/zoran_device.c              |    3 +-
> drivers/mtd/devices/m25p80.c                    |    4 +-
> drivers/mtd/devices/mtd_dataflash.c             |    2 +-
> drivers/net/8139cp.c                            |    6 +-
> drivers/net/arm/ep93xx_eth.c                    |    4 +-
> drivers/net/b44.c                               |    6 +-
> drivers/net/e1000/e1000_ethtool.c               |    3 +
> drivers/net/e1000/e1000_hw.c                    |  296
> ++++++++++--------- drivers/net/e1000/e1000_hw.h                    | 
> 310 +++++++++++---------- drivers/net/e1000/e1000_main.c               
>   |  345 ++++++++++++++++------- drivers/net/e1000/e1000_param.c       
>          |    4 +-
> drivers/net/forcedeth.c                         |   16 +-
> drivers/net/ibm_emac/ibm_emac_phy.c             |    4 +-
> drivers/net/myri10ge/myri10ge.c                 |  163 +++++------
> drivers/net/netxen/netxen_nic.h                 |   25 +--
> drivers/net/netxen/netxen_nic_ethtool.c         |    5 +-
> drivers/net/netxen/netxen_nic_hw.c              |  296
> +------------------- drivers/net/netxen/netxen_nic_init.c            | 
> 251 +---------------- drivers/net/netxen/netxen_nic_ioctl.h           |
>   77 -----
> drivers/net/netxen/netxen_nic_isr.c             |    3 +-
> drivers/net/netxen/netxen_nic_main.c            |   85 ++-----
> drivers/net/r8169.c                             |    6 +-
> drivers/net/skge.c                              |    5 +-
> drivers/net/sky2.c                              |   35 +++-
> drivers/net/via-velocity.c                      |   18 +-
> drivers/net/wireless/zd1211rw/zd_mac.c          |   96 +++++--
> drivers/net/wireless/zd1211rw/zd_mac.h          |    5 +-
> drivers/net/wireless/zd1211rw/zd_usb.c          |    4 +-
> drivers/pci/probe.c                             |    5 +-
> drivers/s390/char/monwriter.c                   |    2 +-
> drivers/s390/cio/cio.c                          |   13 +-
> drivers/scsi/ibmvscsi/Makefile                  |    2 +
> drivers/serial/sunsab.c                         |   11 +-
> drivers/serial/sunsu.c                          |   10 +-
> drivers/serial/sunzilog.c                       |   14 +-
> drivers/spi/spi_mpc83xx.c                       |    2 +
> drivers/spi/spi_s3c24xx.c                       |    2 +-
> drivers/spi/spi_s3c24xx_gpio.c                  |    2 +-
> drivers/usb/input/Kconfig                       |    2 +-
> drivers/video/bw2.c                             |   18 +-
> drivers/video/cg14.c                            |   28 +-
> drivers/video/cg3.c                             |   22 +-
> drivers/video/cg6.c                             |   33 ++-
> drivers/video/ffb.c                             |   25 +-
> drivers/video/leo.c                             |   29 +-
> drivers/video/p9100.c                           |   25 +-
> drivers/video/tcx.c                             |   33 ++-
> fs/aio.c                                        |    7 +-
> fs/ocfs2/aops.c                                 |   24 ++-
> fs/ocfs2/cluster/heartbeat.c                    |   17 ++
> fs/ocfs2/dlmglue.c                              |   10 +-
> fs/ocfs2/file.c                                 |   13 +-
> fs/ramfs/file-mmu.c                             |    4 +-
> fs/ramfs/file-nommu.c                           |    4 +-
> include/asm-generic/bug.h                       |    2 +-
> include/asm-sparc/of_device.h                   |    2 +-
> include/asm-sparc64/of_device.h                 |    2 +-
> include/linux/cpuset.h                          |    2 +-
> include/linux/net.h                             |    2 +-
> include/linux/netdevice.h                       |    1 +
> include/linux/spi/spi.h                         |    2 +-
> include/media/cx2341x.h                         |    2 +-
> include/media/ir-common.h                       |    1 +
> kernel/cpuset.c                                 |    2 +-
> kernel/exit.c                                   |    8 +-
> kernel/lockdep.c                                |    8 +-
> kernel/module.c                                 |    4 +-
> kernel/rcutorture.c                             |    3 +
> kernel/sched.c                                  |   18 +-
> mm/oom_kill.c                                   |    7 +-
> mm/page-writeback.c                             |   45 +++-
> mm/rmap.c                                       |    2 +-
> mm/slob.c                                       |   11 +-
> mm/vmscan.c                                     |    2 +-
> net/ieee80211/softmac/ieee80211softmac_assoc.c  |    4 +-
> net/ieee80211/softmac/ieee80211softmac_wx.c     |    2 +-
> net/xfrm/xfrm_algo.c                            |    3 +-
> 138 files changed, 2077 insertions(+), 2049 deletions(-)
> create mode 100644 arch/i386/boot/compressed/.gitignore
> delete mode 100644 drivers/net/netxen/netxen_nic_ioctl.h

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
