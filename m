Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267143AbTBDHxl>; Tue, 4 Feb 2003 02:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267144AbTBDHxl>; Tue, 4 Feb 2003 02:53:41 -0500
Received: from adsl-67-123-8-233.dsl.pltn13.pacbell.net ([67.123.8.233]:3552
	"EHLO influx.triplehelix.org") by vger.kernel.org with ESMTP
	id <S267143AbTBDHxf>; Tue, 4 Feb 2003 02:53:35 -0500
Date: Tue, 4 Feb 2003 00:02:53 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm8
Message-ID: <20030204080253.GA1055@triplehelix.org>
References: <20030203233156.39be7770.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20030203233156.39be7770.akpm@digeo.com>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I noticed you have at least some of Jaroslav Kysela's ALSA BK push in=20
-mm8. Is his whole patch integrated into yours?

Regards
Josh

On Mon, Feb 03, 2003 at 11:31:56PM -0800, Andrew Morton wrote:
>=20
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm8/
>=20
> . Various tweaks and fixes, and some hugetlbpage work.
>=20
> . There is an updated anticipatory scheduler patch from Nick over in
>   experimental/ which addresses the large-read-starves-everything problem.
>=20
> . The reworked ia32 balancing patch from Nitin Kamble is stable, and is
>   consistently showing benefit for heavy networking loads on large SMP
>   machines.  Even though everyone seems to agree that a userspace solutio=
n to
>   this is smarter, that's no reason to hold back on improving the
>   kernel-based solution so I shall be submitting that patch.
>=20
> . Ingo's latest scheduler changes are here.  I held off on that because it
>   appeared that there was some interaction with the I/O scheduler.  Whate=
ver
>   that was has gone away without any CPU scheduler changes, so...
>=20
> . frlocks have been renamed to seqlocks, and that code is now converging
>   onto something stable.
>=20
>=20
>=20
> Changes since 2.5.59-mm7:
>=20
>=20
> +linus.patch
>=20
>  Latest drop from Linus
>=20
> -sync-fix.patch
> -direct-io-ENOSPC-fix.patch
> -inode-accounting-race-fix.patch
> -vmlinux-fix.patch
> -maestro-fix.patch
> -setuid-exec-no-lock_kernel.patch
> -ext3-scheduling-storm.patch
> -quota-lockfix.patch
> -quota-offsem.patch
> -slab-poisoning-fix.patch
> -preempt-locking.patch
> -stack-overflow-fix.patch
> -ext2-allocation-failure-fix.patch
> -ext2_new_block-fixes.patch
> -slab-irq-fix.patch
> -Richard_Henderson_for_President.patch
> -parenthesise-pgd_index.patch
> -kernel-commandline-fix.patch
> -macro-double-eval-fix.patch
> -blkdev-fixes.patch
> -modversions.patch
> -pcmcia_timer_init.patch
> -buffer-io-accounting.patch
> -aic79xx-linux-2.5.59-20030122.patch
> -discarded-section-fix.patch
> -atyfb-compile-fix.patch
> -floppy-locking-fix.patch
> -sound-firmware-load-fix.patch
> -generic_file_readonly_mmap-fix.patch
> -exit_mmap-fix-47.patch
> -show_task-fix.patch
>=20
>  Merged
>=20
> +mark_inode_dirty-race.patch
>=20
>  SMP barriers in __mark_inode_dirty()
>=20
> +pin_page-pmd.patch
>=20
>  Optimisation for follow_page() for some architectures.  For futexes in h=
uge
>  pages.
>=20
> +seqlock.patch
>=20
>  Rename frlocks, fixes.
>=20
> +default_idle-speedup.patch
>=20
>  Speed up the idle task!
>=20
> +hugetlbfs-get_unmapped_area.patch
> +hugetlbfs-truncate-fix.patch
> +hugetlbfs-i_size-fix.patch
> +hugetlbfs-cleanup.patch
> +hugetlbfs-nopage-cleanup.patch
> +hugetlbfs-fault-fix.patch
> +hugetlbpage-cleanup.patch
> +hugetlb_vmtruncate-fixes.patch
> +hugetlb-mremap-fix.patch
>=20
>  hugetlb fixes/cleanups
>=20
> +mremap-cleanup.patch
>=20
>  Random edits
>=20
> +up-spinlock-debugging.patch
>=20
>  spinlock debugging for uniprocessor builds
>=20
> +scheduler-update.patch
>=20
>  Ingo's latest.
>=20
> +rml-scheduler-update.patch
>=20
>  scheduler tweaks from Robert
>=20
>=20
>=20
>=20
> All 80 patches:
>=20
> linus.patch
>   cset-1.879.1.145-to-1.950.txt.gz
>=20
> kgdb.patch
>=20
> devfs-fix.patch
>=20
> deadline-np-42.patch
>   (undescribed patch)
>=20
> deadline-np-43.patch
>   (undescribed patch)
>=20
> batch-tuning.patch
>   I/O scheduler tuning
>=20
> starvation-by-read-fix.patch
>   fix starvation-by-readers in the IO scheduler
>=20
> buffer-debug.patch
>   buffer.c debugging
>=20
> warn-null-wakeup.patch
>=20
> reiserfs-readpages.patch
>   reiserfs v3 readpages support
>=20
> fadvise.patch
>   implement posix_fadvise64()
>=20
> auto-unplug.patch
>   self-unplugging request queues
>=20
> less-unplugging.patch
>   Remove most of the blk_run_queues() calls
>=20
> scheduler-tunables.patch
>   scheduler tunables
>=20
> htlb-2.patch
>   hugetlb: fix MAP_FIXED handling
>=20
> kirq.patch
>   ia32 IRQ distribution rework
>=20
> kirq-up-fix.patch
>   Subject: Re: 2.5.59-mm1
>=20
> agp-warning-fix.patch
>   fix agp compile warning
>=20
> ext3-truncate-ordered-pages.patch
>   ext3: explicitly free truncated pages
>=20
> prune-icache-stats.patch
>   add stats for page reclaim via inode freeing
>=20
> vma-file-merge.patch
>   file-backed vma merging mergnig
>=20
> mmap-whitespace.patch
>=20
> read_cache_pages-cleanup.patch
>   cleanup in read_cache_pages()
>=20
> remove-GFP_HIGHIO.patch
>   remove __GFP_HIGHIO
>=20
> oprofile-p4.patch
>=20
> oprofile_cpu-as-string.patch
>   oprofile cpu-as-string
>=20
> wli-11_pgd_ctor.patch
>   Use a slab cache for pgd and pmd pages
>=20
> wli-11_pgd_ctor-update.patch
>   pgd_ctor update
>=20
> smaller-slab-batches.patch
>   Avoid losing timer ticks when slab debug is enabled.
>=20
> printk-locking.patch
>   remove unneeded locking in do_syslog()
>=20
> hangcheck-timer.patch
>   hangcheck-timer
>=20
> jbd-documentation.patch
>   JBD Documentation
>=20
> sendfile-security-hooks.patch
>   Subject: [RFC][PATCH] Restore LSM hook calls to sendfile
>=20
> mmzone-parens.patch
>   asm-i386/mmzone.h macro paren/eval fixes
>=20
> no_space_in_slabnames.patch
>   remove spaces from slab names
>=20
> remove-will_become_orphaned_pgrp.patch
>   remove will_become_orphaned_pgrp()
>=20
> MAX_IO_APICS-ifdef.patch
>   MAX_IO_APICS #ifdef'd wrongly
>=20
> dac960-error-retry.patch
>   Subject: [PATCH] linux2.5.56 patch to DAC960 driver for error retry
>=20
> epoll-update.patch
>   epoll timeout and syscall return types ...
>=20
> topology-remove-underbars.patch
>   Remove __ from topology macros
>=20
> mandlock-oops-fix.patch
>   ftruncate/truncate oopses with mandatory locking
>=20
> put_user-warning-fix.patch
>   Subject: Re: Linux 2.5.59
>=20
> hash-warnings.patch
>   fix #warning's
>=20
> mark_inode_dirty-race.patch
>   Fix SMP race betwen __sync_single_inode and __mark_inode_dirty
>=20
> reiserfs_file_write.patch
>   Subject: reiserfs file_write patch
>=20
> lost-tick.patch
>   Lost tick compensation
>=20
> seq_file-page-defn.patch
>   Include <asm/page.h> in fs/seq_file.c, as it uses PAGE_SIZE
>=20
> user-process-count-leak.patch
>   fix current->user->processes leak
>=20
> scsi-iothread.patch
>   scsi_eh_* needs to run even during suspend
>=20
> numaq-ioapic-fix2.patch
>   NUMAQ io_apic programming fix
>=20
> misc.patch
>   misc fixes
>=20
> writeback-sync-cleanup.patch
>   Remove unneeded code in fs/fs-writeback.c
>=20
> dont-wait-on-inode.patch
>   Fix latencies during writeback
>=20
> unlink-latency-fix.patch
>   fix i_sem contention in sys_unlink()
>=20
> pin_page-fix.patch
>   Fix futexes in huge pages
>=20
> pin_page-pmd.patch
>   Optimise follow_page() for page-table-based hugepages
>=20
> frlock-xtime.patch
>   fast reader locks for gettimeofday() and friends
>=20
> frlock-xtime-i386.patch
>=20
> frlock-xtime-ia64.patch
>=20
> frlock-xtime-other.patch
>=20
> seqlock.patch
>   Change frlock to seqlock
>=20
> do_gettimeofday-speedup.patch
>   do_gettimeofday() optimisations
>=20
> default_idle-speedup.patch
>   default_idle micro-optimisation
>=20
> pte_chain_alloc-fixes.patch
>=20
> hugetlbfs-set_page_dirty.patch
>   give hugetlbfs a set_page_dirty a_op
>=20
> compound-pages.patch
>   Infrastructure for correct hugepage refcounting
>=20
> compound-pages-hugetlb.patch
>   convert hugetlb code to use compound pages
>=20
> hugetlbfs-get_unmapped_area.patch
>   get_unmapped_area for hugetlbfs
>=20
> hugetlbfs-truncate-fix.patch
>   hugetlbfs: fix truncate
>=20
> hugetlbfs-i_size-fix.patch
>   hugetlbfs i_size fixes
>=20
> hugetlbfs-cleanup.patch
>   hugetlbfs cleanups
>=20
> hugetlbfs-nopage-cleanup.patch
>   Give all architectures a hugetlb_nopage().
>=20
> hugetlbfs-fault-fix.patch
>   Fix hugetlbfs faults
>=20
> hugetlbpage-cleanup.patch
>   ia32 hugetlb cleanup
>=20
> hugetlb_vmtruncate-fixes.patch
>   Fix hugetlb_vmtruncate_list()
>=20
> hugetlb-mremap-fix.patch
>   hugetlb mremap fix
>=20
> mremap-cleanup.patch
>   mm/mremap.c whitespace cleanup
>=20
> up-spinlock-debugging.patch
>   spinlock debugging on uniprocessors
>=20
> scheduler-update.patch
>   ingo's scheduler changes for 2.5.59-mm7
>=20
> rml-scheduler-update.patch
>   rml scheduler bits, 2.5.59-mm7
>=20
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+P3Ot6TRUxq22Mx4RAg+7AKCbP0wVDHJdwrtX1otUj/j5P5TFXwCfUPok
77O7BXI/kWpzgFK56aoYgTY=
=hCXb
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
