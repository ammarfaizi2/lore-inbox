Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTLLSk1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 13:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTLLSk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 13:40:27 -0500
Received: from chico.rediris.es ([130.206.1.3]:42893 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S261788AbTLLSkJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 13:40:09 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors and later panics in 2.6.0-test11.
Date: Fri, 12 Dec 2003 19:38:04 +0100
User-Agent: KMail/1.5.4
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
References: <200312031417.18462.ender@debian.org> <200312031747.16927.ender@debian.org> <Pine.LNX.4.58.0312030916080.6950@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312030916080.6950@home.osdl.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312121938.05019.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

	Hey, Linus. The machine was nearly stable until three days ago...

	I suffered two hard locks (without logs in /var/log/messages), and
the console was not working, sorry. I'll dig now in that if I have some time.

	The last night the panics were:

Dec 11 22:36:41 ulises -- MARK --
Dec 11 22:50:01 ulises kernel: Bad page state at prep_new_page
Dec 11 22:50:01 ulises kernel: flags:0x01020028 mapping:dc49cd28 mapped:0 count:1
Dec 11 22:50:01 ulises kernel: Backtrace:
Dec 11 22:50:01 ulises kernel: Call Trace:
Dec 11 22:50:01 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec 11 22:50:01 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec 11 22:50:01 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec 11 22:50:01 ulises kernel:  [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
Dec 11 22:50:01 ulises kernel:  [skb_over_panic+3/71] kfree_skbmem+0x24/0x2c
Dec 11 22:50:01 ulises kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Dec 11 22:50:01 ulises kernel:  [cache_grow+157/576] cache_grow+0x9d/0x240
Dec 11 22:50:01 ulises kernel:  [permission+70/72] permission+0x46/0x48
Dec 11 22:50:01 ulises kernel:  [cache_alloc_refill+321/474] cache_alloc_refill+0x141/0x1da
Dec 11 22:50:01 ulises kernel:  [kmem_cache_alloc+64/66] kmem_cache_alloc+0x40/0x42
Dec 11 22:50:01 ulises kernel:  [dup_task_struct+69/201] dup_task_struct+0x45/0xc9
Dec 11 22:50:01 ulises kernel:  [copy_process+214/2442] copy_process+0xd6/0x98a
Dec 11 22:50:01 ulises kernel:  [do_fork+80/365] do_fork+0x50/0x16d
Dec 11 22:50:01 ulises kernel:  [sys_clone+65/69] sys_clone+0x41/0x45
Dec 11 22:50:01 ulises kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Dec 11 22:50:01 ulises kernel:
Dec 11 22:50:02 ulises kernel: Trying to fix it up, but a reboot is needed
Dec 11 22:50:02 ulises kernel: Bad page state at prep_new_page
Dec 11 22:50:02 ulises kernel: flags:0x01020028 mapping:dc49cd28 mapped:0 count:1
Dec 11 22:50:02 ulises kernel: Backtrace:
Dec 11 22:50:02 ulises kernel: Call Trace:
Dec 11 22:50:02 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec 11 22:50:02 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec 11 22:50:02 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec 11 22:50:02 ulises kernel:  [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
Dec 11 22:50:02 ulises kernel:  [do_wp_page+168/904] do_wp_page+0xa8/0x388
Dec 11 22:50:02 ulises kernel:  [handle_mm_fault+293/308] handle_mm_fault+0x125/0x134
Dec 11 22:50:02 ulises kernel:  [do_page_fault+288/1264] do_page_fault+0x120/0x4f0
Dec 11 22:50:02 ulises kernel:  [sys_stat64+55/57] sys_stat64+0x37/0x39
Dec 11 22:50:02 ulises kernel:  [do_page_fault+0/1264] do_page_fault+0x0/0x4f0
Dec 11 22:50:02 ulises kernel:  [error_code+45/56] error_code+0x2d/0x38
Dec 11 22:50:02 ulises kernel:
Dec 11 22:50:02 ulises kernel: Trying to fix it up, but a reboot is needed
Dec 11 22:50:02 ulises kernel: Bad page state at prep_new_page
Dec 11 22:50:02 ulises kernel: flags:0x0102002c mapping:dc49cd28 mapped:0 count:1
[...]

	After rebooting this morning...

	The box is now giving panics:

Dec 12 18:32:40 ulises kernel: Bad page state at prep_new_page
Dec 12 18:32:40 ulises kernel: flags:0x0102002c mapping:c000bea8 mapped:0 count:1
Dec 12 18:32:40 ulises kernel: Backtrace:
Dec 12 18:32:40 ulises kernel: Call Trace:
Dec 12 18:32:40 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec 12 18:32:40 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec 12 18:32:40 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec 12 18:32:40 ulises kernel:  [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
Dec 12 18:32:40 ulises kernel:  [do_page_cache_readahead+221/265] do_page_cache_readahead+0xdd/0x109
Dec 12 18:32:40 ulises kernel:  [page_cache_readahead+190/335] page_cache_readahead+0xbe/0x14f
Dec 12 18:32:40 ulises kernel:  [do_generic_mapping_read+186/1228] do_generic_mapping_read+0xba/0x4cc
Dec 12 18:32:40 ulises kernel:  [file_read_actor+0/234] file_read_actor+0x0/0xea
Dec 12 18:32:40 ulises kernel:  [__generic_file_aio_read+444/494] __generic_file_aio_read+0x1bc/0x1ee
Dec 12 18:32:40 ulises kernel:  [file_read_actor+0/234] file_read_actor+0x0/0xea
Dec 12 18:32:40 ulises kernel:  [xfs_read+346/620] xfs_read+0x15a/0x26c
Dec 12 18:32:40 ulises kernel:  [linvfs_read+141/159] linvfs_read+0x8d/0x9f
Dec 12 18:32:40 ulises kernel:  [do_sync_read+139/183] do_sync_read+0x8b/0xb7
Dec 12 18:32:40 ulises kernel:  [inet_setsockopt+54/58] inet_setsockopt+0x36/0x3a
Dec 12 18:32:40 ulises kernel:  [sys_setsockopt+120/178] sys_setsockopt+0x78/0xb2
Dec 12 18:32:40 ulises kernel:  [vfs_read+176/281] vfs_read+0xb0/0x119
Dec 12 18:32:40 ulises kernel:  [sys_read+66/99] sys_read+0x42/0x63
Dec 12 18:32:40 ulises kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Dec 12 18:32:40 ulises kernel:
Dec 12 18:32:40 ulises kernel: Trying to fix it up, but a reboot is needed
Dec 12 18:33:16 ulises kernel: Bad page state at prep_new_page
Dec 12 18:33:16 ulises kernel: flags:0x0102002c mapping:c000bea8 mapped:0 count:1
Dec 12 18:33:16 ulises kernel: Backtrace:
Dec 12 18:33:16 ulises kernel: Call Trace:
Dec 12 18:33:16 ulises kernel:  [bad_page+93/133] bad_page+0x5d/0x85
Dec 12 18:33:16 ulises kernel:  [prep_new_page+50/81] prep_new_page+0x32/0x51
Dec 12 18:33:16 ulises kernel:  [buffered_rmqueue+165/264] buffered_rmqueue+0xa5/0x108
Dec 12 18:33:16 ulises kernel:  [__alloc_pages+166/788] __alloc_pages+0xa6/0x314
Dec 12 18:33:16 ulises kernel:  [do_wp_page+168/904] do_wp_page+0xa8/0x388
Dec 12 18:33:16 ulises kernel:  [handle_mm_fault+293/308] handle_mm_fault+0x125/0x134
Dec 12 18:33:16 ulises kernel:  [do_page_fault+288/1264] do_page_fault+0x120/0x4f0
Dec 12 18:33:16 ulises kernel:  [recalc_task_prio+144/426] recalc_task_prio+0x90/0x1aa
Dec 12 18:33:16 ulises kernel:  [schedule+742/1420] schedule+0x2e6/0x58c
Dec 12 18:33:16 ulises kernel:  [sys_setresuid+227/369] sys_setresuid+0xe3/0x171
Dec 12 18:33:16 ulises kernel:  [do_page_fault+0/1264] do_page_fault+0x0/0x4f0
Dec 12 18:33:16 ulises kernel:  [error_code+45/56] error_code+0x2d/0x38
Dec 12 18:33:16 ulises kernel:
Dec 12 18:33:16 ulises kernel: Trying to fix it up, but a reboot is needed
[...]

	It's running kernel 2.6.0-test11 with your patch described below.

	It keeps running RAID0, so it's not the issue that Neil found related to RAID5.

	If you need some other information, don't hesitate to ask it.

El Miércoles, 3 de Diciembre de 2003 18:25, Linus Torvalds escribió:
> On Wed, 3 Dec 2003, David Martínez Moreno wrote:
> > 	I've just rebooted about six hours ago, and it's giving panics
> > elsewhere:
> >
> > [...]
> > Ending XFS recovery on filesystem: md0 (dev: md0)
> > b44: eth0: Link is down.
> > b44: eth0: Link is up at 100 Mbps, full duplex.
> > b44: eth0: Flow control is on for TX and on for RX.
> > eth0: no IPv6 routers present
> > Unable to handle kernel paging request at virtual address 00100104
>
> That's the LIST_POISON stuff: 00100100 is the "bad list pointer". Somebody
> tried to remove a page twice.
>
> Doesn't mean a lot - if your "struct page" got corrupted, anything can
> happen. Quite possibly it's a double free.
>
> > 	I can rebuild the Debian mirror for not using the RAID and using the
> > SATA disks separately, but will be tomorrow, it's a lot of space to move,
> > and I need remote intervention.
> >
> > 	Anyway I'd love to know before doing if it will be useful, looking at
> > what Jens has said just ten minutes ago about RAIDs 0/5. Will it help to
> > you? Say so and I'll go for it.
>
> It might be more useful to leave it as RAID0, if you're willing to try out
> patches to try to debug this. The slab-debugging thing I sent out earlier
> is one such patch (but may well cause out-of-memory problems under load),
> and possibly the atomic-decrement checker patch (appended). And maybe Jens
> and Neil can come up with something..
>
> 		Linus
>
> ----
> ===== arch/i386/lib/dec_and_lock.c 1.1 vs edited =====
> --- 1.1/arch/i386/lib/dec_and_lock.c	Tue Feb  5 09:40:21 2002
> +++ edited/arch/i386/lib/dec_and_lock.c	Sun Nov  2 09:07:53 2003
> @@ -19,7 +19,7 @@
>  	counter = atomic_read(atomic);
>  	newcount = counter-1;
>
> -	if (!newcount)
> +	if (newcount <= 0)
>  		goto slow_path;
>
>  	asm volatile("lock; cmpxchgl %1,%2"
> ===== include/asm-i386/atomic.h 1.5 vs edited =====
> --- 1.5/include/asm-i386/atomic.h	Mon Aug 18 19:46:23 2003
> +++ edited/include/asm-i386/atomic.h	Sun Nov  2 09:40:42 2003
> @@ -2,6 +2,8 @@
>  #define __ARCH_I386_ATOMIC__
>
>  #include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <asm/bug.h>
>
>  /*
>   * Atomic operations that C can't guarantee us.  Useful for
> @@ -136,12 +138,17 @@
>   */
>  static __inline__ int atomic_dec_and_test(atomic_t *v)
>  {
> -	unsigned char c;
> +	static int count = 2;
> +	unsigned char c, neg;
>
>  	__asm__ __volatile__(
> -		LOCK "decl %0; sete %1"
> -		:"=m" (v->counter), "=qm" (c)
> +		LOCK "decl %0; sete %1; sets %2"
> +		:"=m" (v->counter), "=qm" (c), "=qm" (neg)
>
>  		:"m" (v->counter) : "memory");
>
> +	if (count && neg) {
> +		count--;
> +		WARN_ON(neg);
> +	}
>  	return c != 0;
>  }

- -- 
And need I remind you that I am naked in the snow...? I
 can't feel any of my extremities, and I mean *any* of them...
		-- Skinner (The League of Extraordinary Gentlemen)
- --
Servicios de red - Network services
Centro de Comunicaciones CSIC/RedIRIS
Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.49.05
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2gsMWs/EhA1iABsRAtuOAKDs3W7Iklx6VDNEX8Y1Gt+RhyRWtwCgpX+9
55Dq4DmQM14b2DeNXfdEwxY=
=Casj
-----END PGP SIGNATURE-----

