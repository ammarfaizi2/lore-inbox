Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315706AbSECU5E>; Fri, 3 May 2002 16:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSECU5E>; Fri, 3 May 2002 16:57:04 -0400
Received: from ma-northadams1b-62.bur.adelphia.net ([24.52.166.62]:128 "EHLO
	ma-northadams1b-62.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S315706AbSECU44>; Fri, 3 May 2002 16:56:56 -0400
Date: Fri, 3 May 2002 17:00:45 -0400
From: Eric Buddington <eric@ma-northadams1b-62.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18: oops in zap_page_range
Message-ID: <20020503170045.A77@ma-northadams1b-62.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Enclosed is an oops from 2.4.18 on an Athlon. I do not hage a good
guess as to the cause; the events preceding it were:
	- recording a CDRW with cdrecord to an IDE writer
	- messing with the Buz drivers (insmod/rmmod several times on saa7185, saa=
7111, zr36067)
	- cdrecord xterm disappearing w/o cause
	- checked syslog, no oops
	- Buz xterm disappears w/o cause

This was followed by a hard freeze of X, though Alt-SysRq-b still worked.

Hope this is useful...

-Eric

----------------
ksymoops 2.4.3 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /packages/linux/2.4.18/athlon/boot/System.map (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c01230ea>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cd27a540   ecx: cdcf4dc0   edx: c8317000
esi: 00000000   edi: cdcf4dc0   ebp: 00000000   esp: c6079e0c
ds: 0018   es: 0018   ss: 0018
Process xterm (pid: 28443, stackpage=3Dc6079000)
Stack: 00000000 00000000 4001f000 c8317404 40400000 00000000 00000000 c8317=
000=20
       00000000 c675ab40 0000056c cd6fc800 cd3f33c0 cdfea340 ccaefdc0 cd3f3=
3c0=20
       cdfea340 c013354f ccd39f40 cbf16100 cd27a540 00000000 cdcf4dc0 00000=
000=20
Call Trace: [<c013354f>] [<c0125788>] [<c011556e>] [<c0119731>] [<c011ea75>=
]=20
   [<c011ef90>] [<c011eb2f>] [<c0106baf>] [<c013ffd6>] [<c0132a38>] [<c0113=
690>]=20
   [<c0106d64>]=20
Code: 0f 0b 8d 74 26 00 8b 54 24 68 8b 44 24 18 8b 4c 24 1c 89 54=20

>>EIP; c01230ea <zap_page_range+3a/250>   <=3D=3D=3D=3D=3D
Trace; c013354e <fput+ae/d0>
Trace; c0125788 <exit_mmap+b8/120>
Trace; c011556e <mmput+2e/50>
Trace; c0119730 <do_exit+70/1c0>
Trace; c011ea74 <collect_signal+94/f0>
Trace; c011ef90 <send_sig_info+80/90>
Trace; c011eb2e <dequeue_signal+5e/b0>
Trace; c0106bae <do_signal+20e/2a0>
Trace; c013ffd6 <sys_select+176/4a0>
Trace; c0132a38 <sys_write+98/f0>
Trace; c0113690 <do_page_fault+0/4b6>
Trace; c0106d64 <signal_return+14/18>
Code;  c01230ea <zap_page_range+3a/250>
00000000 <_EIP>:
Code;  c01230ea <zap_page_range+3a/250>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c01230ec <zap_page_range+3c/250>
   2:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01230f0 <zap_page_range+40/250>
   6:   8b 54 24 68               mov    0x68(%esp,1),%edx
Code;  c01230f4 <zap_page_range+44/250>
   a:   8b 44 24 18               mov    0x18(%esp,1),%eax
Code;  c01230f8 <zap_page_range+48/250>
   e:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c01230fc <zap_page_range+4c/250>
  12:   89 54 00 00               mov    %edx,0x0(%eax,%eax,1)


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE80vp9ce4O6PAsbIkRAvThAKCF3yg4rNiV8tdB3ZWSlC2L+fpEegCeMoVC
XRuXtQ+r+wygpr7A7egqGkw=
=iC9h
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
