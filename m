Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270684AbTHAHIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 03:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270685AbTHAHIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 03:08:16 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:14340 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S270684AbTHAHH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 03:07:59 -0400
Date: Fri, 1 Aug 2003 15:07:53 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: Eugene Teo <eugene.teo@eugeneteo.net>,
       Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       ianh@iahastie.clara.net, linux-kernel@vger.kernel.org
Subject: [UPDATE] Re: 2.6.0t2 Hangs randomly
Message-ID: <20030801070753.GA1351@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <3F27817A.8000703@gts.it> <200307302346.02989.ianh@iahastie.local.net> <3F28C124.9070004@gts.it> <20030731050104.1b61990d.vmlinuz386@yahoo.com.ar> <20030731111728.GB1591@eugeneteo.net> <3F28FFAF.80905@gts.it> <20030801020922.GA3298@eugeneteo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20030801020922.GA3298@eugeneteo.net>
X-Operating-System: Linux 2.2.20
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I think I discovered something interesting that might be some hints
as to why I am getting random hangs. I am using 2.2.20 (default debian
kernel atm), and I have not encounter any random hangs as yet (which
is fortunate... at least i know it is not hardware problem).

Was using 2.6.0-test2-mm2-kj1. I encountered the same hang problem when
I reverted back to 2.6.0-test1-mm2-kj1.

Please comment, and look into it......

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This was last night (after I go to bed):

Aug  1 03:20:06 amaryllis kernel: Slab corruption: start=3Dd40055f0, expend=
=3Dd400566f, problemat=3Dd40055f0
Aug  1 03:20:06 amaryllis kernel: Last user: [reap_timer_fnc+530/1208](reap=
_timer_fnc+0x212/0x4b8)
Aug  1 03:20:06 amaryllis kernel: Data: 6A 6A *******6A ******6A 2A ******6=
A 6A ******6A 2A ******6A 2A ******6A 6A ******6A 6A ******6A 2A ******6A *=
******6A 6A ******6A
 ********6A *******6A *******6A *******6A *****A5=20
