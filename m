Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTEMM4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbTEMM4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:56:33 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:2784 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S261179AbTEMM4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:56:13 -0400
Subject: other BUGs and Oopsen
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052825102.3441.0.camel@tor.trudheim.com>
References: <1052823517.5022.3.camel@tor.trudheim.com>
	 <1052824488.4699.0.camel@laptop.fenrus.com>
	 <1052825102.3441.0.camel@tor.trudheim.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ln24udYwGkH7DXGFihUL"
Organization: Trudheim Technology Limited
Message-Id: <1052831333.5349.24.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 13 May 2003 14:08:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ln24udYwGkH7DXGFihUL
Content-Type: multipart/mixed; boundary="=-vRJs0M/Oz/ES6TKXsELc"


--=-vRJs0M/Oz/ES6TKXsELc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

More Oopses found. Attached in no particular order. This is my
workstation that is mis-behaving. If anyone has patches, ideas, pointers
and things I can try out, let me know.

Thanks in advance,

/Anders

--=-vRJs0M/Oz/ES6TKXsELc
Content-Disposition: attachment; filename=oopsen.txt
Content-Type: text/plain; name=oopsen.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

May 13 01:06:40 tor kernel: kernel BUG at page_alloc.c:231!
May 13 01:06:40 tor kernel: invalid operand: 0000
May 13 01:06:40 tor kernel: CPU:    0
May 13 01:06:40 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 01:06:40 tor kernel: EFLAGS: 00210202
May 13 01:06:40 tor kernel: eax: 010000c4   ebx: c12e69d0   ecx: 0000f789  =
 edx: 00001000
May 13 01:06:40 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: d2443e6c
May 13 01:06:40 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 01:06:40 tor kernel: Process autom4te (pid: 26468, stackpage=3Dd2443=
000)
May 13 01:06:40 tor kernel: Stack: 00001000 00200296 0000e789 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 01:06:40 tor kernel:        00000000 000001d2 c01387f1 000000ca c029=
6850 c02969d0 c01cec30 00104025=20
May 13 01:06:40 tor kernel:        00000001 db88d380 ecebbec8 c012da1e cf78=
a000 00000000 00001000 083b203c=20
May 13 01:06:40 tor kernel: Call Trace:    [__alloc_pages+65/384] [dma_time=
r_expiry+0/240] [do_anonymous_page+94/304] [handle_mm_fault+123/320] [do_pa=
ge_fault+676/1239]
May 13 01:06:40 tor kernel:   [ide_do_request+103/400] [do_brk+284/512] [sy=
s_brk+304/320] [do_page_fault+0/1239] [error_code+52/60]
May 13 01:06:40 tor kernel:=20
May 13 01:06:40 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 01:06:40 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 01:06:40 tor kernel: invalid operand: 0000
May 13 01:06:40 tor kernel: CPU:    0
May 13 01:06:40 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 01:06:40 tor kernel: EFLAGS: 00210202
May 13 01:06:40 tor kernel: eax: 010000c4   ebx: c12e69a0   ecx: 0000f788  =
 edx: 00001000
May 13 01:06:40 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: d4111e6c
May 13 01:06:40 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 01:06:40 tor kernel: Process aclocal (pid: 26619, stackpage=3Dd41110=
00)
May 13 01:06:40 tor kernel: Stack: c190c3c0 c4f8da40 0000e788 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 01:06:40 tor kernel:        00000000 000001d2 c01387f1 ecbfc1e0 c029=
6850 c02969d0 ca030348 00104025=20
May 13 01:06:40 tor kernel:        00000001 ecbfc0c0 ca030790 c012da1e d47a=
0000 00000000 00001000 081e401c=20
May 13 01:06:40 tor kernel: Call Trace:    [__alloc_pages+65/384] [do_anony=
mous_page+94/304] [handle_mm_fault+123/320] [do_page_fault+676/1239] [file_=
read_actor+0/240]
May 13 01:06:40 tor kernel:   [do_brk+284/512] [sys_brk+304/320] [do_page_f=
ault+0/1239] [error_code+52/60]
May 13 01:06:40 tor kernel:=20
May 13 01:06:40 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 01:07:30 tor kernel:  <1>Unable to handle kernel NULL pointer derefe=
rence at virtual address 00000004
May 13 01:07:30 tor kernel:  printing eip:
May 13 01:07:30 tor kernel: c01382b0
May 13 01:07:30 tor kernel: *pde =3D 00000000
May 13 01:07:30 tor kernel: Oops: 0002
May 13 01:07:30 tor kernel: CPU:    0
May 13 01:07:30 tor kernel: EIP:    0010:[__free_pages_ok+512/688]    Taint=
ed: PF
May 13 01:07:30 tor kernel: EFLAGS: 00210082
May 13 01:07:30 tor kernel: eax: 00000000   ebx: c12e0be0   ecx: c12e0c40  =
 edx: 00000000
May 13 01:07:30 tor kernel: esi: 0000e596   edi: 0002ef60   ebp: c029687c  =
 esp: d92b9ee0
May 13 01:07:30 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 01:07:30 tor kernel: Process m4 (pid: 3108, stackpage=3Dd92b9000)
May 13 01:07:30 tor kernel: Stack: c02968dc c1000020 c12e0c40 c0296850 c103=
0020 00200202 fffffffe 00003965=20
May 13 01:07:30 tor kernel:        0033d000 d0131cf4 00400000 0000033e c012=
e318 c12e0c40 eebe4400 db1d3c80=20
May 13 01:07:30 tor kernel:        c155ba10 08800000 d6bc3088 08800000 0000=
0000 c012c95b ecf0e440 d6bc3084=20
May 13 01:07:30 tor kernel: Call Trace:    [zap_pte_range+264/329] [zap_pag=
e_range+139/256] [exit_mmap+211/352] [mmput+68/160] [do_exit+212/624]
May 13 01:07:30 tor kernel:   [sys_exit+19/32] [system_call+51/56]
May 13 01:07:30 tor kernel:=20
May 13 01:07:30 tor kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03=
 00 00 00 00 d1 64=20
