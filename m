Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266306AbUAHT6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUAHT4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:56:04 -0500
Received: from zamok.crans.org ([138.231.136.6]:17637 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S266320AbUAHTwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:52:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Success report with nearly 2.6.1-rc2-mm1 and udev
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Thu, 08 Jan 2004 20:52:27 +0100
Message-ID: <87fzeqmd50.fsf@minas-morgul.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


As I run an iBook, and I want to test things in -mm trees, I maintain
my own kernel by applying Benjamin Herrenschmidt -ben* patch and
almost everything that is not non-ppc architecture exclusively
specific; my kernel is basically a 2.6.1-rc3 with most of 2.6.1-rc2-mm1 changes
and all Ben's changes. If you want my series file, I can provide it.
I write this to report plain success with udev and alsa,oss  nodes, and mouse
nodes.

matt@rivendell:pts/2 $ ls /udev
agpgart   hda1   kmem    random      tty14  tty29  tty43  tty58    vcs5
apm_bios  hda10  kmsg    rtc         tty15  tty3   tty44  tty59    vcs6
audio     hda11  mapper  sequencer   tty16  tty30  tty45  tty6     vcs7
cdrom     hda12  mem     sequencer2  tty17  tty31  tty46  tty60    vcsa
console   hda13  mice    snd         tty18  tty32  tty47  tty61    vcsa1
core      hda14  mixer   sndstat     tty19  tty33  tty48  tty62    vcsa2
dsp       hda15  mouse0  stderr      tty2   tty34  tty49  tty63    vcsa3
dvd       hda2   mouse1  stdin       tty20  tty35  tty5   tty7     vcsa4
event0    hda3   mouse2  stdout      tty21  tty36  tty50  tty8     vcsa5
event1    hda4   mouse4  tty         tty22  tty37  tty51  tty9     vcsa6
event2    hda5   null    tty0        tty23  tty38  tty52  urandom  vcsa7
event3    hda6   nvram   tty1        tty24  tty39  tty53  vcs      zero
fb0       hda7   pmu     tty10       tty25  tty4   tty54  vcs1
fd        hda8   port    tty11       tty26  tty40  tty55  vcs2
full      hda9   psaux   tty12       tty27  tty41  tty56  vcs3
hda       hdb    ptmx    tty13       tty28  tty42  tty57  vcs4


matt@rivendell:pts/2 $ ls /udev/snd
controlC0  pcmC0D0c  pcmC0D0p  seq  timer

I tried, weeks ago, some patches to get sound nodes in /udev btu it
gave me some weird oopses. Currently, it works great :)
Notice that I don't get any more oops with sysfs-add-vc-class.patch
applied.
Congratulations for giving us such a fun kernel :)

-- 
Mathieu Segaud

"Talk is cheap. Show me the code."

	- Linus Torvalds


--=-=-=
Content-Disposition: attachment
Content-Description: commented series file

