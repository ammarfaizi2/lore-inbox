Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265711AbUAPSRe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbUAPSRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:17:34 -0500
Received: from smtp03.web.de ([217.72.192.158]:37389 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265711AbUAPSRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:17:30 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Oops in register_proc_table (2.6.1-mm4)
Date: Fri, 16 Jan 2004 19:17:16 +0100
User-Agent: KMail/1.5.4
References: <20040115225948.6b994a48.akpm@osdl.org>
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_wqCCAnOoOK0l4QL";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401161917.20713.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_wqCCAnOoOK0l4QL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Hi Andrew,

I just saw following Oops in my Kernel messages. I didn'd have this with -m=
m3.

NET: Registered protocol family 10
Unable to handle kernel paging request at virtual address 000927c0
 printing eip:
c012ba17
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c012ba17>]    Not tainted VLI
EFLAGS: 00010246
EIP is at register_proc_table+0x47/0x120
eax: 00000000   ebx: e106c9ec   ecx: ffffffff   edx: 000927c0
esi: 00000000   edi: 000927c0   ebp: c012b130   esp: de4ddd7c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1936, threadinfo=3Dde4dc000 task=3Dde9e3900)
Stack: e1061159 000081a4 de6e5c40 81a40000 de6e5c40 e106d480 00000000 de6e5=
c40
       00000000 c012ba7c e10617fc 0000416d de6e5cc0 416d0000 de6e5cc0 e106d=
640
       00000000 de6e5cc0 00000000 c012ba7c e1061862 0000416d dffccac0 416dd=
dec
Call Trace:
 [<c012ba7c>] register_proc_table+0xac/0x120
 [<c012ba7c>] register_proc_table+0xac/0x120
 [<c012ba7c>] register_proc_table+0xac/0x120
 [<c012bb4e>] register_sysctl_table+0x5e/0x80
 [<e105d347>] ipv6_sysctl_register+0x17/0x20 [ipv6]
 [<e0e9018b>] inet6_init+0x18b/0x2d0 [ipv6]
 [<c013b62b>] sys_init_module+0x17b/0x1670
 [<c0152cd6>] vma_link+0x76/0xc0
 [<c015423c>] do_mmap_pgoff+0x38c/0x6f9
 [<c015e109>] filp_close+0x59/0xa0
 [<c015e1ab>] sys_close+0x5b/0xa0
 [<c02df843>] syscall_call+0x7/0xb

Code: 33 85 f6 0f 84 9b 00 00 00 8b 53 04 85 d2 89 d7 74 ea 8b 73 18 85 f6 =
75=20
0b 8b 43 14 85 c0 0f 84 cb 00 00 00 31 c0 b9 ff ff ff ff <f2> a
e f7 d1 49 85 f6 0f b7 43 10 89 cd 66 89 44 24 0e 74 6d 66
 <7>request_module: failed /sbin/modprobe -- net-pf-10. error =3D 11

If this is not enough information to track down the problem I can provide=20
my .config of any other information, of course.

Best regards
   Thomas Schlichter

--Boundary-02=_wqCCAnOoOK0l4QL
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBACCqwYAiN+WRIZzQRAuE/AJ9VGk2t/rCBXrqu44Gg89tJziHWqwCgqgi5
NqktzTS4qOD6iGJ2wIoXOeY=
=w4Ru
-----END PGP SIGNATURE-----

--Boundary-02=_wqCCAnOoOK0l4QL--