May 13 01:09:34 tor kernel:  <1>Unable to handle kernel NULL pointer derefe=
rence at virtual address 00000004
May 13 01:09:34 tor kernel:  printing eip:
May 13 01:09:34 tor kernel: c01382b0
May 13 01:09:34 tor kernel: *pde =3D 00000000
May 13 01:09:34 tor kernel: Oops: 0002
May 13 01:09:34 tor kernel: CPU:    0
May 13 01:09:34 tor kernel: EIP:    0010:[__free_pages_ok+512/688]    Taint=
ed: PF
May 13 01:09:34 tor kernel: EFLAGS: 00210082
May 13 01:09:34 tor kernel: eax: 00000000   ebx: c12d1dc0   ecx: c12d1d60  =
 edx: 00000000
May 13 01:09:34 tor kernel: esi: 0000e09c   edi: 0002ef60   ebp: c029687c  =
 esp: d9133ee0
May 13 01:09:34 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 01:09:34 tor kernel: Process ld (pid: 23902, stackpage=3Dd9133000)
May 13 01:09:34 tor kernel: Stack: c02968dc c1000020 c12d1d60 c0296850 c103=
0020 00200206 fffffffe 00003827=20
May 13 01:09:34 tor kernel:        0012a000 d8de44a8 0026a000 0000012b c012=
e318 c12d1d60 d949caa0 d949c5c0=20
May 13 01:09:34 tor kernel:        d9132000 09400000 d4c73094 0926a000 0000=
0000 c012c95b d97bc360 d4c73090=20
May 13 01:09:34 tor kernel: Call Trace:    [zap_pte_range+264/329] [zap_pag=
e_range+139/256] [exit_mmap+211/352] [mmput+68/160] [do_exit+212/624]
May 13 01:09:34 tor kernel:   [sys_exit+19/32] [system_call+51/56]
May 13 01:09:34 tor kernel:=20
May 13 01:09:34 tor kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03=
 00 00 00 00 d1 64=20
May 13 01:09:34 tor kernel:  kernel BUG at inode.c:562!
May 13 01:09:34 tor kernel: invalid operand: 0000
May 13 01:09:34 tor kernel: CPU:    0
May 13 01:09:34 tor kernel: EIP:    0010:[clear_inode+26/240]    Tainted: P=
F
May 13 01:09:34 tor kernel: EFLAGS: 00210206
May 13 01:09:34 tor kernel: eax: d1032760   ebx: d1032740   ecx: 00000005  =
 edx: d1032760
May 13 01:09:34 tor kernel: esi: 00000000   edi: d10327a8   ebp: d1032740  =
 esp: d3b5df04
