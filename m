Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSLMJEg>; Fri, 13 Dec 2002 04:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbSLMJEg>; Fri, 13 Dec 2002 04:04:36 -0500
Received: from mail.gmx.de ([213.165.64.20]:45765 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261642AbSLMJEe>;
	Fri, 13 Dec 2002 04:04:34 -0500
Date: Fri, 13 Dec 2002 10:12:07 +0100
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 486 laptop apm problems
Message-ID: <20021213091206.GA2692@mob.wid>
References: <20021209133058.GA3724@mob.wid> <200212091350.gB9DouN1000766@darkstar.example.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <200212091350.gB9DouN1000766@darkstar.example.net>
x-gpg-fingerprint: 717B AE57 49B3 410F A733  FE6A 2D43 E1E3 CF28 6A67
x-gpg-key: wwwkeys.de.pgp.net
From: Felix Triebel <ernte23@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2002 at 01:50:56PM +0000, John Bradford wrote:
> > why does apmd frequently crash?
> > what do all these ide and apm messages mean?
> > how should I use such an old apm bios?
>=20
> The IDE messages are warning messages, not critical errors - you can
> ignore them.
>=20
> Please run the oops through ksymoops and post the output.

sorry for the delay, but this thing is SLOW and there was some work
after it had a hard drive head crash. By the way - does ide taskfile
access correct problems silently or give me a message?

here is the requested ksymoops output, I hope it is useful:
--------------------------------------------------------------------------
ksymoops 2.4.5 on i486 2.4.20-rc4-ac1.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o lib/modules/2.4.20-rc4-ac1/ (specified)
     -m System.map-ac (specified)

CPU: 486
Unable to handle kernel NULL pointer dereference at virtual address 000000d8
c011dd5f
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011dd5f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c1030080   ebx: c101f320   ecx: 00000400   edx: 00000000
esi: c0999000   edi: c10731e8   ebp: c1030080   esp: c0a97ed0
ds: 0018   es: 0018   ss: 0018
Process 00hwclock (pid: 759, stackpage=3Dc0a97000)
Stack: c10731cc c10731cc c10731e8 080c1078 c011dee3 c10731cc c0ebeebc 080c1=
078=20
       00000001 c0db5304 c10731cc 080c1078 c10731e8 c0ebeebc c0b6e080 c010c=
df7=20
       c10731cc c0ebeebc 080c1078 00000001 c0a96000 ffff0006 c010cce0 bffff=
bec=20
Call Trace:    [<c011dee3>] [<c010cdf7>] [<c010cce0>] [<c0117c49>] [<c0114a=
0a>]
  [<c0114936>] [<c010e03d>] [<c0106d34>]
Code: 2b 82 d8 00 00 00 69 c0 c5 4e ec c4 c1 f8 02 c1 e0 0c 03 82=20


>>EIP; c011dd5f <do_no_page+ef/190>   <=3D=3D=3D=3D=3D

>>eax; c1030080 <_end+e1a454/1dea3d4>
>>ebx; c101f320 <_end+e096f4/1dea3d4>
>>esi; c0999000 <_end+7833d4/1dea3d4>
>>edi; c10731e8 <_end+e5d5bc/1dea3d4>
>>ebp; c1030080 <_end+e1a454/1dea3d4>
>>esp; c0a97ed0 <_end+8822a4/1dea3d4>

Trace; c011dee3 <handle_mm_fault+e3/160>
Trace; c010cdf7 <do_page_fault+117/434>
Trace; c010cce0 <do_page_fault+0/434>
Trace; c0117c49 <process_timeout+9/10>
Trace; c0114a0a <bh_action+1a/50>
Trace; c0114936 <tasklet_hi_action+46/70>
Trace; c010e03d <schedule+20d/230>
Trace; c0106d34 <error_code+34/40>

Code;  c011dd5f <do_no_page+ef/190>
00000000 <_EIP>:
Code;  c011dd5f <do_no_page+ef/190>   <=3D=3D=3D=3D=3D
   0:   2b 82 d8 00 00 00         sub    0xd8(%edx),%eax   <=3D=3D=3D=3D=3D
Code;  c011dd65 <do_no_page+f5/190>
   6:   69 c0 c5 4e ec c4         imul   $0xc4ec4ec5,%eax,%eax
Code;  c011dd6b <do_no_page+fb/190>
   c:   c1 f8 02                  sar    $0x2,%eax
Code;  c011dd6e <do_no_page+fe/190>
   f:   c1 e0 0c                  shl    $0xc,%eax
Code;  c011dd71 <do_no_page+101/190>
  12:   03 82 00 00 00 00         add    0x0(%edx),%eax
--------------------------------------------------------------------------

regards,
Felix

--=20

/"\  ASCII RIBBON CAMPAIGN
\ /  AGAINST HTML MAIL
 X   AND POSTINGS  :)
/ \  http://www.dcoul.de/

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE9+aRmLUPh488oamcRAsCDAJ9c/791WqKFXCbpXLDrEdpe2xg+AQCfZ/8L
ZUPQlq6DkiadtuiueFEn2Pk=
=+jVM
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
