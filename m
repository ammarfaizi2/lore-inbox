Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVKFINB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVKFINB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVKFINB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:13:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932164AbVKFINA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 03:13:00 -0500
Date: Sun, 6 Nov 2005 00:12:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: mchehab@brturbo.com.br, nshmyrev@yandex.ru, v4l@cerqueira.org
Subject: Re: + v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch
 added to -mm tree
Message-Id: <20051106001249.48d3ade0.akpm@osdl.org>
In-Reply-To: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
>
> 
> The patch titled
> 
>      v4l-720-alsa-support-for-saa7134-that-should-work-fix
> 
> has been added to the -mm tree.  Its filename is
> 
>      v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> *** Warning: "saa7134_irq_alsa_done" [drivers/media/video/saa7134/saa7134.ko] undefined!
> *** Warning: "alsa_card_saa7134_exit" [drivers/media/video/saa7134/saa7134.ko] undefined!
> *** Warning: "alsa_card_saa7134_create" [drivers/media/video/saa7134/saa7134.ko] undefined!
> 
> Cc: Ricardo Cerqueira <v4l@cerqueira.org>
> Cc: Nickolay V. Shmyrev <nshmyrev@yandex.ru>
> Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

Well that didn't work.  The problem is that
drivers/media/video/saa7134/saa7134-alsa.c doesn't appear to be wired up
into the build system - it simply doesn't get compiled.

Please send a fix against next -mm?

