Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTJTQLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTJTQLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:11:39 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:27368 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262672AbTJTQLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:11:34 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test8-mm1
Date: Mon, 20 Oct 2003 18:11:10 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031020020558.16d2a776.akpm@osdl.org>
In-Reply-To: <20031020020558.16d2a776.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_lkAl/YWEDTuwuEa";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310201811.18310.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_lkAl/YWEDTuwuEa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 October 2003 11:05, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test8=
/2
>.6.0-test8-mm1
>
>
> . Included a much updated fbdev patch.  Anyone who is using framebuffers,
>   please test this.
>
> . Quite a large number of stability fixes.

I've got a problem with NFS!
If the kernel NFS server (nfs-utils 1.0.6) is started I get following Oops:

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0163c36
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[invalidate_list+37/211]    Not tainted VLI
EFLAGS: 00010203
EIP is at invalidate_list+0x25/0xd3
eax: cded1e00   ebx: c13a80c0   ecx: c02e83a0   edx: cf35c000
esi: 00000000   edi: cf35df38   ebp: 00000000   esp: cf35df10
ds: 007b   es: 007b   ss: 0068
Process exportfs (pid: 1029, threadinfo=3Dcf35c000 task=3Dcefac0c0)
Stack: 00000000 00000000 cded1e00 cf35c000 cf35df38 cffe7c88 c0163d22 c02e8=
390
       cded1e00 cf35df38 cf35df38 cf35df38 cd584980 cded1e00 c02e8640 cffe7=
c88
       c01542f9 cded1e00 0000000e cf35c000 d1a2fde0 c0154bca cded1e00 cded1=
e00
Call Trace:
 [invalidate_inodes+62/162] invalidate_inodes+0x3e/0xa2
 [generic_shutdown_super+109/375] generic_shutdown_super+0x6d/0x177
 [kill_anon_super+14/56] kill_anon_super+0xe/0x38
 [deactivate_super+82/144] deactivate_super+0x52/0x90
 [__fput+228/235] __fput+0xe4/0xeb
 [sys_nfsservctl+257/267] sys_nfsservctl+0x101/0x10b
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: fb ff 5b 5e 5f c3 55 31 ed 57 56 53 50 50 8b 44 24 1c 8b 7c 24 24 c7 =
04=20
24
 <6>note: exportfs[1029] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [schedule+60/1207] schedule+0x3c/0x4b7
 [unmap_vmas+336/471] unmap_vmas+0x150/0x1d7
 [exit_mmap+104/339] exit_mmap+0x68/0x153
 [mmput+123/184] mmput+0x7b/0xb8
 [do_exit+345/836] do_exit+0x159/0x344
 [do_divide_error+0/167] do_divide_error+0x0/0xa7
 [do_page_fault+784/1105] do_page_fault+0x310/0x451
 [update_process_times+41/47] update_process_times+0x29/0x2f
 [update_wall_time+11/51] update_wall_time+0xb/0x33
 [do_timer+76/193] do_timer+0x4c/0xc1
 [do_timer_interrupt+55/224] do_timer_interrupt+0x37/0xe0
 [timer_interrupt+40/71] timer_interrupt+0x28/0x47
 [rcu_process_callbacks+203/220] rcu_process_callbacks+0xcb/0xdc
 [tasklet_action+58/89] tasklet_action+0x3a/0x59
 [profile_hook+28/49] profile_hook+0x1c/0x31
 [do_page_fault+0/1105] do_page_fault+0x0/0x451
 [error_code+47/56] error_code+0x2f/0x38
 [invalidate_list+37/211] invalidate_list+0x25/0xd3
 [invalidate_inodes+62/162] invalidate_inodes+0x3e/0xa2
 [generic_shutdown_super+109/375] generic_shutdown_super+0x6d/0x177
 [kill_anon_super+14/56] kill_anon_super+0xe/0x38
 [deactivate_super+82/144] deactivate_super+0x52/0x90
 [__fput+228/235] __fput+0xe4/0xeb
 [sys_nfsservctl+257/267] sys_nfsservctl+0x101/0x10b
 [syscall_call+7/11] syscall_call+0x7/0xb


It just worked smoothly with 2.6.0-test7-mm1!

Regards
   Thomas

--Boundary-02=_lkAl/YWEDTuwuEa
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/lAklYAiN+WRIZzQRAkThAKCMsT1nWKP3J3hawrwyOTKJu5e99gCgxwLv
6sxH1nnxzdM8TVxrf8WJi/M=
=GHj8
-----END PGP SIGNATURE-----

--Boundary-02=_lkAl/YWEDTuwuEa--
