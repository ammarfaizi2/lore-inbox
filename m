Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWKHP6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWKHP6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965939AbWKHP6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:58:39 -0500
Received: from mga03.intel.com ([143.182.124.21]:28014 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S965934AbWKHP6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:58:37 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,401,1157353200"; 
   d="scan'208"; a="143056617:sNHT46016124"
Message-ID: <4551FEA8.4030702@intel.com>
Date: Wed, 08 Nov 2006 07:58:32 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mm-commits@vger.kernel.org, akpm@osdl.org, auke-jan.h.kok@intel.com,
       davem@davemloft.net, jeff@garzik.org
Subject: Re: + e1000-linkage-fix.patch added to -mm tree
References: <200611080724.kA87Ojcr002009@shell0.pdx.osdl.net>
In-Reply-To: <200611080724.kA87Ojcr002009@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2006 15:58:33.0565 (UTC) FILETIME=[BE2310D0:01C7034E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, that was indeed the fix needed (ACK)

Jeff, please apply to netdev#upstream

Auke



akpm@osdl.org wrote:
> The patch titled
>      e1000 linkage fix
> has been added to the -mm tree.  Its filename is
>      e1000-linkage-fix.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: e1000 linkage fix
> From: Andrew Morton <akpm@osdl.org>
> 
> ia64:
> 
>  drivers/built-in.o(.text+0xd9a72): In function `e1000_xmit_frame':
>  : undefined reference to `csum_ipv6_magic'
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Auke Kok <auke-jan.h.kok@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/net/e1000/e1000_main.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN drivers/net/e1000/e1000_main.c~e1000-linkage-fix drivers/net/e1000/e1000_main.c
> --- a/drivers/net/e1000/e1000_main.c~e1000-linkage-fix
> +++ a/drivers/net/e1000/e1000_main.c
> @@ -27,6 +27,7 @@
>  *******************************************************************************/
>  
>  #include "e1000.h"
> +#include <net/ip6_checksum.h>
>  
>  char e1000_driver_name[] = "e1000";
>  static char e1000_driver_string[] = "Intel(R) PRO/1000 Network Driver";
> _
> 
> Patches currently in -mm which might be from akpm@osdl.org are
> 
> dm-raid1-fix-waiting-for-io-on-suspend-fix.patch
> revert-pci-quirk-for-ibm-dock-ii-cardbus-controllers.patch
> revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
> revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
> generic_file_buffered_write-cleanup.patch
> mm-fix-pagecache-write-deadlocks.patch
> fs-prepare_write-fixes-fuse-fix.patch
> fs-prepare_write-fixes-fat-fix.patch
> git-acpi.patch
> video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-msi-laptop-fix.patch
> acpi-asus-s3-resume-fix.patch
> sony_apci-resume.patch
> video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register-sony_acpi-fix.patch
> git-cpufreq-prep.patch
> git-cpufreq.patch
> git-dvb.patch
> git-ia64.patch
> git-input.patch
> git-input-fixup.patch
> git-libata-all.patch
> via-pata-controller-xfer-fixes-fix.patch
> git-mtd.patch
> git-netdev-all.patch
> libphy-dont-do-that.patch
> update-smc91x-driver-with-arm-versatile-board-info.patch
> drivers-net-ns83820c-add-paramter-to-disable-auto.patch
> git-net.patch
> net-uninline-xfrm_selector_match.patch
> net-uninline-skb_put.patch
> ioat-warning-fix.patch
> revert-scsi-ips-soft-lockup-during-reset-initialization.patch
> scsi-ips-soft-lockup-during-reset-initialization-2.patch
> drivers-scsi-mca_53c9xc-save_flags-cli-removal-fix.patch
> fix-gregkh-usb-usb-expand-autosuspend-autoresume-api.patch
> git-watchdog.patch
> x86_64-mm-i386-reloc-abssym-hack.patch
> prep-for-paravirt-be-careful-about-touching-bios-warning-fix.patch
> paravirtualization-patch-inline-replacements-for-fix-2.patch
> xfs-rename-uio_read.patch
> touchkit-ps-2-touchscreen-driver.patch
> get-rid-of-zone_table.patch
> new-scheme-to-preempt-swap-token-tidy.patch
> balance_pdgat-cleanup.patch
> vmalloc-optimization-cleanup-bugfixes-tweak.patch
> radix-tree-rcu-lockless-readside.patch
> acx1xx-wireless-driver.patch
> swsusp-add-resume_offset-command-line-parameter-rev-2.patch
> add-include-linux-freezerh-and-move-definitions-from-ueagle-fix.patch
> cciss-set-sector_size-to-2048-for-performance-tidy.patch
> deprecate-smbfs-in-favour-of-cifs.patch
> edac-new-opteron-athlon64-memory-controller-driver.patch
> kbuild-dont-put-temp-files-in-the-source-tree.patch
> lockdep-annotate-nfs-nfsd-in-kernel-sockets-tidy.patch
> drivers-add-lcd-support-3-Kconfig-fix.patch
> setup_irq-better-mismatch-debugging.patch
> probe_kernel_address-needs-to-do-set_fs.patch
> slab-use-probe_kernel_address.patch
> lockdep-spin_lock_irqsave_nested-fix.patch
> lockdep-spin_lock_irqsave_nested-fix-2.patch
> aio-use-prepare_to_wait.patch
> exar-quad-port-serial-fix.patch
> vfs_getattr-remove-dead-code.patch
> ext3-uninline-large-functions.patch
> ext4-uninline-large-functions.patch
> uninline-module_put.patch
> sleep-profiling-fixes.patch
> debug-workqueue-locking-sanity-fix.patch
> pktcdvd-bio-write-congestion-using-blk_congestion_wait-fix.patch
> bug-test-1.patch
> fsstack-introduce-fsstack_copy_attrinode_-tidy.patch
> log2-implement-a-general-integer-log2-facility-in-the-kernel-fix.patch
> log2-implement-a-general-integer-log2-facility-in-the-kernel-vs-git-cryptodev.patch
> log2-implement-a-general-integer-log2-facility-in-the-kernel-ppc-fix.patch
> add-process_session-helper-routine-deprecate-old-field-tidy.patch
> add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
> add-process_session-helper-routine-deprecate-old-field-fix-warnings-2.patch
> fs-cache-provide-a-filesystem-specific-syncable-page-bit-ext4.patch
> fs-cache-make-kafs-use-fs-cache-fix.patch
> fs-cache-make-kafs-use-fs-cache-vs-streamline-generic_file_-interfaces-and-filemap.patch
> nfs-use-local-caching-12-fix.patch
> fs-cache-cachefiles-a-cache-that-backs-onto-a-mounted-filesystem-log2-fix.patch
> mxser-session-warning-fix.patch
> tty-switch-to-ktermios-and-new-framework-warning-fix.patch
> tty-switch-to-ktermios-bluetooth-fix.patch
> tty_ioctl-use-termios-for-the-old-structure-and-termios2-fix.patch
> char-istallion-correct-fail-paths-fix.patch
> drivers-isdn-handcrafted-min-max-macro-removal-fix.patch
> kernel-schedc-whitespace-cleanups-more.patch
> swap_prefetch-vs-zoned-counters.patch
> add-include-linux-freezerh-and-move-definitions-from-prefetch.patch
> readahead-sysctl-parameters.patch
> make-copy_from_user_inatomic-not-zero-the-tail-on-i386-vs-reiser4.patch
> resier4-add-include-linux-freezerh-and-move-definitions-from.patch
> make-kmem_cache_destroy-return-void-reiser4.patch
> reiser4-hardirq-include-fix.patch
> reiser4-run-truncate_inode_pages-in-reiser4_delete_inode.patch
> reiser4-get_sb_dev-fix.patch
> reiser4-vs-zoned-allocator.patch
> hpt3xx-rework-rate-filtering-tidy.patch
> various-fbdev-files-mark-structs-fix.patch
> md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-fix.patch
> statistics-infrastructure-fix-buffer-overflow-in-histogram-with-linear-tidy.patch
> gtod-persistent-clock-support-i386.patch
> hrtimers-state-tracking.patch
> clockevents-drivers-for-i386.patch
> gtod-mark-tsc-unusable-for-highres-timers.patch
> round_jiffies-infrastructure-fix.patch
> clocksource-small-cleanup-2-fix.patch
> kevent_user_wait-retval-fix.patch
> kevent-v23-socket-notifications-fix-again.patch
> kevent-timer-notifications-fix.patch
> nr_blockdev_pages-in_interrupt-warning.patch
> device-suspend-debug.patch
> mutex-subsystem-synchro-test-module-fix.patch
> slab-leaks3-default-y.patch
> x86-kmap_atomic-debugging.patch
> restore-rogue-readahead-printk.patch
> put_bh-debug.patch
> acpi_format_exception-debug.patch
> jmicron-warning-fix.patch
> squash-ipc-warnings.patch
> squash-udf-warnings.patch
> e1000-linkage-fix.patch
> 
> -
> To unsubscribe from this list: send the line "unsubscribe mm-commits" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