Aug  1 03:20:06 amaryllis kernel: Next: 61 E0 2C .4B 7B 15 C0 A5 C2 0F 17 0=
8 57 00 D4 50 3A 30 D5 00 00 00 00 00 30 8F CF 01 00 00 00=20
Aug  1 03:20:06 amaryllis kernel: slab error in check_poison_obj(): cache `=
size-128': object was modified after freeing
Aug  1 03:20:06 amaryllis kernel: Call Trace:
Aug  1 03:20:06 amaryllis kernel:  [check_poison_obj+362/426] check_poison_=
obj+0x16a/0x1aa
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+136/425] kmem_cache_al=
loc+0x88/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [cache_grow+1032/1196] cache_grow+0x408/=
0x4ac
Aug  1 03:20:06 amaryllis kernel:  [cache_grow+1032/1196] cache_grow+0x408/=
0x4ac
Aug  1 03:20:06 amaryllis kernel:  [cache_alloc_refill+780/1221] cache_allo=
c_refill+0x30c/0x4c5
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+393/425] kmem_cache_al=
loc+0x189/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [pgd_alloc+27/31] pgd_alloc+0x1b/0x1f
Aug  1 03:20:06 amaryllis kernel:  [mm_init+467/533] mm_init+0x1d3/0x215
Aug  1 03:20:06 amaryllis kernel:  [copy_mm+314/1776] copy_mm+0x13a/0x6f0
Aug  1 03:20:06 amaryllis kernel:  [copy_mm+348/1776] copy_mm+0x15c/0x6f0
Aug  1 03:20:06 amaryllis kernel:  [check_poison_obj+82/426] check_poison_o=
bj+0x52/0x1aa
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+156/425] kmem_cache_al=
loc+0x9c/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [copy_process+1372/4275] copy_process+0x=
55c/0x10b3
Aug  1 03:20:06 amaryllis kernel:  [d_alloc+30/898] d_alloc+0x1e/0x382
Aug  1 03:20:06 amaryllis kernel:  [do_fork+77/445] do_fork+0x4d/0x1bd
Aug  1 03:20:06 amaryllis kernel:  [sys_wait4+423/578] sys_wait4+0x1a7/0x242
Aug  1 03:20:06 amaryllis kernel:  [default_wake_function+0/46] default_wak=
e_function+0x0/0x2e
Aug  1 03:20:06 amaryllis kernel:  [sys_fork+56/60] sys_fork+0x38/0x3c
Aug  1 03:20:06 amaryllis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 03:20:06 amaryllis kernel:=20
Aug  1 03:20:06 amaryllis kernel: slab error in cache_alloc_debugcheck_afte=
r(): cache `size-128': memory after object was overwritten
Aug  1 03:20:06 amaryllis kernel: Call Trace:
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+261/425] kmem_cache_al=
loc+0x105/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [cache_grow+1032/1196] cache_grow+0x408/=
0x4ac
Aug  1 03:20:06 amaryllis kernel:  [cache_grow+1032/1196] cache_grow+0x408/=
0x4ac
Aug  1 03:20:06 amaryllis kernel:  [cache_alloc_refill+780/1221] cache_allo=
c_refill+0x30c/0x4c5
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+393/425] kmem_cache_al=
loc+0x189/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [pgd_alloc+27/31] pgd_alloc+0x1b/0x1f
Aug  1 03:20:06 amaryllis kernel:  [mm_init+467/533] mm_init+0x1d3/0x215
Aug  1 03:20:06 amaryllis kernel:  [copy_mm+314/1776] copy_mm+0x13a/0x6f0
Aug  1 03:20:06 amaryllis kernel:  [copy_mm+348/1776] copy_mm+0x15c/0x6f0
Aug  1 03:20:06 amaryllis kernel:  [check_poison_obj+82/426] check_poison_o=
bj+0x52/0x1aa
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+156/425] kmem_cache_al=
loc+0x9c/0x1a9
Aug  1 03:20:06 amaryllis kernel: Slab corruption: start=3Dd4005564, expend=
=3Dd40055e3, problemat=3Dd4005569
Aug  1 03:20:06 amaryllis kernel: Last user: [do_page_cache_readahead+262/1=
011](do_page_cache_readahead+0x106/0x3f3)
Aug  1 03:20:06 amaryllis kernel: Data: *****6A ******6A 6A ******6A 6A ***=
***6A 6A ******6A 6A ******6A 6A ******6A 6A ******6A *******2A *******6A 2=
A *******6A ******2A
 6A ******6A 6A ******6A *******6A ********6A *A5=20
