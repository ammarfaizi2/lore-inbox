Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbUAHKnC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUAHKnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:43:01 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:41700
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S264303AbUAHKmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:42:13 -0500
Message-ID: <3FFD3842.4020604@reactivated.net>
Date: Thu, 08 Jan 2004 11:00:18 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       c-d.hailfinger.kernel.2003@gmx.net
Subject: Re: 2.6.1-rc2-mm1
References: <20040107232831.13261f76.akpm@osdl.org>
In-Reply-To: <20040107232831.13261f76.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070905080705080808010504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905080705080808010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Could you please update the forcedeth driver (GPL nforce-net) for the next 
mm-release? V20 is available from 
http://www.hailfinger.org/carldani/linux/patches/forcedeth/ but I have 
included an incremental patch from v19 to v20 in this mail (applies cleanly 
against 2.6.1-rc2-mm1).

Thanks

Daniel

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc2/2.6.1-rc2-mm1/
> 
> 
> 
> - Some rework to the mt-ranier CDROM support and ATAPI access to MO drives.
>   Could anyone who uses these please retest.
> 
> - A fix for loop-on-ext2-on-cdrom.  Also needs testing please.
> 
> - A significant amount of work on remap_file_pages() from Ingo.  Most
>   notably, we now support per-page protections within a single VMA.  This is
>   aimed at UML and similar specialised applications which are presently
>   forced to allocate one VMA per page.
> 
>   Anyone who is interested in remap_file_pages(), please test.
> 
>   This adds a new syscall and breaks all non-ia32 architectures. 
>   Instructions as to how to unbreak them is in the
>   remap_file_pages-prot-2.6.1-H2 patch.
> 
> - The remap_file_pages non-blocking infrastructure has been used to
>   implement prefaulting of minor faults for mappings.  This will reduce the
>   kernel's minor fault rate by up to a factor of eight and has been shown to
>   offer a few percent speedup on some things.
> 
>   This needs serious benchmarking please.  Tests which involve short-lived
>   processes.
> 
>   The remap_file_pages work will probably live in -mm for a while.  It
>   needs careful review - alterations to largely unused code paths are a
>   concern because of the potential for long-lived security and DoS holes.
> 
> - Added an implementation of RAID6 from Peter Anvin.  Usage information is
>   available in the Kconfig help for the feature.  I'm sure he'd like to
>   hear of testing results.
> 
> - There's a fix for the Radeon framebuffer card here which we're a bit
>   wobbly about.  if you have such a thing, please send a report.
> 
> - Significant amount of rework of the ACPI PM timer source patch.  I'm not
>   sure that I got all the right patches in the right place.  John and
>   Dominik, please double-check.
> 
> - Added the latest code drop from DRM CVS.  People who use DRM, please test
>   it.
> 
> 
> 
> 
> 
> Changes since 2.6.1-rc1-mm2:
> 
> +linus.patch
> 
>  Latest Linus tree
> 
> -msi-build-fix.patch
> -sysfs-oops-fix.patch
> -x86_64-memset-fix.patch
> -jfs-nfs-le-fix.patch
> -pnp-bios-fix.patch
> -sched_clock-2.6.0-A1-deadlock-fix.patch
> -ide-tape-rq-special.patch
> -ide-cmd640-pci1.patch
> -ide-recovery-time.patch
> -amd-k8-fixes.patch
> -cpufreq-memleak-fix.patch
> -alpha-relocation-fix.patch
> 
>  Merged
> 
> +kgdb-doc-fix.patch
> 
>  Documentation fix
> 
> +ppc64-proc-fixes.patch
> +ppc64-missing-section-definition.patch
> 
>  ppc64 fixes
> 
> +ppc64-proc-fixes.patch
> +ppc64-missing-section-definition.patch
> 
>  ppc64 fixes
> 
> +scsi-rename-TIMEOUT.patch
> 
>  scsi build fix
> 
> +loop-fix-hardsect.patch
> 
>  Reworked version of the patch to fix the underlying hard sector size of the
>  loop blockdev.
> 
> -RD1-cdrom_ioctl-B6.patch
> -RD2-ioctl-B6.patch
> -RD2-ioctl-B6-fix.patch
> -RD3-cdrom_open-B6.patch
> -RD4-open-B6.patch
> -RD5-cdrom_release-B6.patch
> -RD6-release-B6.patch
> -RD7-presto_journal_close-B6.patch
> -RD8-f_mapping-B6.patch
> -RD9-f_mapping2-B6.patch
> -RD10-i_sem-B6.patch
> -RD11-f_mapping3-B6.patch
> -RD12-generic_osync_inode-B6.patch
> -RD13-bd_acquire-B6.patch
> -RD14-generic_write_checks-B6.patch
> -RD15-I_BDEV-B6.patch
> +RD1-open-mm.patch
> +RD2-release-mm.patch
> +RD3-presto_journal_close-mm.patch
> +RD4-f_mapping-mm.patch
> +RD5-f_mapping2-mm.patch
> +RD6-i_sem-mm.patch
> +RD7-f_mapping3-mm.patch
> +RD8-generic_osync_inode-mm.patch
> +RD9-bd_acquire-mm.patch
> +RD10-generic_write_checks-mm.patch
> +RD11-I_BDEV-mm.patch
> 
>  Updated version of Al Viro's prepare-blockdevs-for-hotswap patch series.
> 
> -psmouse-parameter-parsing-fix.patch
> 
>  I was told to drop this.
> 
> +keyboard-repeat-fix.patch
> 
>  Fix rawmode enulation of PrintScreen key.
> 
> -qla1280-update.patch
> +qla1280-update-2.patch
> 
>  Updated qlogic patch
> 
> +ramdisk-leak-fix.patch
> 
>  Fix resource leak in ramdisk driver init error paths
> 
> -acpi-pm-timer-fixes-2.patch
> +acpi-timer-fixes-A5.patch
> +timer_pm-warning-fix.patch
> -timer_pm-verbose-timesource-fix.patch
> -timer_pm-wraparound-fixes.patch
> 
>  Various ACPI PM timer fixes
> 
> -cdrom_open-fix.patch
> 
>  Merged into atapi-mo-support-update.patch
> 
> +sysfs-add-oss-class.patch
> +sysfs-add-alsa-class.patch
> +sysfs-add-input-class-support.patch
> 
>  More sysfs class support in subsystems
> 
> -nforce2-disconnect-quirk.patch
> -nforce2-apic.patch
> 
>  Bart said to kill these.
> 
> +make-for_each_cpu-iterator-more-friendly-fix.patch
> 
>  Fix this for Alpha CPUs
> 
> +watchdog-updates-2.patch
> 
>  Minor watchdog driver updates
> 
> +laptop-mode-doc-update.patch
> 
>  Fix "laptop mode" docs
> 
> +start_this_handle-retval-fix.patch
> 
>  Fix potential oops in ext3.
> 
> +remove-eicon-isdn-driver.patch
> 
>  Remove defunct ISDN driver.
> 
> +remap_file_pages-fixes-2.6.1-A3.patch
> 
>  Fixes to remap_file_pages()
> 
> +remap_file_pages-prot-2.6.1-H2.patch
> 
>  per-page protections in remap_file_pages() 
> 
> +prefault-2.6.0-A0.patch
> 
>  Prefaulting for minot faults
> 
> +vt-locking-fixes.patch
> +vt-locking-fixes-warning-fix.patch
> 
>  Fix virtual terminal locking
> 
> +pid_max-fix.patch
> 
>  Fix pid allocation off-by-one for >32768 pids
> 
> +allow-SGI-IOC4-chipset-support.patch
> 
>  Kconfig tweak
> 
> +oss-dmabuf-deadlock-fix.patch
> 
>  ODD driver locking fix
> 
> +workqueue-cleanup.patch
> 
>  Cleanup workqueue signal handling
> 
> +libata-update.patch
> 
>  Update to the SATA drivers
> 
> +tridentfb-documentation-fix.patch
> 
>  Documentation fix
> 
> +proc_pid_lookup-speedup.patch
> 
>  Make proc_pid_lookup() faster
> 
> +bio_endio-clarifications.patch
> 
>  bio_endio cleanupand documentation
> 
> +rtc-leak-fixes.patch
> 
>  Fix minor kernel->userspace information leakage
> 
> +simplify-node-zone-fields-3.patch
> 
>  Cleanup mm things
> 
> +r8169-oops-fix.patch
> 
>  Fix an oops in this net driver
> 
> +radeonfb-pdi-id-addition.patch
> 
>  New PCI ID
> 
> +mpt-fusion-update.patch
> 
>  Vendor driver update
> 
> +use-soft-float.patch
> 
>  Add -msoft-float so we pick up accidental use of floating point in the
>  kernel.
> 
> +DRM-cvs-update.patch
> 
>  Latest DRM CVS tree.
> 
> +raid6-20040107.patch
> 
>  RAID6
> 
> +m68knommu-module-support.patch
> +m68knommu-module-support-2.patch
> +m68knommu-sched_clock.patch
> +m68knommu-include-fix.patch
> +m68knommu-cpustats-fix.patch
> +m68knommu-types-cleanup.patch
> +m68knommu-find_extend_vma.patch
> 
>  no-MMU mode m68k updates.
> 
> -printk-oops-mangle-fix.patch
> 
>  This got rejects and I lost interest in it.
> 
> 
> 
> 
> All 294 patches
> 
> linus.patch
> 
> mm.patch
>   add -mmN to EXTRAVERSION
> 
> 2.6.0-rc1-netdrvr-exp1.patch
> 
> kgdb-ga.patch
>   kgdb stub for ia32 (George Anzinger's one)
>   kgdbL warning fix
>   kgdb buffer overflow fix
>   kgdbL warning fix
>   kgdb: CONFIG_DEBUG_INFO fix
>   x86_64 fixes
> 
> kgdb-doc-fix.patch
>   correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)
> 
> kgdboe-netpoll.patch
>   kgdb-over-ethernet via netpoll
> 
> kgdboe-non-ia32-build-fix.patch
> 
> ppc64-proc-fixes.patch
>   /proc/ppc64 and /proc/iSeries fixes from Linas Vepstas
> 
> ppc64-missing-section-definition.patch
>   ppc64: Add missing section definition
> 
> radeon-line-length-fix.patch
>   radeonfb line length fix
> 
> scsi-rename-TIMEOUT.patch
>   fix scsi.h #define collision
> 
> loop-fix-hardsect.patch
>   loop: fix hard sector size
> 
> must-fix.patch
>   must fix lists update
>   must fix list update
>   mustfix update
> 
> must-fix-update-5.patch
>   must-fix update
> 
> RD1-open-mm.patch
> 
> RD2-release-mm.patch
> 
> RD3-presto_journal_close-mm.patch
> 
> RD4-f_mapping-mm.patch
> 
> RD5-f_mapping2-mm.patch
> 
> RD6-i_sem-mm.patch
> 
> RD7-f_mapping3-mm.patch
> 
> RD8-generic_osync_inode-mm.patch
> 
> RD9-bd_acquire-mm.patch
> 
> RD10-generic_write_checks-mm.patch
> 
> RD11-I_BDEV-mm.patch
> 
> cramfs-use-pagecache.patch
>   cramfs: use pagecache better
> 
> invalidate_inodes-speedup.patch
>   invalidate_inodes speedup
>   more invalidate_inodes speedup fixes
> 
> net-jiffy-normalisation-fix.patch
>   NET: Normalize jiffies reported to userspace, in neighbor management code
> 
> input-mousedev-remove-jitter.patch
>   Input: smooth out mouse jitter
> 
> input-mousedev-ps2-emulation-fix.patch
>   mousedev PS/@ emulation fix
> 
> input-01-i8042-suspend.patch
>   input: i8042 suspend
> 
> input-02-i8042-option-parsing.patch
>   input: i8042 option parsing
> 
> input-03-psmouse-option-parsing.patch
>   input: psmouse option parsing
> 
> input-04-atkbd-option-parsing.patch
>   input: atkbd option parsing
> 
> input-05-missing-module-licenses.patch
>   input: missing module licenses
> 
> input-06-Kconfig-Synaptics-help.patch
>   Kconfig Synaptics help
> 
> input-07-sis-aux-port.patch
>   input: SiS AUX port
> 
> input-11-98busmouse-compile-fix.patch
>   Fix compile error in 98busmouse.c module
> 
> input-12-mouse-drivers-use-module_param.patch
>   Convert mouse drivers to use module_param
> 
> input-13-tsdev-use-module_param.patch
>   Convert tsdev to use module_param
> 
> keyboard-repeat-fix.patch
>   Fix key repeat problems
> 
> input-use-after-free-checks.patch
>   input layer debug checks
> 
> cpu_sibling_map-fix.patch
>   cpu_sibling_map fix
> 
> acpi-20031203.patch
> 
> acpi-20031203-fix.patch
> 
> cfq-4.patch
>   CFQ io scheduler
>   CFQ fixes
> 
> config_spinline.patch
>   uninline spinlocks for profiling accuracy.
> 
> ppc64-syscall6-macro.patch
>   add syscall6 macro to ppc64
> 
> ppc64-sched_clock-2.patch
>   ppc64: add sched_clock
> 
> ppc64-32bit-compat-update.patch
>   ppc64: 32bit compat update
> 
> ppc64-OF-device-tree-update.patch
>   ppc64: Change to new OF device tree API
> 
> ppc64-numa-sign-extension-fix-2.patch
>   ppc64: fix sign extension in numa code
> 
> ppc64-bar-0-fix.patch
>   Allow PCI BARs that start at 0
> 
> ppc64-reloc_hide.patch
> 
> ppc64-IRQ_INPROGRESS-fix.patch
>   ppc64: revert IRQ_INPROGRESS change
> 
> sn-console-update.patch
>   ia64 sn console fixes
> 
> sn-serial-medusa-fix.patch
>   ia64 sn2 "medusa" serial console fix
> 
> qla1280-update-2.patch
>   qla1280 update
> 
> sym-speed-fix.patch
>   sym2 Ultra-160 fix
> 
> aic7xxx_old-proc-oops-fix.patch
>   aic7x_old /proc oops fix
> 
> aic7xxx_old-oops-fix.patch
> 
> ramdisk-leak-fix.patch
>   fix memory leak in ram disk
> 
> ramdisk-cleanup.patch
> 
> intel8x0-cleanup.patch
>   intel8x0 cleanups
> 
> pdflush-diag.patch
> 
> zap_page_range-debug.patch
>   zap_page_range() debug
> 
> asus-L5-fix.patch
>   Asus L5 framebuffer fix
> 
> jffs-use-daemonize.patch
> 
> get_user_pages-handle-VM_IO.patch
> 
> support-zillions-of-scsi-disks.patch
>   support many SCSI disks
> 
> pci_set_power_state-might-sleep.patch
> 
> CONFIG_STANDALONE-default-to-n.patch
>   Make CONFIG_STANDALONE default to N
> 
> extra-buffer-diags.patch
> 
> CONFIG_SYSFS.patch
>   From: Pat Mochel <mochel@osdl.org>
>   Subject: [PATCH] Add CONFIG_SYSFS
> 
> CONFIG_SYSFS-boot-from-disk-fix.patch
> 
> slab-leak-detector.patch
>   slab leak detector
> 
> loop-module-alias.patch
>   loop needs MODULE_ALIAS_BLOCK
> 
> loop-bio-index-fix.patch
>   loop bio indexing fix
> 
> loop-highmem.patch
>   remove useless highmem bounce from loop/cryptoloop
> 
> loop-bio-clone.patch
>   loop bio clone optimisation
> 
> loop-recycle.patch
>   loop bio recycling optimisation
> 
> acpi-pm-timer.patch
>   ACPI PM Timer
> 
> acpi-timer-fixes-A5.patch
>   ACPI PM timer fixes
> 
> timer_pm-warning-fix.patch
> 
> as-regression-fix.patch
>   Fix IO scheduler regression
> 
> as-request-poisoning.patch
>   AS: request poisoning
> 
> as-request-poisoning-fix.patch
>   AS: request poisining fix
> 
> as-fix-all-known-bugs.patch
>   AS fixes
> 
> as-new-process-estimation.patch
>   AS: new process estimation
> 
> as-cooperative-thinktime.patch
>   AS: thinktime improvement
> 
> scale-nr_requests.patch
>   scale nr_requests with TCQ depth
> 
> truncate_inode_pages-check.patch
> 
> local_bh_enable-warning-fix.patch
> 
> pnp-fix-2.patch
>   PnP Fixes #2
> 
> pnp-fix-3.patch
>   PnP Fixes #3
> 
> alpha-stack-dump.patch
> 
> sysfs_remove_dir-vs-dcache_readdir-race-fix.patch
>   sysfs_remove_dir Vs dcache_readdir race fix
> 
> invalidate_mmap_range-non-gpl-export.patch
>   mark invalidate_mmap_range() as EXPORT_SYMBOL
> 
> alsa-sleep-in-spinlock-fix.patch
>   ALSA sleep in spinlock fix
> 
> sym2-speed-selection-fix.patch
>   Speed selection fix for sym53c8xx
> 
> ppc-export-consistent_sync_page.patch
>   PPC32: Export consistent_sync_page.
> 
> ppc-use-EXPORT_SYMBOL_NOVERS.patch
>   PPC32: Change all EXPORT_SYMBOL_NOVERS to EXPORT_SYMBOL in ppc_ksyms.c
> 
> ppc-CONFIG_PPC_STD_MMU-fix.patch
>   PPC32: Select arch/ppc/kernel/head.S on CONFIG_PPC_STD_MMU.
> 
> ppc-IBM-MPC-header-cleanups.patch
>   PPC32: Minor cleanups to IBM4xx and MPC82xx headers.
> 
> xfs-update-01.patch
>   XFS update
> 
> percpu-gcc-34-warning-fix.patch
>   fix gcc-3.4 warning in percpu code
> 
> nr_requests-oops-fix.patch
>   Fix oops when modifying /sys/block/dm-0/queue/nr_requests
> 
> netfilter_bridge-compile-fix.patch
> 
> aacraid-warning-fix.patch
>   aacraid warning fix
> 
> atapi-mo-support.patch
>   ATAPI MO drive support
> 
> mt-ranier-support.patch
>   mt rainier support
> 
> atapi-mo-support-update.patch
>   ATAPI MO support update
>   cdrom_open fix
> 
> alsa-gus-scheduling-in-interrupt-fix.patch
>   alsa gus max schedule-in-irq-fix
> 
> ppp_async-locking-fix.patch
>   Make ppp_async callable from hard interrupt
> 
> make-try_to_free_pages-walk-zonelist.patch
>   make try_to_free_pages walk zonelist
> 
> make-try_to_free_pages-walk-zonelist-fix.patch
>   zone scanning fix
> 
> remove-CardServices-from-pcmcia-net-drivers.patch
>   CardServices() removal from pcmcia net drivers
> 
> remove-CardServices-from-ide-cs.patch
>   From: Arjan van de Ven <arjanv@redhat.com>
>   Subject: Re: [PATCH 1/10] CardServices() removal from pcmcia net drivers
> 
> remove-CardServices-from-drivers-net-wireless.patch
>   remove CardServices() from drivers/net/wireless
> 
> remove-CardServices-from-drivers-serial.patch
>   Remvoe CardServices() from drivers/serial
> 
> remove-CardServices-from-drivers-serial-fix.patch
>   serial_cs CardServices removal fix
> 
> remove-CardServices-from-axnet_cs.patch
>   remvoe CardServices from axnet_cs
> 
> remove-CardServices-final.patch
>   final CardServices() removal patches
> 
> CardServices-compatibility-layer.patch
>   CardServices compatibility layer
> 
> const-fixes.patch
>   const vs. __attribute__((const)) confusion
> 
> s390-const-fixes.patch
>   s390 const fixes
> 
> sysfs-add-simple-class-device-support.patch
>   sysfs: add "simple" class device support
> 
> sysfs-remove-tty-class-device-logic.patch
>   sysfs: remove tty class device logic
> 
> sysfs-add-mem-device-support.patch
>   sysfs: add mem class
> 
> sysfs-add-misc-class.patch
>   sysfs: add misc class
> 
> vc-init-race-fix.patch
>   virtual consle initialisation race fix
> 
> sysfs-add-video-class.patch
>   sysfs: add video class
> 
> sysfs-add-oss-class.patch
>   sysfs sound class patch for OSS drivers
> 
> sysfs-add-alsa-class.patch
>   sysfs sound class patch for ALSA drivers
> 
> sysfs-add-input-class-support.patch
>   sysfs: input class patch
> 
> tridentfb-non-flatpanel-fix.patch
>   fix for tridentfb.c usage on CRTs.
> 
> CONFIG_EPOLL-file_struct-members.patch
>   CONFIG_EPOLL=n space reduction
> 
> epoll-oneshot-support.patch
>   One-shot support for epoll
> 
> kill_fasync-speedup.patch
>   kill_fasync speedup
> 
> o21-sched.patch
>   O21 for interactivity 2.6.0
> 
> sched-clock-2.6.0-A1.patch
>   Relax synchronization of sched_clock()
> 
> sched-can-migrate-2.6.0-A2.patch
>   can_migrate_task cleanup
> 
> sched-cleanup-2.6.0-A2.patch
>   CPU scheduler cleanup
> 
> sched-style-2.6.0-A5.patch
>   sched.c style cleanups
> 
> decrypt-CONFIG_PDC202XX_FORCE-help.patch
>   Change cryptic description and help for CONFIG_PDC202XX_FORCE
> 
> ide-siimage-seagate.patch
> 
> ide-siimage-stack-fix.patch
> 
> ide-siimage-sil3114.patch
> 
> ide-pdc_old-pio-fix.patch
> 
> ide-pdc_old-udma66-fix.patch
> 
> ide-pdc_old-66mhz_clock-fix.patch
> 
> ide-pdc_new-proc.patch
> 
> make-for_each_cpu-iterator-more-friendly.patch
>   Make for_each_cpu() Iterator More Friendly
> 
> make-for_each_cpu-iterator-more-friendly-fix.patch
>   Fix alpha build failure
> 
> use-for_each_cpu-in-right-places.patch
>   Use for_each_cpu() Where It's Meant To Be
> 
> for_each_cpu-oprofile-fix.patch
>   for_each_cpu oprofile fix
> 
> for_each_cpu-oprofile-fix-2.patch
> 
> fa311-mac-address-fix.patch
>   wrong mac address with netgear FA311 ethernet card
> 
> kernel-locking-doc-end-tags-fix.patch
>   Missing end tags in kernel-locking kerneldoc
> 
> rcupdate-c99-initialisers.patch
>   C99 change to rcupdate.h
> 
> 68k-339.patch
>   M68k floppy selection
> 
> 68k-340.patch
>   M68k head console
> 
> 68k-341.patch
>   M68k head unused
> 
> 68k-342.patch
>   M68k head comments
> 
> 68k-343.patch
>   M68k head pic
> 
> 68k-344.patch
>   M68k head white space
> 
> 68k-345.patch
>   M68k cache mode
> 
> 68k-346.patch
>   M68k RMW accesses
> 
> 68k-347.patch
>   Atari Hades PCI C99
> 
> 68k-348.patch
>   Amiga sound C99
> 
> 68k-349.patch
>   BVME6000 RTC C99
> 
> 68k-350.patch
>   M68k symbol exports
> 
> 68k-351.patch
>   M68k math emu C99
> 
> 68k-352.patch
>   MVME16x RTC C99
> 
> 68k-353.patch
>   Q40 interrupts C99
> 
> 68k-354.patch
>   Sun-3 ID PROM C99
> 
> 68k-355.patch
>   Mac ADB IOP fix
> 
> 68k-359.patch
>   Mac ESP SCSI setup
> 
> 68k-360.patch
>   Mac SCSI
> 
> 68k-361.patch
>   Macfb setup
> 
> 68k-364.patch
>   Mac ADB
> 
> 68k-365.patch
>   ncr53c7xx SCSI
> 
> 68k-366.patch
>   BVME6000 SCSI
> 
> 68k-367.patch
>   Amiga Gayle IDE cleanup
> 
> 68k-368.patch
>   Amiga Gayle E-Matrix 530 IDE
> 
> 68k-369.patch
>   Zorro sysfs/driver model
> 
> 68k-374.patch
>   Amiga debug fix
> 
> 68k-375.patch
>   Mac II VIA
> 
> 68k-377.patch
>   M68k asm/system.h
> 
> 68k-378.patch
>   Amiga NCR53c710 SCSI
> 
> 68k-379.patch
>   Amiga core C99
> 
> 68k-380.patch
>   M68k has no VGA/MDA
> 
> 68k-381.patch
>   M68k thread
> 
> 68k-382.patch
>   M68k thread_info
> 
> 68k-383.patch
>   M68k extern inline
> 
> 68k-384.patch
>   NCR53C9x SCSI inline
> 
> 68k-385.patch
>   Cirrusfb extern inline
> 
> 68k-386.patch
>   Genrtc warning
> 
> 68k-387.patch
>   M68k Documentation
> 
> 68k-390.patch
>   Amiga Buddha/CatWeasel IDE
> 
> printk_ratelimit.patch
>   generalise net_ratelimit (printk_ratelimit)
> 
> printk_ratelimit-fix.patch
>   parintk_ratelimit fix
> 
> freevxfs-MODULE_ALIAS.patch
>   MODULE_ALIAS for freevxfs
> 
> trident-cleanup-indentation-D1-2.6.0.patch
>   reindent trident OSS sound driver
> 
> trident-sound-driver-fixes.patch
>   trident OSS sound driver fixes
> 
> trident-cleanup-2.patch
>   trident: use pr_debug instead of home-brewed TRDBG
> 
> compound-page-page_count-fix.patch
>   fix page counting for compound pages
> 
> inia100-fix.patch
>   fix inia100 driver
> 
> MAINTAINERS-lanana-update.patch
>   MAINTAINERS update
> 
> devfs-joystick-fix.patch
>   fix devfs names for joystick
> 
> s3-sleep-remove-debug-code.patch
>   s3 sleep: Kill obsolete debugging code
> 
> swsusp-doc-updates.patch
>   swsusp/sleep documentation update
> 
> watchdog-updates.patch
>   Watchdog patches
> 
> watchdog-updates-2.patch
>   Watchdog patches (part 2)
> 
> ext2_new_inode-cleanup.patch
>   ext2_new_inode nanocleanup
> 
> ext2-s_next_generation-fix.patch
>   ext2: s_next_generation locking
> 
> ext3-s_next_generation-fix.patch
>   ext3: s_next_generation fixes
> 
> alt-arrow-console-switch-fix.patch
>   Fix Alt-arrow console switch droppage
> 
> ia32-remove-SIMNOW.patch
>   Remove x86_64 leftover SIMNOW code
> 
> softcursor-fix.patch
>   Fix softcursor
> 
> ext2-debug-build-fix.patch
>   ext2: fix build when EXT2_DEBUG is set
> 
> efi-inline-fixes.patch
>   Fix weird placement of inline
> 
> do_timer_gettime-cleanup.patch
>   do_timer_gettime() cleanup
> 
> set_cpus_allowed-locking-fix.patch
>   set_cpus_allowed locking
> 
> set_cpus_allowed-locking-fix-fix.patch
>   fix set_cpus_allowed locking even more
> 
> rmmod-race-fix.patch
>   module removal race fix
> 
> remove-hpet-intel-check.patch
>   Remove Intel check in i386 HPET code
> 
> devfs-d_revalidate-oops-fix.patch
>   devfs d_revalidate race/oops fix
> 
> laptop-mode-2.patch
>   laptop-mode for 2.6, version 6
> 
> laptop-mode-doc-update.patch
>   Documentation/laptop-mode.txt
> 
> e1000-1019-fix.patch
>   e1000: device 1019 fix
> 
> ali-m1533-hang-fix.patch
>   ALI M1533 audio hang fix
> 
> start_this_handle-retval-fix.patch
>   jbd: start_this_handle() return value fix
> 
> remove-eicon-isdn-driver.patch
>   remove old Eicon isdn driver
> 
> remap_file_pages-fixes-2.6.1-A3.patch
>   remap_file_pages fixes
> 
> remap_file_pages-prot-2.6.1-H2.patch
>   remap_file_pages protection enhancements
> 
> prefault-2.6.0-A0.patch
>   pagefault prefaulting
> 
> vt-locking-fixes.patch
>   VT locking fixes
> 
> vt-locking-fixes-warning-fix.patch
> 
> pid_max-fix.patch
>   Bug when setting pid_max > 32k
> 
> allow-SGI-IOC4-chipset-support.patch
>   allow SGI IOC4 chipset support
> 
> oss-dmabuf-deadlock-fix.patch
>   OSS dmabuf deadlock fix
> 
> workqueue-cleanup.patch
>   Remove redundant code in workqueue.c
> 
> libata-update.patch
>   update libata
> 
> tridentfb-documentation-fix.patch
>   tridentfb documentation fix
> 
> proc_pid_lookup-speedup.patch
>   Optimize proc_pid_lookup
> 
> bio_endio-clarifications.patch
>   clarify meaning of bio fields in the end_io function
> 
> rtc-leak-fixes.patch
>   2.6.1 RTC leaks.
> 
> simplify-node-zone-fields-3.patch
>   Simplify node/zone field in page->flags
> 
> r8169-oops-fix.patch
>   erroneous __devinitdata in the r8169 driver
> 
> radeonfb-pdi-id-addition.patch
>   Identify RADEON Yd in radeonfb
> 
> mpt-fusion-update.patch
>   MPT Fusion driver 3.00.00 update
> 
> use-soft-float.patch
>   Use -msoft-float
> 
> DRM-cvs-update.patch
>   DRM cvs update
> 
> raid6-20040107.patch
>   RAID-6
> 
> m68knommu-module-support.patch
>   allow for building module support for m68knommu architecture
> 
> m68knommu-module-support-2.patch
>   add module support for m68knommu architecture
> 
> m68knommu-sched_clock.patch
>   sched_clock() for m68knommu architectures
> 
> m68knommu-include-fix.patch
>   m68knommu include fix
> 
> m68knommu-cpustats-fix.patch
>   fix cpu stats in m68knommu entry.S
> 
> m68knommu-types-cleanup.patch
>   use m68k/types.h for m68knommu
> 
> m68knommu-find_extend_vma.patch
>   implement find_extend_vma() for nommu
> 
> list_del-debug.patch
>   list_del debug check
> 
> print-build-options-on-oops.patch
> 
> show_task-free-stack-fix.patch
>   show_task() fix and cleanup
> 
> oops-dump-preceding-code.patch
>   i386 oops output: dump preceding code
> 
> lockmeter.patch
> 
> 4g-2.6.0-test2-mm2-A5.patch
>   4G/4G split patch
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g/4g usercopy atomicity fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   4G/4G preempt on vstack
>   4G/4G: even number of kmap types
>   4g4g: fix __get_user in slab
>   4g4g: Remove extra .data.idt section definition
>   4g/4g linker error (overlapping sections)
>   4G/4G: remove debug code
>   4g4g: pmd fix
>   4g/4g: fixes from Bill
>   4g4g: fpu emulation fix
>   4g4g: show_registers() fix
>   4g/4g usercopy atomicity fix
>   4g4g: debug flags fix
>   4g4g: Fix wrong asm-offsets entry
>   cyclone time fixmap fix
>   use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
>   4G/4G might_sleep warning fix
>   4g/4g pagetable accounting fix
>   Fix 4G/4G and WP test lockup
>   4G/4G KERNEL_DS usercopy again
>   Fix 4G/4G X11/vm86 oops
>   Fix 4G/4G athlon triplefault
>   4g4g SEP fix
>   Fix 4G/4G split fix for pre-pentiumII machines
> 
> 4g4g-locked-userspace-copy.patch
>   Do a locked user-space copy for 4g/4g
> 
> ppc-fixes.patch
>   make mm4 compile on ppc
> 
> O_DIRECT-race-fixes-rollup.patch
>   DIO fixes forward port and AIO-DIO fix
>   O_DIRECT race fixes comments
>   O_DRIECT race fixes fix fix fix
>   DIO locking rework
>   O_DIRECT XFS fix
> 
> dio-aio-fixes.patch
>   direct-io AIO fixes
>   dio-aio fix fix
> 
> aio-fallback-bio_count-race-fix-2.patch
>   AIO+DIO bio_count race fix
> 
> aio-sysctl-parms.patch
>   aio sysctl parms
> 
> aio-01-retry.patch
>   AIO: Core retry infrastructure
>   Fix aio process hang on EINVAL
>   AIO: flush workqueues before destroying ioctx'es
>   AIO: hold the context lock across unuse_mm
>   task task_lock in use_mm()
> 
> 4g4g-aio-hang-fix.patch
>   Fix AIO and 4G-4G hang
> 
> aio-retry-elevated-refcount.patch
>   aio: extra ref count during retry
> 
> aio-splice-runlist.patch
>   Splice AIO runlist for fairer handling of multiple io contexts
> 
> aio-02-lockpage_wq.patch
>   AIO: Async page wait
> 
> aio-03-fs_read.patch
>   AIO: Filesystem aio read
> 
> aio-04-buffer_wq.patch
>   AIO: Async buffer wait
>   lock_buffer_wq fix
> 
> aio-05-fs_write.patch
>   AIO: Filesystem aio write
> 
> aio-06-bread_wq.patch
>   AIO: Async block read
> 
> aio-07-ext2getblk_wq.patch
>   AIO: Async get block for ext2
> 
> O_SYNC-speedup-2.patch
>   speed up O_SYNC writes
> 
> O_SYNC-speedup-2-f_mapping-fixes.patch
> 
> aio-09-o_sync.patch
>   aio O_SYNC
>   AIO: fix a BUG
>   Unify o_sync changes for aio and regular writes
>   aio-O_SYNC-fix bits got lost
>   aio: writev nr_segs fix
>   More AIO O_SYNC related fixes
> 
> aio-09-o_sync-f_mapping-fixes.patch
> 
> gang_lookup_next.patch
>   Change the page gang lookup API
> 
> aio-gang_lookup-fix.patch
>   AIO gang lookup fixes
> 
> aio-O_SYNC-short-write-fix.patch
>   Fix for O_SYNC short writes
> 
> aio-12-readahead.patch
>   AIO: readahead fixes
>   aio O_DIRECT no readahead
>   Unified page range readahead for aio and regular reads
> 
> aio-12-readahead-f_mapping-fix.patch
> 
> aio-readahead-speedup.patch
>   Readahead issues and AIO read speedup
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--------------070905080705080808010504
Content-Type: text/plain;
 name="forcedeth-update-v19_v20.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="forcedeth-update-v19_v20.patch"