May 13 01:09:34 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 01:09:34 tor kernel: Process collect2 (pid: 23901, stackpage=3Dd3b5d=
000)
May 13 01:09:34 tor kernel: Stack: d1032740 d3b5df1c f0824b37 d1032740 0000=
0000 00000024 f08495c3 00000001=20
May 13 01:09:34 tor kernel:        00000024 00000fa8 eebe4400 d10327ec c012=
ff67 00000000 d1032740 f0824a60=20
May 13 01:09:34 tor kernel:        f08499a0 e715cba0 c0155fdd d1032740 0000=
0000 00000000 00000000 d22df040=20
May 13 01:09:34 tor kernel: Call Trace:    [i810_audio:__insmod_i810_audio_=
O/lib/modules/2.4.21-rc2/kernel/drivers+-9262281/96] [i810_audio:__insmod_i=
810_audio_O/lib/modules/2.4.21-rc2/
kernel/drivers+-9112125/96] [truncate_inode_pages+103/128] [i810_audio:__in=
smod_i810_audio_O/lib/modules/2.4.21-rc2/kernel/drivers+-9262496/96] [i810_=
audio:__insmod_i810_audio_O/lib/mod
ules/2.4.21-rc2/kernel/drivers+-9111136/96]
May 13 01:09:34 tor kernel:   [iput+445/640] [vfs_unlink+389/480] [sys_unli=
nk+186/304] [system_call+51/56]
May 13 01:09:34 tor kernel:=20
May 13 01:09:34 tor kernel: Code: 0f 0b 32 02 a0 7d 26 c0 8b 83 f8 00 00 00=
 a8 10 75 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 01000040   ebx: c12e3d90   ecx: 0000f69d  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: d6957eec
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process tar (pid: 25012, stackpage=3Dd6957000)
May 13 06:48:04 tor kernel: Stack: 00001000 0000bc00 0000e69d 00200292 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 eebe4400 c029=
6850 c02969d0 00000c00 0000000c=20
May 13 06:48:04 tor kernel:        00000000 efce0d64 00000000 c01331d2 d9e0=
9d24 0000000c efce0d64 00001000=20
May 13 06:48:04 tor kernel: Call Trace:    [__alloc_pages+65/384] [generic_=
file_write+802/2080] [sys_write+147/336] [sys_open+121/176] [system_call+51=
/56]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 0100004c   ebx: c12e3d60   ecx: 0000f69c  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: d62d5e6c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process sh (pid: 25014, stackpage=3Dd62d5000)
May 13 06:48:04 tor kernel: Stack: 00000000 c0296850 0000e69c 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 d93f8d40 c029=
6850 c02969d0 d01320bc 00000000=20
May 13 06:48:04 tor kernel:        c10030e0 00104025 d93f8c20 c012d3f1 c100=
30e0 00000000 00001000 080c0000=20
May 13 06:48:04 tor kernel: Call Trace:    [__alloc_pages+65/384] [do_wp_pa=
ge+81/624] [handle_mm_fault+317/320] [do_page_fault+676/1239] [do_mmap_pgof=
f+811/1424]
May 13 06:48:04 tor kernel:   [old_mmap+222/288] [filp_close+77/144] [do_pa=
ge_fault+0/1239] [error_code+52/60]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 01000040   ebx: c12e3cd0   ecx: 0000f699  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: da915e6c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process sh (pid: 25019, stackpage=3Dda915000)
May 13 06:48:04 tor kernel: Stack: 00001000 00000000 0000e699 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 00000000 c029=
6850 c02969d0 00000000 00000000=20
May 13 06:48:04 tor kernel:        c131c3a0 10968065 c2625900 c012d3f1 c131=
c3a0 d5a80000 00001000 401d4f60=20
May 13 06:48:04 tor kernel: Call Trace:    [__alloc_pages+65/384] [do_wp_pa=
ge+81/624] [handle_mm_fault+317/320] [do_page_fault+676/1239] [path_release=
+18/64]
May 13 06:48:04 tor kernel:   [__user_walk+92/128] [sys_stat64+31/128] [do_=
page_fault+0/1239] [error_code+52/60]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 0100004c   ebx: c12e3ca0   ecx: 0000f698  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: cde4be6c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process bzip2 (pid: 25018, stackpage=3Dcde4b000=
)
May 13 06:48:04 tor kernel: Stack: 00000006 c0142a8b 0000e698 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 cde4a000 c029=
6850 c02969d0 cde4bed8 00104025=20
May 13 06:48:04 tor kernel:        00000001 dae9aba0 e979163c c012da1e ecf0=
ee40 cde4a000 00000000 4018f000=20
May 13 06:48:04 tor kernel: Call Trace:    [block_read_full_page+667/704] [=
__alloc_pages+65/384] [do_anonymous_page+94/304] [handle_mm_fault+123/320] =
[do_page_fault+676/1239]
May 13 06:48:04 tor kernel:   [process_timeout+0/32] [i810_audio:__insmod_i=
810_audio_O/lib/modules/2.4.21-rc2/kernel/drivers+-672023/96] [run_timer_li=
st+332/368] [schedule+531/848] [do_
page_fault+0/1239] [error_code+52/60]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 01000040   ebx: c12e3c10   ecx: 0000f695  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: cd649e7c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process bzip2 (pid: 25023, stackpage=3Dcd649000=
)
May 13 06:48:04 tor kernel: Stack: 00001000 00000004 0000e695 00200292 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 00104025 c029=
6850 c02969d0 c12e3c70 c84e9ee4=20
May 13 06:48:04 tor kernel:        0000000b 00000013 efc4ed58 c0130598 c12e=
3c70 f0825800 00000012 efc4ed54=20
May 13 06:48:04 tor kernel: Call Trace:    [__alloc_pages+65/384] [page_cac=
he_read+104/208] [i810_audio:__insmod_i810_audio_O/lib/modules/2.4.21-rc2/k=
ernel/drivers+-9259008/96] [generic
_file_readahead+175/416] [do_generic_file_read+425/1072]
May 13 06:48:04 tor kernel:   [file_read_actor+0/240] [generic_file_read+32=
0/352] [file_read_actor+0/240] [sys_read+147/336] [system_call+51/56]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 010000cc   ebx: c12e3be0   ecx: 0000f694  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: dd29fe6c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process rpm (pid: 25025, stackpage=3Ddd29f000)
May 13 06:48:04 tor kernel: Stack: c01ed3b2 c1909348 0000e694 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 d93f84a0 c029=
6850 c02969d0 dd06db90 00104025=20
May 13 06:48:04 tor kernel:        00000001 db878a80 c6e94580 c012da1e d096=
9000 00000000 00001000 08160240=20
May 13 06:48:04 tor kernel: Call Trace:    [sk_free+82/160] [__alloc_pages+=
65/384] [do_anonymous_page+94/304] [handle_mm_fault+123/320] [do_page_fault=
+676/1239]
May 13 06:48:04 tor kernel:   [do_munmap+655/672] [do_page_fault+0/1239] [e=
rror_code+52/60]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 01000040   ebx: c12e3b50   ecx: 0000f691  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: d0ab3e6c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process bzip2 (pid: 25029, stackpage=3Dd0ab3000=
)
May 13 06:48:04 tor kernel: Stack: 00001000 c0296850 0000e691 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 dae9a600 c029=
6850 c02969d0 d79ed0b8 00104025=20
May 13 06:48:04 tor kernel:        00000001 dae9a960 df0b9170 c012da1e cf69=
2000 00000000 00001000 0805c284=20
May 13 06:48:04 tor kernel: Call Trace:    [__alloc_pages+65/384] [do_anony=
mous_page+94/304] [handle_mm_fault+123/320] [do_page_fault+676/1239] [do_mm=
ap_pgoff+1129/1424]
May 13 06:48:04 tor kernel:   [old_mmap+222/288] [do_page_fault+0/1239] [er=
ror_code+52/60]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 0100004c   ebx: c12e3b20   ecx: 0000f690  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: d5a9fe6c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process sh (pid: 25030, stackpage=3Dd5a9f000)
May 13 06:48:04 tor kernel: Stack: 00000000 00000000 0000e690 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 00000000 c029=
6850 c02969d0 00000000 00000000=20
May 13 06:48:04 tor kernel:        c1328d30 10d9b065 c2625900 c012d3f1 c132=
8d30 d945b000 00001000 401d1ef4=20
May 13 06:48:04 tor kernel: Call Trace:    [__alloc_pages+65/384] [do_wp_pa=
ge+81/624] [handle_mm_fault+317/320] [do_page_fault+676/1239] [sys_rt_sigac=
tion+176/208]
May 13 06:48:04 tor kernel:   [filp_close+77/144] [do_page_fault+0/1239] [e=
rror_code+52/60]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 01000040   ebx: c12e3a90   ecx: 0000f68d  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: cf40de6c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process bzip2 (pid: 25034, stackpage=3Dcf40d000=
)
May 13 06:48:04 tor kernel: Stack: 00001000 c0296850 0000e68d 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 d93f8800 c029=
6850 c02969d0 e97910b8 00104025=20
May 13 06:48:04 tor kernel:        00000001 d93f8920 e97917bc c012da1e cf68=
e000 00000000 00001000 401ef000=20
May 13 06:48:04 tor kernel: Call Trace:    [__alloc_pages+65/384] [do_anony=
mous_page+94/304] [handle_mm_fault+123/320] [do_page_fault+676/1239] [file_=
read_actor+0/240]
May 13 06:48:04 tor kernel:   [generic_file_read+320/352] [file_read_actor+=
0/240] [sys_read+231/336] [do_page_fault+0/1239] [error_code+52/60]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:04 tor kernel:  kernel BUG at page_alloc.c:231!
May 13 06:48:04 tor kernel: invalid operand: 0000
May 13 06:48:04 tor kernel: CPU:    0
May 13 06:48:04 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 06:48:04 tor kernel: EFLAGS: 00210202
May 13 06:48:04 tor kernel: eax: 0100004c   ebx: c12e3a60   ecx: 0000f68c  =
 edx: 00001000