Aug  1 03:20:06 amaryllis kernel: Next: 71 F0 2C .4A 3A 15 C0 A5 C2 0F 17 .=
=2E..................
Aug  1 03:20:06 amaryllis kernel: slab error in check_poison_obj(): cache `=
size-128': object was modified after freeing
Aug  1 03:20:06 amaryllis kernel: Call Trace:
Aug  1 03:20:06 amaryllis kernel:  [check_poison_obj+362/426] check_poison_=
obj+0x16a/0x1aa
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+136/425] kmem_cache_al=
loc+0x88/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [cache_grow+1032/1196] cache_grow+0x408/=
0x4ac
Aug  1 03:20:06 amaryllis kernel:  [cache_grow+1032/1196] cache_grow+0x408/=
0x4ac
Aug  1 03:20:06 amaryllis kernel:  [cache_alloc_refill+780/1221] cache_allo=
c_refill+0x30c/0x4c5
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+393/425] kmem_cache_al=
loc+0x189/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [buffered_rmqueue+228/671] buffered_rmqu=
eue+0xe4/0x29f
Aug  1 03:20:06 amaryllis kernel:  [radix_tree_node_alloc+32/90] radix_tree=
_node_alloc+0x20/0x5a
Aug  1 03:20:06 amaryllis kernel:  [radix_tree_insert+144/202] radix_tree_i=
nsert+0x90/0xca
Aug  1 03:20:06 amaryllis kernel:  [__alloc_pages+749/848] __alloc_pages+0x=
2ed/0x350
Aug  1 03:20:06 amaryllis kernel:  [add_to_page_cache+158/507] add_to_page_=
cache+0x9e/0x1fb
Aug  1 03:20:06 amaryllis kernel:  [unlock_page+22/83] unlock_page+0x16/0x53
Aug  1 03:20:06 amaryllis kernel:  [generic_file_aio_write_nolock+889/2940]=
 generic_file_aio_write_nolock+0x379/0xb7c
Aug  1 03:20:06 amaryllis kernel:  [__kfree_skb+129/246] __kfree_skb+0x81/0=
xf6
Aug  1 03:20:06 amaryllis kernel:  [generic_file_write_nolock+164/189] gene=
ric_file_write_nolock+0xa4/0xbd
Aug  1 03:20:06 amaryllis kernel:  [buffered_rmqueue+228/671] buffered_rmqu=
eue+0xe4/0x29f
Aug  1 03:20:06 amaryllis kernel:  [autoremove_wake_function+0/75] autoremo=
ve_wake_function+0x0/0x4b
Aug  1 03:20:06 amaryllis kernel:  [sockfd_lookup+26/114] sockfd_lookup+0x1=
a/0x72
Aug  1 03:20:06 amaryllis kernel:  [sys_recvfrom+224/241] sys_recvfrom+0xe0=
/0xf1
Aug  1 03:20:06 amaryllis kernel:  [poll_freewait+58/67] poll_freewait+0x3a=
/0x43
Aug  1 03:20:06 amaryllis kernel:  [generic_file_writev+90/210] generic_fil=
e_writev+0x5a/0xd2
Aug  1 03:20:06 amaryllis kernel:  [do_readv_writev+512/646] do_readv_write=
v+0x200/0x286
Aug  1 03:20:06 amaryllis kernel:  [do_sync_write+0/244] do_sync_write+0x0/=
0xf4
Aug  1 03:20:06 amaryllis kernel:  [vfs_writev+82/91] vfs_writev+0x52/0x5b
Aug  1 03:20:06 amaryllis kernel:  [sys_writev+63/93] sys_writev+0x3f/0x5d
Aug  1 03:20:06 amaryllis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 03:20:06 amaryllis kernel:=20
Aug  1 03:20:06 amaryllis kernel: slab error in cache_alloc_debugcheck_afte=
r(): cache `size-128': memory before object was overwritten
Aug  1 03:20:06 amaryllis kernel: Call Trace:
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+221/425] kmem_cache_al=
loc+0xdd/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [cache_grow+1032/1196] cache_grow+0x408/=
0x4ac
Aug  1 03:20:06 amaryllis kernel:  [cache_grow+1032/1196] cache_grow+0x408/=
0x4ac
Aug  1 03:20:06 amaryllis kernel:  [cache_alloc_refill+780/1221] cache_allo=
c_refill+0x30c/0x4c5
Aug  1 03:20:06 amaryllis kernel:  [kmem_cache_alloc+393/425] kmem_cache_al=
loc+0x189/0x1a9
Aug  1 03:20:06 amaryllis kernel:  [buffered_rmqueue+228/671] buffered_rmqu=
eue+0xe4/0x29f
Aug  1 03:20:06 amaryllis kernel:  [radix_tree_node_alloc+32/90] radix_tree=
_node_alloc+0x20/0x5a
Aug  1 03:20:06 amaryllis kernel:  [radix_tree_insert+144/202] radix_tree_i=
nsert+0x90/0xca
Aug  1 03:20:06 amaryllis kernel:  [__alloc_pages+749/848] __alloc_pages+0x=
2ed/0x350
Aug  1 03:20:06 amaryllis kernel:  [add_to_page_cache+158/507] add_to_page_=
cache+0x9e/0x1fb
Aug  1 03:20:06 amaryllis kernel:  [unlock_page+22/83] unlock_page+0x16/0x53
Aug  1 03:20:06 amaryllis kernel:  [generic_file_aio_write_nolock+889/2940]=
 generic_file_aio_write_nolock+0x379/0xb7c