> 
>  drivers/media/video/saa7134/saa7134-alsa.c |    3 +++
>  1 files changed, 3 insertions(+)
> 
> diff -puN drivers/media/video/saa7134/saa7134-alsa.c~v4l-720-alsa-support-for-saa7134-that-should-work-fix drivers/media/video/saa7134/saa7134-alsa.c
> --- devel/drivers/media/video/saa7134/saa7134-alsa.c~v4l-720-alsa-support-for-saa7134-that-should-work-fix	2005-11-05 23:43:39.000000000 -0800
> +++ devel-akpm/drivers/media/video/saa7134/saa7134-alsa.c	2005-11-05 23:43:39.000000000 -0800
> @@ -220,6 +220,7 @@ static int dsp_buffer_init(struct saa713
>                  return err;
>          return 0;
>  }
> +EXPORT_SYMBOL(saa7134_irq_alsa_done);
>  
>  
>  static int snd_card_saa7134_pcm_prepare(snd_pcm_substream_t * substream)
> @@ -811,6 +812,7 @@ __nodev:
>  	kfree(card);
>  	return err;
>  }
> +EXPORT_SYMBOL(alsa_card_saa7134_create);
>  
>  void alsa_card_saa7134_exit(void)
>  {
> @@ -819,3 +821,4 @@ void alsa_card_saa7134_exit(void)
>                  snd_card_free(snd_saa7134_cards[idx]);
>  	}
>  }
> +EXPORT_SYMBOL(alsa_card_saa7134_exit);
> _
> 
> Patches currently in -mm which might be from akpm@osdl.org are
> 
> fec_8xx-build-fix.patch
> posix-timers-smp-race-condition-tidy.patch
> increase-maximum-kmalloc-size-to-256k-fix.patch
> git-acpi-pciehprm_acpi-fix.patch
> git-acpi-update-8250_acpi.patch
> pnpacpi-handle-address-descriptors-in-_prs-fix-for-git-acpi-change.patch
> git-agpgart.patch
> git-alsa.patch
> git-blktrace-fixup.patch
> git-cpufreq.patch
> git-drm-prep.patch
> pci-gart-fix.patch
> git-audit-audit_inode_context-warning-fix.patch
> git-audit-selinux_inode_xattr_getsuffix-warning-fix.patch
> git-input.patch
> git-netdev-all-ieee80211_get_payload-warning-fix.patch
> s2io-warning-fixes.patch
> gregkh-pci-pci-driver-owner-removal-intel-agp-fix.patch
> gregkh-pci-pci-driver-owner-removal-ali-agp-fix.patch
> gregkh-pci-pci-driver-owner-removal-more-agp-borkage.patch
> gregkh-pci-pci-driver-owner-removal-even-more-agp-borkage.patch
> gregkh-pci-pci-driver-owner-removal-even-more-even-more-agp-borkage.patch
> gregkh-pci-pci-driver-owner-removal-fix-lpfc.patch
> gregkh-pci-pci-driver-owner-removal-fix-aic94xx_init.patch
> gregkh-usb-usb-pm-09-fix.patch
> eagle-and-adi-930-usb-adsl-modem-driver-tidies.patch
> dma32-change-zones_shift-back-to-2-gfp_zonemask-too.patch
> x86_64-vect-share-build-fix.patch
> slab-dont-bug-on-duplicated-cache.patch
> mm-poison-struct-page-for-ptlock-rename-private.patch
> mm-implement-swap-prefetching-default-y.patch
> mm-implement-swap-prefetching-tweaks.patch
> swap-migration-v5-lru-operations-tweaks.patch
> irda-donauboe-locking-fix.patch
> acx1xx-wireless-driver-usb-is-bust.patch
> acx1xx-allow-modular-build.patch
> acx1xx-wireless-driver-spy_offset-went-away.patch
> x86_64-div-by-zero-fix.patch
> serial-console-touch-nmi-watchdog.patch
> clear_buffer_uptodate-in-discard_buffer-check.patch
> write_inode_now-write-inode-if-not-bdi_cap_no_writeback.patch
> smbfs-readdir-vs-signal-fix.patch
> process-events-connector-fixes.patch
> rcu-signal-handling-tidies.patch
> additional-catchup-rcu-signal-fixes-for-mm-warning-fix.patch
> readahead-commentary.patch
> ext3_readdir-use-generic-readahead.patch
> slob-introduce-the-slob-allocator-fixes.patch
> cpuset-memory-pressure-meter-gcc-295-fix.patch
> gregkh-pci-pci-driver-owner-removal-synclink_gt-fix.patch
> changing-config_localversion-rebuilds-too-much-for-no-good-reason-ipw2200-fix.patch
> remove-ext2-xattr-permission-checks-warning-fixes.patch
> remove-xfs-xattr-permission-checks-warning-fixes.patch
> replace-inode_update_time-with-file_update_time-switch-ntfs-to-touch_atime.patch
> implement-kmap_atomic_irqsave.patch
> edac-atomic-scrub-operations-fix.patch
> edac-core-edac-support-code-ifdef-warnings.patch
> edac-core-edac-support-code-fixes.patch
> edac-core-edac-support-code-edac_mc_scrub_block-kunmap_atomic-fix.patch
> edac-core-edac-support-code-edac_mc_scrub_block-kunmap_atomic-fix-2.patch
> parport-constification-fix.patch
> kprobes-use-rcu-for-unregister-synchronization-base-changes-vs-remove-hlist_for_each_rcu-api-convert-existing-use-to-hlist_for_each_entry_rcu.patch
> dlm-use-configfs-fix.patch
> dvb-usb-urb-printk-fix.patch
> v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch
> sched-disable-preempt-in-idle-tasks-2-powerpc-fixes.patch
> sched-resched-and-cpu_idle-rework-warning-fix.patch
> reiser4-only.patch
> reiser4-swsusp-build-fix.patch
> reiser4-printk-warning-fix.patch
> reiser4-mm-remove-pg_highmem-fix.patch
> reiser4-page-private-fixes.patch
> reiser4-big-update-div64-fix.patch
> reiser4-remove-c99isms.patch
> reiser4-big-update-update_atime-fixes.patch
> reiser4_releasepage-gfp_t-fixes.patch
> ide-promise-flushing-hang-fix.patch
> nvidiafb-fix-mode-setting-ppc-support-warning-fixes.patch
> nr_blockdev_pages-in_interrupt-warning.patch
> sysfs-crash-debugging.patch
> device-suspend-debug.patch
> ide-kmalloc-memset-kzalloc-conversion-fix.patch
> tty-layer-buffering-revamp-pmac_zilog-warning-fix.patch
> 
> -
> To unsubscribe from this list: send the line "unsubscribe mm-commits" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