diff -u linux/drivers/net/forcedeth.c linux-2.6.1-rc2-mm1-dsd/drivers/net/forcedeth.c
--- linux/drivers/net/forcedeth.c	2004-01-08 10:33:34.000000000 +0000
+++ linux-2.6.1-rc2-mm1-dsd/drivers/net/forcedeth.c	2004-01-08 10:48:44.758416400 +0000
@@ -60,6 +60,7 @@
  * 			   addresses, really stop rx if already running
  * 			   in start_rx, clean up a bit.
  * 				(C) Carl-Daniel Hailfinger
+ * 	0.20: 07 Dev 2003: alloc fixes
  *
  * Known bugs:
  * The irq handling is wrong - no tx done interrupts are generated.
@@ -1297,7 +1298,8 @@
 
 	err = pci_enable_device(pci_dev);
 	if (err) {
-		printk(KERN_INFO "forcedeth: pci_enable_dev failed: %d\n", err);
+		printk(KERN_INFO "forcedeth: pci_enable_dev failed (%d) for device %s\n",
+				err, pci_name(pci_dev));
 		goto out_free;
 	}
 
@@ -1310,8 +1312,8 @@
 	err = -EINVAL;
 	addr = 0;
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-		dprintk(KERN_DEBUG "forcedeth: resource %d start %p len %ld flags 0x%08lx.\n",
-				i, (void*)pci_resource_start(pci_dev, i),
+		dprintk(KERN_DEBUG "%s: resource %d start %p len %ld flags 0x%08lx.\n",
+				pci_name(pci_dev), i, (void*)pci_resource_start(pci_dev, i),
 				pci_resource_len(pci_dev, i),
 				pci_resource_flags(pci_dev, i));
 		if (pci_resource_flags(pci_dev, i) & IORESOURCE_MEM &&
@@ -1321,7 +1323,8 @@
 		}
 	}
 	if (i == DEVICE_COUNT_RESOURCE) {
-		printk(KERN_INFO "forcedeth: Couldn't find register window.\n");
+		printk(KERN_INFO "forcedeth: Couldn't find register window for device %s.\n",
+					pci_name(pci_dev));
 		goto out_relreg;
 	}
 
