Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264625AbSK0RTY>; Wed, 27 Nov 2002 12:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSK0RTY>; Wed, 27 Nov 2002 12:19:24 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:58129
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S264625AbSK0RTV>; Wed, 27 Nov 2002 12:19:21 -0500
Subject: Re: htree+NFS (NFS client bug?)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-kGddoeD8Dh55mIsF+khW"
Organization: 
Message-Id: <1038417998.533.2.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Nov 2002 09:26:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kGddoeD8Dh55mIsF+khW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-11-27 at 05:33, Theodore Ts'o wrote: 
> Well, even if the NFS server is generating bad cookies (and that may
> be possible), the NFS client should be more robust and not spin in a
> loop forever.
> 
> Can you send me a directory list (from the server) of the directory in
> question?  Also, can you send me the output of dumpe2fs -h on the
> filesystem.  I'll need the later to get the seed for the htree hash,
> so I can try replicating this on my end.

The hash seed is 80f11989-89cc-4046-80d8-4aef72a7f80f (extracted with
tune2fs -l).  The listing is attached.

> Also, have you tried running e2fsck on filesystem on the server?  It
> would be very interesting to confirm whether or not the filesystem is
> consistent.

This happens very regularly.  Each time it does I create a new directory
and move everything over, which presumably works because it rehashes
everything and/or changes the alignment of particular direntries with
respect to the NFS reply packets.  What I'm saying is that if the
filesystem is getting into an inconsistent state, it is doing so at a
very high rate.  I'll check it anyway... all OK.

	J

--=-kGddoeD8Dh55mIsF+khW
Content-Description: 
Content-Disposition: inline; filename=dirlist
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

.
..
vg_symtypes.h~
vg_include.h
.deps
vg_to_ucode.c~47-chained-bb
vg_from_ucode.c~47-chained-bb
vg_memory.c
vg_symtypes.c~
vg_constants.h~48-chained-indirect
valgrind
vg_needs.c
vg_from_ucode.i
vg_symtypes.h~44-symbolic-addr
vg_libpthread.c~11-timedwait-rel
vg_libpthread_unimp.c
vg_constants.h~47-chained-bb
vg_libpthread.c~03-accept-nonblock
vg_transtab.c~47-chained-bb
vg_include.h~48-chained-indirect
vg_symtypes.c~44-symbolic-addr
vg_main.c~14-hg-mmap-magic-virgin
vg_symtab2-test.c
vg_startup.S
vg_main.c~51-kill-inceip
vg_default.c
vg_translate.c~01-partial-mul
vg_dispatch.S~48-chained-indirect
vg_scheduler.c~47-chained-bb
vg_clientfuncs.c
Makefile.in
gmon.out
vg_main.c~47-chained-bb
vg_procselfmaps.c
vg_symtab2.h
vg_main.c~48-chained-indirect
vg_translate.c~51-kill-inceip
vg_symtypes.h
vg_symtab_stabs.c
dosyms
vg_constants.h
vg_demangle.c
vg_messages.c
vg_include.h~50-fast-cond
vg_to_ucode.c
Makefile~
vg_symtab2.c~44-symbolic-addr
vg_dispatch.S~47-chained-bb
vg_libpthread.c
vg_kerneliface.h
vg_from_ucode.c~48-chained-indirect
vg_from_ucode.c
vg_from_ucode.c~49-no-inceip
vg_malloc2.c
vg_instrument.c
vg_signals.c~28-sigtrap
vg_main.c.rej
vg_symtab2-test
vg_errcontext.c
vg_translate.c
vg_symtypes.c
out.pid11357
vg_execontext.c
Makefile
vg_main.c
vg_errcontext.c~47-chained-bb
vg_signals.c
vg_symtab2.c~offset-dehack
vg_from_ucode.c~01-partial-mul
Makefile.am~44-symbolic-addr
vg_main.c.orig
vg_symtab2.c
vg_kerneliface.h~28-sigtrap
vg_ldt.c
vg_from_ucode.c~00-lazy-fp
vg_transtab.c
vg_mylibc.c~12-vgprof
vg_from_ucode.c~50-fast-cond
vg_symtab2.h~44-symbolic-addr
vg_symtab_dwarf.c~44-symbolic-addr
vg_unsafe.h
vg_include.h~51-kill-inceip
vg_symtab_stabs.c~44-symbolic-addr
vg_mylibc.c
vg_dummy_profile.c
vg_main.c~50-fast-cond
vg_mylibc.c~09-rdtsc-calibration
vg_include.h~47-chained-bb
vg_translate.c~47-chained-bb
vg_libpthread.c~46-fix-writeable_or_erring-proto
vg_syscall.S
vg_from_ucode.c~51-kill-inceip
vg_mylibc.c~28-sigtrap
vg_dispatch.S
vg_symtab_dwarf.c
vg_intercept.c
vg_symtab_stabs.c~
vg_clientmalloc.c
vg_valgrinq_dummy.c
vg_scheduler.c
vg_to_ucode.c~01-partial-mul
Makefile.am
vg_helpers.S
out.pid11334
vg_syscalls.c
valgrind.in
vg_libpthread.vs

--=-kGddoeD8Dh55mIsF+khW--