May 13 06:48:04 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: d5a95e6c
May 13 06:48:04 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:04 tor kernel: Process sh (pid: 25035, stackpage=3Dd5a95000)
May 13 06:48:04 tor kernel: Stack: 00000000 00000000 0000e68c 00200296 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 06:48:04 tor kernel:        00000000 000001d2 c01387f1 00000000 c029=
6850 c02969d0 00000000 00000000=20
May 13 06:48:04 tor kernel:        c1311a80 105e2065 d93f83e0 c012d3f1 c131=
1a80 d05e1000 00001000 400140a0=20
May 13 06:48:04 tor kernel: Call Trace:    [__alloc_pages+65/384] [do_wp_pa=
ge+81/624] [handle_mm_fault+317/320] [do_page_fault+676/1239] [do_sigaction=
+267/320]
May 13 06:48:04 tor kernel:   [sys_rt_sigaction+176/208] [sys_stat64+70/128=
] [do_page_fault+0/1239] [error_code+52/60]
May 13 06:48:04 tor kernel:=20
May 13 06:48:04 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 06:48:06 tor kernel:  <1>Unable to handle kernel NULL pointer derefe=
rence at virtual address 00000004
May 13 06:48:06 tor kernel:  printing eip:
May 13 06:48:06 tor kernel: c01382b0
May 13 06:48:06 tor kernel: *pde =3D 00000000
May 13 06:48:06 tor kernel: Oops: 0002
May 13 06:48:06 tor kernel: CPU:    0
May 13 06:48:06 tor kernel: EIP:    0010:[__free_pages_ok+512/688]    Taint=
ed: PF
May 13 06:48:06 tor kernel: EFLAGS: 00210082
May 13 06:48:06 tor kernel: eax: 00000000   ebx: c12dadc0   ecx: c12dad60  =
 edx: 00000000
May 13 06:48:06 tor kernel: esi: 0000e39c   edi: 0002ef60   ebp: c029687c  =
 esp: d0b9bee0
May 13 06:48:06 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 06:48:06 tor kernel: Process ld (pid: 25332, stackpage=3Dd0b9b000)
May 13 06:48:06 tor kernel: Stack: c02968dc c1000020 c12dad60 c0296850 c103=
0020 00200202 fffffffe 000038e7=20
May 13 06:48:06 tor kernel:        00328000 eb753f08 00366000 00000329 c012=
e318 c12dad60 d93f8500 ed1485c0=20
May 13 06:48:06 tor kernel:        d0b9a000 08400000 d0b99084 08400000 0000=
0000 c012c95b d97bc760 d0b99080=20
May 13 06:48:06 tor kernel: Call Trace:    [zap_pte_range+264/329] [zap_pag=
e_range+139/256] [exit_mmap+211/352] [mmput+68/160] [do_exit+212/624]
May 13 06:48:06 tor kernel:   [sys_exit+19/32] [system_call+51/56]
May 13 06:48:06 tor kernel:=20
May 13 06:48:06 tor kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03=
 00 00 00 00 d1 64=20
May 13 11:32:01 tor kernel: kernel BUG at page_alloc.c:231!
May 13 11:32:01 tor kernel: invalid operand: 0000
May 13 11:32:01 tor kernel: CPU:    0
May 13 11:32:01 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 11:32:01 tor kernel: EFLAGS: 00210202
May 13 11:32:01 tor kernel: eax: 010000cc   ebx: c178c560   ecx: 0002841c  =
 edx: 00001000
May 13 11:32:01 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: e0a3ff10
May 13 11:32:01 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 11:32:01 tor kernel: Process sh (pid: 15362, stackpage=3De0a3f000)
May 13 11:32:01 tor kernel: Stack: 08070ae0 00000000 0002741c 00200282 0000=
0001 c0296850 c02969b4 00000200=20
May 13 11:32:01 tor kernel:        00000001 000001f0 c01387f1 d0d6dac0 c029=
6850 c02969b0 00000004 e0a3e000=20
May 13 11:32:01 tor kernel:        bfffe760 00000011 fffffff4 c013894c c011=
c635 5d313036 080d1000 080d2000=20
May 13 11:32:01 tor kernel: Call Trace:    [__alloc_pages+65/384] [__get_fr=
ee_pages+28/32] [do_fork+85/1824] [sys_llseek+184/208] [sys_fork+39/48]
May 13 11:32:01 tor kernel:   [system_call+51/56]
May 13 11:32:01 tor kernel:=20
May 13 11:32:01 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 11:38:23 tor kernel: kernel BUG at page_alloc.c:231!
May 13 11:38:23 tor kernel: invalid operand: 0000
May 13 11:38:23 tor kernel: CPU:    0
May 13 11:38:23 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 11:38:23 tor kernel: EFLAGS: 00210202
May 13 11:38:23 tor kernel: eax: 010000cc   ebx: c1792530   ecx: 0002861b  =
 edx: 00001000