@@ -1348,15 +1351,6 @@
 
 	pci_set_drvdata(pci_dev, dev);
 
-	err = register_netdev(dev);
-	if (err) {
-		printk(KERN_INFO "forcedeth: unable to register netdev: %d\n", err);
-		goto out_freering;
-	}
-
-	printk(KERN_INFO "%s: forcedeth.c: subsystem: %05x:%04x\n",
-			dev->name, pci_dev->subsystem_vendor, pci_dev->subsystem_device);
-
 
 	/* read the mac address */
 	base = get_hwbase(dev);
@@ -1375,7 +1369,8 @@
 		 * Bad mac address. At least one bios sets the mac address
 		 * to 01:23:45:67:89:ab
 		 */
-		printk(KERN_ERR "%s: Invalid Mac address detected: %02x:%02x:%02x:%02x:%02x:%02x\n", dev->name,
+		printk(KERN_ERR "%s: Invalid Mac address detected: %02x:%02x:%02x:%02x:%02x:%02x\n",
+			pci_name(pci_dev),
 			dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
 			dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
 		printk(KERN_ERR "Please complain to your hardware vendor. Switching to a random MAC.\n");
@@ -1385,7 +1380,7 @@
 		get_random_bytes(&dev->dev_addr[3], 3);
 	}
 
-	dprintk(KERN_DEBUG "%s: MAC Address %02x:%02x:%02x:%02x:%02x:%02x\n", dev->name,
+	dprintk(KERN_DEBUG "%s: MAC Address %02x:%02x:%02x:%02x:%02x:%02x\n", pci_name(pci_dev),
 			dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
 			dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
 
@@ -1397,6 +1392,15 @@
 	if (id->driver_data & DEV_IRQMASK_2)
 		np->irqmask = NVREG_IRQMASK_WANTED_2;
 
+	err = register_netdev(dev);
+	if (err) {
+		printk(KERN_INFO "forcedeth: unable to register netdev: %d\n", err);
+		goto out_freering;
+	}
+	printk(KERN_INFO "%s: forcedeth.c: subsystem: %05x:%04x bound to %s\n",
+			dev->name, pci_dev->subsystem_vendor, pci_dev->subsystem_device,
+			pci_name(pci_dev));
+
 	return 0;
 
 out_freering:
@@ -1409,7 +1413,7 @@
 out_disable:
 	pci_disable_device(pci_dev);
 out_free:
-	kfree(dev);
+	free_netdev(dev);
 	pci_set_drvdata(pci_dev, NULL);
 out:
 	return err;


--------------070905080705080808010504--
