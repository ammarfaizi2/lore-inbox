Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWCNDyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWCNDyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWCNDyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:54:47 -0500
Received: from pv105234.reshsg.uci.edu ([128.195.105.234]:4775 "HELO
	pv105234.reshsg.uci.edu") by vger.kernel.org with SMTP
	id S932562AbWCNDyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:54:46 -0500
Message-ID: <44163E7C.2000001@feise.com>
Date: Mon, 13 Mar 2006 19:54:36 -0800
From: Joe Feise <jfeise@feise.com>
Reply-To: jfeise@feise.com
Organization: feise.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] NFS(?) bug in 2.6.16-rc5-mm3
References: <4414777C.6020209@feise.com> <1142199317.8871.2.camel@lade.trondhjem.org>
In-Reply-To: <1142199317.8871.2.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC21FBADF2BD0A207DF18D8EA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC21FBADF2BD0A207DF18D8EA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Trond Myklebust wrote on 03/12/06 13:35:

> On Sun, 2006-03-12 at 11:33 -0800, Joe Feise wrote:
>> In certain cases, when programmatically traversing a directory tree mo=
unted
>> through NFS, I get a kernel oops.
>> Two examples are listed below.
>=20
> Please could you retry without the cisco_ipsec module (and whatever els=
e
> is tainting the kernel).


Here is the problem without the cisco_ipsec module, with an untainted ker=
nel.

-Joe

BUG: unable to handle kernel paging request at virtual address 02b00025
 printing eip:
c016a8b3
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
last sysfs file: /class/net/eth2/ifindex
Modules linked in: pl2303 usbserial softdog snd_pcm_oss snd_mixer_oss snd=
_cs46xx
gameport snd_rawmidi snd_seq_de
vice snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page=
_alloc
zoran i2c_algo_bit videodev saa7
111 i2c_core pegasus arc4 ppp_mppe ppp_deflate ppp_generic slhc usblp
CPU:    0
EIP:    0060:[<c016a8b3>]    Not tainted VLI
EFLAGS: 00010206   (2.6.16-rc5-mm3 #9)
EIP is at iput+0x1d/0x65
eax: 02b00011   ebx: d4bb5a00   ecx: d4bb5a18   edx: d4bb5a18
esi: f2183d20   edi: 00000020   ebp: ffffe000   esp: c7c67e3c
ds: 007b   es: 007b   ss: 0068
Process cc1 (pid: 11024, threadinfo=3Dc7c66000 task=3Df7c8f570)
Stack: <0>f2183d14 c0167e41 c7c66000 c7c66000 000000b6 0004aa24 c17deac0 =
c0168230
       c013c911 00000000 0001eaf8 00000000 012a8900 00000000 00025c2d 000=
4aa24
       0000007e 00000000 00000000 000280d2 00000020 c7c67f08 c05a5218 000=
0000c
Call Trace:
 <c0167e41> prune_dcache+0x12d/0x162   <c0168230> shrink_dcache_memory+0x=
14/0x37
 <c013c911> shrink_slab+0x131/0x1f7   <c013dab9> try_to_free_pages+0xee/0=
x1ab
 <c0138ea8> __alloc_pages+0x113/0x29c   <c0141352> do_anonymous_page+0x40=
/0x148
 <c0141796> __handle_mm_fault+0xa5/0x1d9   <c0467197> notifier_call_chain=
+0x17/0x2b
 <c0466cb7> do_page_fault+0x16a/0x633   <c0466b4d> do_page_fault+0x0/0x63=
3
 <c010342b> error_code+0x4f/0x54
Code: 85 c9 75 05 e9 4a fd ff ff e9 93 fe ff ff 85 c0 53 89 c3 74 4c 8b 8=
0 90 00
00 00 83 bb 24 01 00 00 20 8b 4
0 20 74 42 85 c0 74 07 <8b> 50 14 85 d2 75 31 8d 43 24 ba 80 84 68 c0 e8 =
8d a2
11 00 85


--------------enigC21FBADF2BD0A207DF18D8EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFEFj6AKc8oZ1MoTeoRAn0pAKDHgiJ7lt2ckGuP8jOQoIv1Kr/pfwCgjG+g
YTrRlxcvCBlfw615lCWsxsA=
=7TvM
-----END PGP SIGNATURE-----

--------------enigC21FBADF2BD0A207DF18D8EA--