May 13 11:38:23 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: d93d9ec0
May 13 11:38:23 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 11:38:23 tor kernel: Process ld (pid: 18604, stackpage=3Dd93d9000)
May 13 11:38:23 tor kernel: Stack: 00001000 00000256 0002761b 00200286 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 11:38:23 tor kernel:        00000000 000001d2 c01387f1 00000266 c029=
6850 c02969d0 00000001 efcda258=20
May 13 11:38:23 tor kernel:        00000000 cdd9d7e4 0000006a c013110b 0000=
0266 c17933d0 c0142f09 cdd9d740=20
May 13 11:38:23 tor kernel: Call Trace:    [__alloc_pages+65/384] [do_gener=
ic_file_read+1003/1072] [block_prepare_write+57/160] [file_read_actor+0/240=
] [generic_file_read+320/352]
May 13 11:38:23 tor kernel:   [file_read_actor+0/240] [sys_read+147/336] [s=
ystem_call+51/56]
May 13 11:38:23 tor kernel:=20
May 13 11:38:23 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 11:48:00 tor kernel: kernel BUG at inode.c:562!
May 13 11:48:00 tor kernel: invalid operand: 0000
May 13 11:48:00 tor kernel: CPU:    0
May 13 11:48:00 tor kernel: EIP:    0010:[clear_inode+26/240]    Tainted: P=
F
May 13 11:48:00 tor kernel: EFLAGS: 00210202
May 13 11:48:00 tor kernel: eax: c37f5220   ebx: c37f5200   ecx: 00000001  =
 edx: c37f5220
May 13 11:48:00 tor kernel: esi: 00000000   edi: c37f5268   ebp: c37f5200  =
 esp: cbd5df04
May 13 11:48:00 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 11:48:00 tor kernel: Process rm (pid: 16212, stackpage=3Dcbd5d000)
May 13 11:48:00 tor kernel: Stack: c37f5200 cbd5df1c f0824b37 c37f5200 0000=
0000 00000024 f08495c3 00000000=20
May 13 11:48:00 tor kernel:        00000024 00001494 ef333c00 c37f52ac c012=
ff67 00000000 c37f5200 f0824a60=20
May 13 11:48:00 tor kernel:        f08499a0 e81b30c0 c0155fdd c37f5200 0000=
0000 00000000 00000000 e905c200=20
May 13 11:48:00 tor kernel: Call Trace:    [mousedev:__insmod_mousedev_O/li=
b/modules/2.4.21-rc2/kernel/drivers/i+-8639689/96] [mousedev:__insmod_mouse=
dev_O/lib/modules/2.4.21-rc2/kernel
/drivers/i+-8489533/96] [truncate_inode_pages+103/128] [mousedev:__insmod_m=
ousedev_O/lib/modules/2.4.21-rc2/kernel/drivers/i+-8639904/96] [mousedev:__=
insmod_mousedev_O/lib/modules/2.4.2
1-rc2/kernel/drivers/i+-8488544/96]
May 13 11:48:00 tor kernel:   [iput+445/640] [vfs_unlink+389/480] [sys_unli=
nk+186/304] [system_call+51/56]
May 13 11:48:00 tor kernel:=20
May 13 11:48:00 tor kernel: Code: 0f 0b 32 02 a0 7d 26 c0 8b 83 f8 00 00 00=
 a8 10 75 08 0f 0b=20
May 13 11:49:14 tor kernel: kernel BUG at inode.c:562!
May 13 11:49:14 tor kernel: invalid operand: 0000
May 13 11:49:14 tor kernel: CPU:    0
May 13 11:49:14 tor kernel: EIP:    0010:[clear_inode+26/240]    Tainted: P=
F
May 13 11:49:14 tor kernel: EFLAGS: 00210202
May 13 11:49:14 tor kernel: eax: e75f83e0   ebx: e75f83c0   ecx: 00000001  =
 edx: e75f83e0
May 13 11:49:14 tor kernel: esi: 00000000   edi: e75f8428   ebp: e75f83c0  =
 esp: ed69ff04
May 13 11:49:14 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 11:49:14 tor kernel: Process rm (pid: 16223, stackpage=3Ded69f000)
May 13 11:49:14 tor kernel: Stack: e75f83c0 ed69ff1c f0824b37 e75f83c0 0000=
0000 00000024 f08495c3 00000000=20
May 13 11:49:14 tor kernel:        00000024 0000149d ef333c00 e75f846c c012=
ff67 00000000 e75f83c0 f0824a60=20
May 13 11:49:14 tor kernel:        f08499a0 e1d91360 c0155fdd e75f83c0 0000=
0000 00000000 00000000 d0ce8c80=20
May 13 11:49:14 tor kernel: Call Trace:    [mousedev:__insmod_mousedev_O/li=
b/modules/2.4.21-rc2/kernel/drivers/i+-8639689/96] [mousedev:__insmod_mouse=
dev_O/lib/modules/2.4.21-rc2/kernel
/drivers/i+-8489533/96] [truncate_inode_pages+103/128] [mousedev:__insmod_m=
ousedev_O/lib/modules/2.4.21-rc2/kernel/drivers/i+-8639904/96] [mousedev:__=
insmod_mousedev_O/lib/modules/2.4.2
1-rc2/kernel/drivers/i+-8488544/96]
May 13 11:49:14 tor kernel:   [iput+445/640] [vfs_unlink+389/480] [sys_unli=
nk+186/304] [system_call+51/56]
May 13 11:49:14 tor kernel:=20
May 13 11:49:14 tor kernel: Code: 0f 0b 32 02 a0 7d 26 c0 8b 83 f8 00 00 00=
 a8 10 75 08 0f 0b=20
May 13 11:59:52 tor kernel: kernel BUG at page_alloc.c:231!
May 13 11:59:52 tor kernel: invalid operand: 0000
May 13 11:59:52 tor kernel: CPU:    0
May 13 11:59:52 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 11:59:52 tor kernel: EFLAGS: 00013202
May 13 11:59:52 tor kernel: eax: 0100004c   ebx: c178f440   ecx: 00028516  =
 edx: 00001000