Aug  1 03:20:06 amaryllis kernel:  [__kfree_skb+129/246] __kfree_skb+0x81/0=
xf6
Aug  1 03:20:06 amaryllis kernel:  [generic_file_write_nolock+164/189] gene=
ric_file_write_nolock+0xa4/0xbd
Aug  1 03:20:06 amaryllis kernel:  [buffered_rmqueue+228/671] buffered_rmqu=
eue+0xe4/0x29f
Aug  1 03:20:06 amaryllis kernel:  [autoremove_wake_function+0/75] autoremo=
ve_wake_function+0x0/0x4b
Aug  1 03:20:06 amaryllis kernel:  [sockfd_lookup+26/114] sockfd_lookup+0x1=
a/0x72
Aug  1 03:20:06 amaryllis kernel:  [sys_recvfrom+224/241] sys_recvfrom+0xe0=
/0xf1
Aug  1 03:20:06 amaryllis kernel:  [poll_freewait+58/67] poll_freewait+0x3a=
/0x43
Aug  1 03:20:06 amaryllis kernel:  [generic_file_writev+90/210] generic_fil=
e_writev+0x5a/0xd2
Aug  1 03:20:06 amaryllis kernel:  [do_readv_writev+512/646] do_readv_write=
v+0x200/0x286
Aug  1 03:20:06 amaryllis kernel:  [do_sync_write+0/244] do_sync_write+0x0/=
0xf4
Aug  1 03:20:06 amaryllis kernel:  [vfs_writev+82/91] vfs_writev+0x52/0x5b
Aug  1 03:20:06 amaryllis kernel:  [sys_writev+63/93] sys_writev+0x3f/0x5d
Aug  1 03:20:06 amaryllis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 03:20:06 amaryllis kernel:=20
Aug  1 03:20:06 amaryllis kernel:  [copy_process+1372/4275] copy_process+0x=
55c/0x10b3
Aug  1 03:20:06 amaryllis kernel:  [d_alloc+30/898] d_alloc+0x1e/0x382
Aug  1 03:20:06 amaryllis kernel:  [do_fork+77/445] do_fork+0x4d/0x1bd
Aug  1 03:20:06 amaryllis kernel:  [sys_wait4+423/578] sys_wait4+0x1a7/0x242
Aug  1 03:20:06 amaryllis kernel:  [default_wake_function+0/46] default_wak=
e_function+0x0/0x2e
Aug  1 03:20:06 amaryllis kernel:  [sys_fork+56/60] sys_fork+0x38/0x3c
Aug  1 03:20:06 amaryllis kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  1 03:20:06 amaryllis kernel:=20
Aug  1 09:40:42 amaryllis kernel: klogd 1.4.1#11, log source =3D /proc/kmsg=
 started.

9:40 is when I woke up and discovered my laptop is not running (hang,
that is).

--

Another strange message is:=20

Aug  1 14:35:11 amaryllis kernel: spurious 8259A interrupt: IRQ7.

Any idea what this is?

Eugene

<quote sender=3D"Eugene Teo">
> <quote sender=3D"Stefano Rivoir">
> > Eugene Teo wrote:
> >=20
> > >One thing strange though.
> >=20
> > [...]
> >=20
> > Ok, I think I've found. It was very probably an old version of the
> > synaptics module for X4.3 (it was ...p3). With the new driver,
> > and with DRI too (along with test2-mm2 patch), it seems to be OK.
> > At least, I've seen no hangs so far.
>=20
> Hmm, can you explain the synaptics module? i experienced a hang again
> last night. about 5-6 hours of no activities, and i can't get my box
> back up again except with a hard reboot.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KhHJcyGjihSg3eURApsjAJ99+93Qmskt202HuljHoiZQ6Y4uGwCgjxj6
IRr3ef8vdd8Z96Qi1PnJWMs=
=byMx
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