linus.patch # latest bk
benh.patch # BenH changes to the 2.6 tree
scsi-rename-TIMEOUT.patch
loop-fix-hardsect.patch
RD1-open-mm.patch
RD2-release-mm.patch
RD3-presto_journal_close-mm.patch
RD4-f_mapping-mm.patch
RD5-f_mapping2-mm.patch
RD6-i_sem-mm.patch
RD7-f_mapping3-mm.patch
RD8-generic_osync_inode-mm.patch
RD9-bd_acquire-mm.patch
RD10-generic_write_checks-mm.patch
RD11-I_BDEV-mm.patch
cramfs-use-pagecache.patch
invalidate_inodes-speedup.patch
net-jiffy-normalisation-fix.patch
input-mousedev-remove-jitter.patch
input-mousedev-ps2-emulation-fix.patch
input-01-i8042-suspend.patch
input-02-i8042-option-parsing.patch
input-03-psmouse-option-parsing.patch
input-04-atkbd-option-parsing.patch
input-05-missing-module-licenses.patch
input-06-Kconfig-Synaptics-help.patch
input-07-sis-aux-port.patch
input-11-98busmouse-compile-fix.patch
input-12-mouse-drivers-use-module_param.patch
input-13-tsdev-use-module_param.patch
keyboard-repeat-fix.patch
input-use-after-free-checks.patch
cfq-4.patch
ramdisk-leak-fix.patch
ramdisk-cleanup.patch
pdflush-diag.patch
tcp_speedup.patch # taken from M.K.Bligh -mjb* patches
percpu_real_loadavg.patch # taken from M.K.Bligh -mjb* patches
autoswap.patch # taken from M.K.Bligh -mjb* patches
pci_set_power_state-might-sleep.patch
extra-buffer-diags.patch
loop-module-alias.patch
loop-bio-index-fix.patch
loop-highmem.patch
loop-bio-clone.patch
loop-recycle.patch
as-regression-fix.patch
as-request-poisoning.patch
as-request-poisoning-fix.patch
as-fix-all-known-bugs.patch
as-new-process-estimation.patch
as-cooperative-thinktime.patch
scale-nr_requests.patch
truncate_inode_pages-check.patch
local_bh_enable-warning-fix.patch
sysfs_remove_dir-vs-dcache_readdir-race-fix.patch
invalidate_mmap_range-non-gpl-export.patch
alsa-sleep-in-spinlock-fix.patch
dm-daemon.patch # taken from device-mapper devel tree (needed by next patch)
dm-crypt_target.patch # from Christophe Saout
dm-crypt_style-fixes.patch # taken from Christophe Saout
bio_meaning_clarify-end_io.patch # taken from Christophe Saout (it is in 2.6.1-rc2-mm1 as another patch)
ppc-export-consistent_sync_page.patch
ppc-use-EXPORT_SYMBOL_NOVERS.patch
ppc-CONFIG_PPC_STD_MMU-fix.patch
ppc-IBM-MPC-header-cleanups.patch
xfs-update-01.patch
nr_requests-oops-fix.patch
netfilter_bridge-compile-fix.patch
atapi-mo-support.patch
mt-ranier-support.patch
atapi-mo-support-update.patch
ppp_async-locking-fix.patch
const-fixes.patch
sysfs-add-simple-class-device-support.patch
sysfs-remove-tty-class-device-logic.patch
sysfs-add-mem-device-support.patch
sysfs-add-misc-class.patch
sysfs-add-vc-class.patch
vc-init-race-fix.patch
sysfs-add-video-class.patch
sysfs-add-oss-class.patch
sysfs-add-alsa-class.patch
sysfs-add-input-class-support.patch
kill_fasync-speedup.patch
o21-sched.patch
sched-clock-2.6.0-A1.patch
sched-can-migrate-2.6.0-A2.patch
sched-cleanup-2.6.0-A2.patch
sched-style-2.6.0-A5.patch
ide-siimage-seagate.patch
ide-siimage-stack-fix.patch
ide-siimage-sil3114.patch
ide-pdc_old-pio-fix.patch
ide-pdc_old-udma66-fix.patch
ide-pdc_old-66mhz_clock-fix.patch
ide-pdc_new-proc.patch
make-for_each_cpu-iterator-more-friendly.patch
make-for_each_cpu-iterator-more-friendly-fix.patch
use-for_each_cpu-in-right-places.patch
for_each_cpu-oprofile-fix.patch
for_each_cpu-oprofile-fix-2.patch
kernel-locking-doc-end-tags-fix.patch
rcupdate-c99-initialisers.patch
printk_ratelimit.patch
printk_ratelimit-fix.patch
compound-page-page_count-fix.patch
ext2_new_inode-cleanup.patch
ext2-s_next_generation-fix.patch
ext3-s_next_generation-fix.patch
alt-arrow-console-switch-fix.patch
softcursor-fix.patch
ext2-debug-build-fix.patch
efi-inline-fixes.patch
do_timer_gettime-cleanup.patch
set_cpus_allowed-locking-fix.patch
set_cpus_allowed-locking-fix-fix.patch
rmmod-race-fix.patch
laptop-mode-2.patch
laptop-mode-doc-update.patch
start_this_handle-retval-fix.patch
pid_max-fix.patch
workqueue-cleanup.patch
proc_pid_lookup-speedup.patch
rtc-leak-fixes.patch
use-soft-float.patch
show_task-free-stack-fix.patch
O_DIRECT-race-fixes-rollup.patch
dio-aio-fixes.patch
aio-fallback-bio_count-race-fix-2.patch
aio-sysctl-parms.patch
aio-01-retry.patch
aio-retry-elevated-refcount.patch
aio-splice-runlist.patch
aio-02-lockpage_wq.patch
aio-03-fs_read.patch
aio-04-buffer_wq.patch
aio-05-fs_write.patch
aio-06-bread_wq.patch
aio-07-ext2getblk_wq.patch
O_SYNC-speedup-2.patch
O_SYNC-speedup-2-f_mapping-fixes.patch
aio-09-o_sync.patch
aio-09-o_sync-f_mapping-fixes.patch
gang_lookup_next.patch
aio-gang_lookup-fix.patch
aio-O_SYNC-short-write-fix.patch
aio-12-readahead.patch
aio-12-readahead-f_mapping-fix.patch
aio-readahead-speedup.patch
monitor_airport.patch # monitoring support for airport wifi card
netfilter-tftp-remove-memsets.patch # taken from patch-o-matic
netfilter-ipv6-REJECT.patch # taken from patch-o-matic
netfilter-ipv4-time.patch # taken from patch-o-matic
libata2-rc1.patch # (which is libata update from J.Garzik)
oops-fixes-alsa-pmac.patch # from me
fixup-pcihp_skeleton.patch # taken from Greg K-H's usb-devel tree
add-pci_get_slot.patch # taken from Greg K-H's usb-devel tree
add-pci_bus-sysfs-class.patch # taken from Greg K-H's usb-devel tree
usb-skeleton_kfree-fix.patch # taken from Greg K-H's usb-devel tree
skb_linearize-deprecated-fix.patch # from me
beautify_pnm2logo.patch # from me
must-fix.patch 
must-fix-update-5.patch

--=-=-=--