May 13 11:59:52 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: ce797df0
May 13 11:59:52 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 11:59:52 tor kernel: Process vmware-vmx (pid: 16418, stackpage=3Dce7=
97000)
May 13 11:59:52 tor kernel: Stack: c01c68be 0000000e 00027516 00003286 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 11:59:52 tor kernel:        00000000 000001d2 c01387f1 00003282 c029=
6850 c02969d0 c012297a dbda1624=20
May 13 11:59:52 tor kernel:        00000007 00000070 efcda68c c0130598 c123=
ca20 ce796000 c013085f c123ca20=20
May 13 11:59:52 tor kernel: Call Trace:    [ide_do_request+126/400] [__allo=
c_pages+65/384] [__run_task_queue+90/112] [page_cache_read+104/208] [__lock=
_page+175/192]
May 13 11:59:52 tor kernel:   [read_cluster_nonblocking+89/112] [filemap_no=
page+247/528] [do_no_page+121/512] [handle_mm_fault+123/320] [do_page_fault=
+676/1239] [do_select+553/576]
May 13 11:59:52 tor kernel:   [do_page_fault+0/1239] [error_code+52/60]
May 13 11:59:52 tor kernel:=20
May 13 11:59:52 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 12:00:07 tor kernel: kernel BUG at page_alloc.c:231!
May 13 12:00:07 tor kernel: invalid operand: 0000
May 13 12:00:07 tor kernel: CPU:    0
May 13 12:00:07 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 12:00:07 tor kernel: EFLAGS: 00013202
May 13 12:00:07 tor kernel: eax: 0100004c   ebx: c1792590   ecx: 0002861d  =
 edx: 00001000
May 13 12:00:07 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: e5391c04
May 13 12:00:07 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 12:00:07 tor kernel: Process vmware-vmx (pid: 16446, stackpage=3De53=
91000)
May 13 12:00:07 tor kernel: Stack: 00001000 00003282 0002761d 00003282 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 12:00:07 tor kernel:        00000000 000001d2 c01387f1 00000001 c029=
6850 c02969d0 c0130494 00000000=20
May 13 12:00:07 tor kernel:        00000000 000010bb c34247e4 c013ba0e c342=
4740 000010bb efc46a74 e05292ac=20
May 13 12:00:07 tor kernel: Call Trace:    [__alloc_pages+65/384] [add_to_p=
age_cache+116/144] [shmem_getpage_locked+606/784] [shmem_getpage+105/208] [=
shmem_nopage+54/64]
May 13 12:00:07 tor kernel:   [do_no_page+121/512] [handle_mm_fault+123/320=
] [do_page_fault+676/1239] [process_timeout+25/32] [run_timer_list+332/368]=
 [bh_action+34/64]
May 13 12:00:07 tor kernel:   [tasklet_hi_action+59/112] [do_IRQ+153/176] [=
<f10ae2bb>] [call_apic_timer_interrupt+5/16] [do_page_fault+0/1239] [error_=
code+52/60]
May 13 12:00:07 tor kernel:   [__get_user_1+13/20] [<f10ac3c0>] [<f10adab9>=
] [<f10adc08>] [mousedev:__insmod_mousedev_O/lib/modules/2.4.21-rc2/kernel/=
drivers/i+-46083/96] [<f10ad775>]
May 13 12:00:07 tor kernel:   [<f10ab85c>] [shmem_truncate+117/464] [vmtrun=
cate+342/416] [inode_setattr+112/240] [notify_change+242/464] [rb_insert_co=
lor+191/240]
May 13 12:00:07 tor kernel:   [__vma_link+86/192] [do_mmap_pgoff+811/1424] =
[pipe_write+369/704] [sys_ioctl+164/448] [system_call+51/56]
May 13 12:00:07 tor kernel:=20
May 13 12:00:07 tor kernel: Code: 0f 0b e7 00 b2 6f 26 c0 8b 43 18 a9 80 00=
 00 00 74 08 0f 0b=20
May 13 12:00:32 tor kernel:  kernel BUG at page_alloc.c:102!
May 13 12:00:32 tor kernel: invalid operand: 0000
May 13 12:00:32 tor kernel: CPU:    0
May 13 12:00:32 tor kernel: EIP:    0010:[__free_pages_ok+68/688]    Tainte=
d: PF
May 13 12:00:32 tor kernel: EFLAGS: 00013282
May 13 12:00:32 tor kernel: eax: c3b339a4   ebx: c1792590   ecx: c17925ac  =
 edx: c02966d8
May 13 12:00:32 tor kernel: esi: c1792590   edi: 00000000   ebp: c0296850  =
 esp: c191ff0c
May 13 12:00:32 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 12:00:32 tor kernel: Process kswapd (pid: 5, stackpage=3Dc191f000)
May 13 12:00:32 tor kernel: Stack: 00000001 00003282 e1b5a6e0 e1b5a6e0 e1b5=
a6e0 c1792590 c0144234 e1b5a6e0=20
May 13 12:00:32 tor kernel:        c3b339a4 c1792590 00004d98 c0296850 c013=
74c4 c1792590 000001d0 00000200=20
May 13 12:00:32 tor kernel:        000001d0 0000001a 0000001f 000001d0 0000=
0020 00000006 c0137693 00000006=20
May 13 12:00:32 tor kernel: Call Trace:    [try_to_free_buffers+180/288] [s=
hrink_cache+692/800] [shrink_caches+99/176] [try_to_free_pages_zone+62/96] =
[kswapd_balance_pgdat+83/176]
May 13 12:00:32 tor kernel:   [kswapd_balance+40/64] [kswapd+152/192] [kswa=
pd+0/192] [rest_init+0/64] [arch_kernel_thread+46/64] [kswapd+0/192]
May 13 12:00:32 tor kernel:=20
May 13 12:00:32 tor kernel: Code: 0f 0b 66 00 b2 6f 26 c0 8b 2d 50 bf 2f c0=
 89 d8 29 e8 c1 f8=20
May 13 12:00:49 tor kernel: kernel BUG at page_alloc.c:102!
May 13 12:00:49 tor kernel: invalid operand: 0000
May 13 12:00:49 tor kernel: CPU:    0
May 13 12:00:49 tor kernel: EIP:    0010:[__free_pages_ok+68/688]    Tainte=
d: PF
May 13 12:00:49 tor kernel: EFLAGS: 00013282
May 13 12:00:49 tor kernel: eax: e75f8464   ebx: c178f440   ecx: c178f45c  =
 edx: c02966d8
