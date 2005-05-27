Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVE0PCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVE0PCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVE0PCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:02:20 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:25272 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S261786AbVE0PCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:02:07 -0400
Date: Fri, 27 May 2005 17:02:09 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Roland McGrath <roland@redhat.com>
Subject: [OOPS] 2.6.12-rc3 ptrace bug?
Message-ID: <20050527170209.59355a59@laptop.hypervisor.org>
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Fri__27_May_2005_17_02_09_+0200_AYPgGyDH/iLeIjm3";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Fri__27_May_2005_17_02_09_+0200_AYPgGyDH/iLeIjm3
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__27_May_2005_17_02_09_+0200_Ydd=3EvFvhxDwzEL"

--Multipart_Fri__27_May_2005_17_02_09_+0200_Ydd=3EvFvhxDwzEL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


The attached (radically shortened) program to measure pipe performance oops=
es
the Linux-2.6.12-rc3 kernel when traced using "strace -f". The problem no l=
onger
occurs in -rc4 or -rc5. It would be good to know whether the bug causing the
problem is known and has been fixed or simply went away due to other change=
s.
I have been unable to find a Changelog detailing the patches that went
into -rc4.

The bug is reproducible on all -rc3 kernels I've tried.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT=20
Modules linked in:
CPU:    0
EIP:    0060:[<00000000>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-rc3)=20
EIP is at 0x0
eax: db052000   ebx: 01200011   ecx: 00000000   edx: 00000000
esi: df605060   edi: 00000000   ebp: db052000   esp: db052fc4
ds: 007b   es: 007b   ss: 0068
Process pipe (pid: 778, threadinfo=3Ddb052000 task=3Ddf605060)
Stack: 01202011 00000000 00000000 00000000 b7ea0708 bf9da748 00000000 00000=
07b=20
       c010007b 00000078 b7f290a5 00000073 00000282 bf9da6e0 0000007b=20
Call Trace:
Code:  Bad EIP value.

Best regards,
-Udo.

--Multipart_Fri__27_May_2005_17_02_09_+0200_Ydd=3EvFvhxDwzEL
Content-Type: application/octet-stream; name=pipe.c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=pipe.c

CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQu
aD4KCnVuc2lnbmVkIGl0ZXJhdGlvbnMgPSAxMDAwOwppbnQgcGluZ1syXSwgcG9uZ1syXTsKcGlk
X3QgcGlkOwoKdm9pZCBkb19waW5nICh2b2lkKQp7CiAgICBjaGFyIGJ1ZmZlcjsKICAgIHVuc2ln
bmVkIGk7CiAgICAKICAgIGZvciAoaSA9IDA7IGkgPCBpdGVyYXRpb25zOyBpKyspIHsKICAgICAg
ICBpZiAod3JpdGUgKHBpbmdbMV0sICJFIiwgMSkgIT0gMSkKICAgICAgICAgICAgYnJlYWs7CiAg
ICAgICAgaWYgKHJlYWQgKHBvbmdbMF0sICZidWZmZXIsIDEpICE9IDEpCiAgICAgICAgICAgIGJy
ZWFrOwogICAgfQoKICAgIGNsb3NlIChwaW5nWzFdKTsKICAgIGNsb3NlIChwb25nWzBdKTsKCiAg
ICB3YWl0cGlkIChwaWQsICZpLCAwKTsKfQoKdm9pZCBkb19lY2hvICh2b2lkKQp7CiAgICBjaGFy
IGJ1ZmZlcjsKCiAgICBmb3IgKDs7KSB7CiAgICAgICAgaWYgKHJlYWQgKHBpbmdbMF0sICZidWZm
ZXIsIDEpICE9IDEpCiAgICAgICAgICAgIGJyZWFrOwogICAgICAgIGlmICh3cml0ZSAocG9uZ1sx
XSwgIlIiLCAxKSAhPSAxKQogICAgICAgICAgICBicmVhazsKICAgIH0KfQoKaW50IG1haW4gKGlu
dCBhcmdjLCBjaGFyICoqYXJndikKewogICAgaWYgKHBpcGUgKHBpbmcpID09IC0xIHx8IHBpcGUg
KHBvbmcpID09IC0xKQogICAgICAgIHJldHVybiAtMTsKICAgIAogICAgc3dpdGNoIChwaWQgPSBm
b3JrKCkpIHsKCiAgICAgICAgY2FzZSAtMToKICAgICAgICAgICAgcmV0dXJuIC0xOwoKICAgICAg
ICBjYXNlIDA6CiAgICAgICAgICAgIGNsb3NlIChwaW5nWzFdKTsKICAgICAgICAgICAgY2xvc2Ug
KHBvbmdbMF0pOwogICAgICAgICAgICBkb19lY2hvKCk7CiAgICAgICAgICAgIHJldHVybiAwOwoK
ICAgICAgICBkZWZhdWx0OgogICAgICAgICAgICBjbG9zZSAocGluZ1swXSk7CiAgICAgICAgICAg
IGNsb3NlIChwb25nWzFdKTsKICAgICAgICAgICAgZG9fcGluZygpOyAgICAgICAgCiAgICB9Cgog
ICAgcmV0dXJuIDA7Cn0K

--Multipart_Fri__27_May_2005_17_02_09_+0200_Ydd=3EvFvhxDwzEL--

--Signature_Fri__27_May_2005_17_02_09_+0200_AYPgGyDH/iLeIjm3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFClzZznhRzXSM7nSkRAiOvAJ4lpqWTDeQdwJ78tElMS+T1XMKPLwCdFeDb
//4eswCEPxMWq+YMnTiajME=
=6vSE
-----END PGP SIGNATURE-----

--Signature_Fri__27_May_2005_17_02_09_+0200_AYPgGyDH/iLeIjm3--