May 13 12:00:49 tor kernel: esi: c178f440   edi: 00000000   ebp: c0296850  =
 esp: e893bdec
May 13 12:00:49 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 12:00:49 tor kernel: Process X (pid: 3521, stackpage=3De893b000)
May 13 12:00:49 tor kernel: Stack: 00000001 00003282 e0a245a0 e0a245a0 e0a2=
45a0 c178f440 c0144234 e0a245a0=20
May 13 12:00:49 tor kernel:        e75f8464 c178f440 00004df9 c0296850 c013=
74c4 c178f440 000001d2 00000200=20
May 13 12:00:49 tor kernel:        000001d2 0000001b 0000001d 000001d2 0000=
0020 00000006 c0137693 00000006=20
May 13 12:00:49 tor kernel: Call Trace:    [try_to_free_buffers+180/288] [s=
hrink_cache+692/800] [shrink_caches+99/176] [unix_stream_sendmsg+290/800] [=
try_to_free_pages_zone+62/96]
May 13 12:00:49 tor kernel:   [balance_classzone+84/496] [__alloc_pages+233=
/384] [do_anonymous_page+94/304] [handle_mm_fault+123/320] [do_page_fault+6=
76/1239] [do_mmap_pgoff+811/1424]
May 13 12:00:49 tor kernel:   [old_mmap+222/288] [do_page_fault+0/1239] [er=
ror_code+52/60]
May 13 12:00:49 tor kernel:=20
May 13 12:00:49 tor kernel: Code: 0f 0b 66 00 b2 6f 26 c0 8b 2d 50 bf 2f c0=
 89 d8 29 e8 c1 f8=20
May 13 12:00:49 tor kernel:  <1>Unable to handle kernel NULL pointer derefe=
rence at virtual address 00000004
May 13 12:00:49 tor kernel:  printing eip:
May 13 12:00:49 tor kernel: c01382b0
May 13 12:00:49 tor kernel: *pde =3D 00000000
May 13 12:00:49 tor kernel: Oops: 0002
May 13 12:00:49 tor kernel: CPU:    0
May 13 12:00:49 tor kernel: EIP:    0010:[__free_pages_ok+512/688]    Taint=
ed: PF
May 13 12:00:49 tor kernel: EFLAGS: 00210092
May 13 12:00:49 tor kernel: eax: 00000000   ebx: c17923b0   ecx: c1792380  =
 edx: 00000000
May 13 12:00:49 tor kernel: esi: 00027612   edi: 0002ef60   ebp: c0296870  =
 esp: dfd7fee0
May 13 12:00:49 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 12:00:49 tor kernel: Process metacity (pid: 4643, stackpage=3Ddfd7f0=
00)
May 13 12:00:49 tor kernel: Stack: c02968dc c1000020 c1792380 c0296850 c103=
0020 00200206 ffffffff 00013b09=20
May 13 12:00:49 tor kernel:        00023000 dfd5c35c 001d5000 00000016 c012=
e318 c1792380 ddd9c8c0 e74d04c8=20
May 13 12:00:49 tor kernel:        dfd7e000 08400000 e17b0084 08289000 0000=
0000 c012c95b ecf20b40 e17b0080=20
May 13 12:00:49 tor kernel: Call Trace:    [zap_pte_range+264/329] [zap_pag=
e_range+139/256] [exit_mmap+211/352] [mmput+68/160] [do_exit+212/624]
May 13 12:00:49 tor kernel:   [sys_exit+19/32] [system_call+51/56]
May 13 12:00:49 tor kernel:=20
May 13 12:00:49 tor kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03=
 00 00 00 00 d1 64=20
May 13 12:01:20 tor kernel: Unable to handle kernel NULL pointer dereferenc=
e at virtual address 00000004
May 13 12:01:20 tor kernel:  printing eip:
May 13 12:01:20 tor kernel: c01382b0
May 13 12:01:20 tor kernel: *pde =3D 00000000
May 13 12:01:20 tor kernel: Oops: 0002
May 13 12:01:20 tor kernel: CPU:    0
May 13 12:01:20 tor kernel: EIP:    0010:[__free_pages_ok+512/688]    Taint=
ed: PF
May 13 12:01:20 tor kernel: EFLAGS: 00010092
May 13 12:01:20 tor kernel: eax: 00000000   ebx: c178f380   ecx: c178f3b0  =
 edx: 00000000
May 13 12:01:20 tor kernel: esi: 00027513   edi: 0002ef60   ebp: c0296870  =
 esp: e5e9bee0
May 13 12:01:20 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 12:01:20 tor kernel: Process gconfd-2 (pid: 3599, stackpage=3De5e9b0=
00)
May 13 12:01:20 tor kernel: Stack: c02968dc c1000020 c178f3b0 c0296850 c103=
0020 00000203 ffffffff 00013a89=20
May 13 12:01:20 tor kernel:        00357000 ddc51eb4 003aa000 00000358 c012=
e318 c178f3b0 00000292 00000292=20
May 13 12:01:20 tor kernel:        e786e3a0 08400000 df94c084 08400000 0000=
0000 c012c95b ecf20c40 df94c080=20
May 13 12:01:20 tor kernel: Call Trace:    [zap_pte_range+264/329] [zap_pag=
e_range+139/256] [exit_mmap+211/352] [mmput+68/160] [do_exit+212/624]
May 13 12:01:20 tor kernel:   [sys_exit+19/32] [system_call+51/56]
May 13 12:01:20 tor kernel:=20
May 13 12:01:20 tor kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03=
 00 00 00 00 d1 64=20
May 13 13:15:33 tor kernel: Unable to handle kernel NULL pointer dereferenc=
e at virtual address 00000004
May 13 13:15:33 tor kernel:  printing eip:
May 13 13:15:33 tor kernel: c01382b0
May 13 13:15:33 tor kernel: *pde =3D 00000000
May 13 13:15:33 tor kernel: Oops: 0002
May 13 13:15:33 tor kernel: CPU:    0
May 13 13:15:33 tor kernel: EIP:    0010:[__free_pages_ok+512/688]    Taint=
ed: PF
May 13 13:15:33 tor kernel: EFLAGS: 00013096
May 13 13:15:33 tor kernel: eax: 00000000   ebx: c131e020   ecx: c131e320  =
 edx: 00000000
May 13 13:15:33 tor kernel: esi: 0000fa10   edi: 0002ef60   ebp: c02968a0  =
 esp: c8d85dac
May 13 13:15:33 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 13:15:33 tor kernel: Process vmware-vmx (pid: 3787, stackpage=3Dc8d8=
5000)
May 13 13:15:33 tor kernel: Stack: c02968dc c1000020 c131e320 c0296850 c103=
0020 00003202 fffffff0 000007d0=20
May 13 13:15:33 tor kernel:        ce48eed8 e9460e00 0000071f c8d85de8 f10b=
5748 e9460e00 c1930000 c8d85e18=20
May 13 13:15:33 tor kernel:        f10b810c e9460e00 ce48eed8 c8d85e58 c011=
ddba 0000000a 00000400 0000071e=20
May 13 13:15:33 tor kernel: Call Trace:    [<f10b5748>] [<f10b810c>] [print=
k+298/320] [<f10b57e5>] [<f10b56d4>]
May 13 13:15:33 tor kernel:   [<f10b6f0d>] [<f10b64dc>] [<f10b48a0>] [<f107=
31b0>] [<f1074620>] [handle_IRQ_event+69/112]
May 13 13:15:33 tor kernel:   [<f1074620>] [cached_lookup+24/96] [link_path=
_walk+1566/1728] [__user_walk+92/128] [path_release+18/64] [sys_access+332/=
352]
May 13 13:15:33 tor kernel:   [sys_ioctl+164/448] [system_call+51/56]
May 13 13:15:33 tor kernel:=20
May 13 13:15:33 tor kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 c7 03=
 00 00 00 00 d1 64=20
May 13 13:15:33 tor kernel:  kernel BUG at inode.c:562!
May 13 13:15:33 tor kernel: invalid operand: 0000
May 13 13:15:33 tor kernel: CPU:    0
May 13 13:15:33 tor kernel: EIP:    0010:[clear_inode+26/240]    Tainted: P=
F
May 13 13:15:33 tor kernel: EFLAGS: 00013202
May 13 13:15:33 tor kernel: eax: e66f6ae0   ebx: e66f6ac0   ecx: 00000001  =
 edx: e66f6ae0
May 13 13:15:33 tor kernel: esi: c013b400   edi: c0296d20   ebp: dcb3c340  =
 esp: e7853ebc
May 13 13:15:33 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 13:15:33 tor kernel: Process X (pid: 2227, stackpage=3De7853000)
May 13 13:15:33 tor kernel: Stack: e66f6ac0 e66f6ac0 c0155fdd e66f6ac0 0000=
0000 00000000 dcb3c340 e66f6ac0=20
May 13 13:15:33 tor kernel:        e66f6ac0 c0153982 e66f6ac0 00003282 e765=
ace0 c190a220 c0140899 dcb3c340=20
May 13 13:15:33 tor kernel:        df145520 db33dd80 db33dd80 41ebf000 d99d=
f3c0 c012f1ac db33dd80 e7854430=20
May 13 13:15:33 tor kernel: Call Trace:    [iput+445/640] [dput+194/352] [f=
put+169/304] [unmap_fixup+364/384] [do_munmap+467/672]
May 13 13:15:33 tor kernel:   [sys_shmdt+115/176] [sys_ipc+461/592] [system=
_call+51/56]
May 13 13:15:33 tor kernel:=20
May 13 13:15:33 tor kernel: Code: 0f 0b 32 02 a0 7d 26 c0 8b 83 f8 00 00 00=
 a8 10 75 08 0f 0b=20
May 13 13:16:32 tor kernel: kernel BUG at page_alloc.c:231!
May 13 13:16:32 tor kernel: invalid operand: 0000
May 13 13:16:32 tor kernel: CPU:    0
May 13 13:16:32 tor kernel: EIP:    0010:[rmqueue+534/576]    Tainted: PF
May 13 13:16:32 tor kernel: EFLAGS: 00010202
May 13 13:16:32 tor kernel: eax: 010000cc   ebx: c137f1f0   ecx: 00012a5f  =
 edx: 00001000
May 13 13:16:32 tor kernel: esi: 0002ef60   edi: c1000020   ebp: c0296850  =
 esp: e9ebde7c
May 13 13:16:32 tor kernel: ds: 0018   es: 0018   ss: 0018
May 13 13:16:32 tor kernel: Process nautilus (pid: 4711, stackpage=3De9ebd0=
00)
May 13 13:16:32 tor kernel: Stack: 00001000 00000004 00011a5f 00000292 0000=
0000 c0296850 c02969d4 000001ff=20
May 13 13:16:32 tor kernel:        00000000 000001d2 c01387f1 ed7eef40 c029=
6850 c02969d0 c17f5620 e67df9a4=20
May 13 13:16:32 tor kernel:        00000031 0000003b efc7e41c c0130598 c17f=
5620 f0825800 0000003a efc7e418=20
May 13 13:16:32 tor kernel: Call Trace:    [__alloc_pages+65/384] [page_cac=
he_read+104/208] [mousedev:__insmod_mousedev_O/lib/modules/2.4.21-rc2/kerne=
l/drivers/i+-8636416/96] [generic_f
ile_readahead+175/416] [do_generic_file_read+425/1072]
May 13 13:16:32 tor kernel:   [file_read_actor+0/240] [generic_file_read+32=
0/352] [file_read_actor+0/240] [sys_read+147/336] [system_call+51/56]


--=-vRJs0M/Oz/ES6TKXsELc--

--=-ln24udYwGkH7DXGFihUL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+wO5lLYywqksgYBoRAigNAKDVaFSY01u7/CnCqa2fM0rFQ6hdrQCfcltm
vAz99ZdeOovwvGeWHRmWDzs=
=OXQS
-----END PGP SIGNATURE-----

--=-ln24udYwGkH7DXGFihUL--

