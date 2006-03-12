Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWCMIHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWCMIHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWCMIHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:07:17 -0500
Received: from pv105234.reshsg.uci.edu ([128.195.105.234]:35735 "HELO
	pv105234.reshsg.uci.edu") by vger.kernel.org with SMTP
	id S932338AbWCMIHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:07:15 -0500
Message-ID: <44147F3F.6070205@feise.com>
Date: Sun, 12 Mar 2006 12:06:23 -0800
From: Joe Feise <jfeise@feise.com>
Reply-To: jfeise@feise.com
Organization: feise.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] NFS(?) bug in 2.6.16-rc5-mm3
References: <4414777C.6020209@feise.com>
In-Reply-To: <4414777C.6020209@feise.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCD61BE709BF30F2DFD56AEDC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCD61BE709BF30F2DFD56AEDC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Joe Feise wrote on 03/12/06 11:33:

> In certain cases, when programmatically traversing a directory tree mou=
nted
> through NFS, I get a kernel oops.


Update: this doesn't seem to be limited to NFS.
I just got a kernel oops of the same kind, in prune_dcache, while compili=
ng:

BUG: unable to handle kernel paging request at virtual address 0a1d2030
 printing eip:
c016a8b3
*pde =3D 00000000
Oops: 0000 [#2]
PREEMPT
last sysfs file: /class/net/eth2/ifindex
Modules linked in: pl2303 usbserial softdog cisco_ipsec snd_pcm_oss
snd_mixer_oss snd_cs46xx gameport snd_rawmidi snd_s
eq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore
snd_page_alloc zoran i2c_algo_bit videodev saa711
1 i2c_core pegasus arc4 ppp_mppe ppp_deflate ppp_generic slhc usblp
CPU:    0
EIP:    0060:[<c016a8b3>]    Tainted: P      VLI
EFLAGS: 00010202   (2.6.16-rc5-mm3 #9)
EIP is at iput+0x1d/0x65
eax: 0a1d201c   ebx: d4f10a00   ecx: d4f10a18   edx: d4f10a18
esi: d6f38420   edi: 0000002a   ebp: ffffe000   esp: e36c1d48
ds: 007b   es: 007b   ss: 0068
Process qmail-send (pid: 2678, threadinfo=3De36c0000 task=3De353cab0)
Stack: <0>d6f38414 c0167e41 e36c0000 e36c0000 00000082 000049d4 c17deac0 =
c0168230
       c013c911 00000000 000225da 00000000 00127500 00000000 000329cf 000=
049d4
       00000005 00000000 00000000 000000d0 00000020 e36c1e14 c05a51f0 000=
0000c
Call Trace:
 <c0167e41> prune_dcache+0x12d/0x162   <c0168230> shrink_dcache_memory+0x=
14/0x37
 <c013c911> shrink_slab+0x131/0x1f7   <c013dab9> try_to_free_pages+0xee/0=
x1ab
 <c0138ea8> __alloc_pages+0x113/0x29c   <c014d344> kmem_getpages+0x2f/0x9=
5
 <c014dff8> cache_grow+0xc4/0x171   <c015f385> link_path_walk+0x69/0xc0
 <c014e20c> cache_alloc_refill+0x167/0x22c   <c014e4cb> kmem_cache_alloc+=
0x3f/0x41
 <c015230a> get_empty_filp+0x41/0x11c   <c015f778> do_path_lookup+0x102/0=
x1fb
 <c015f8ab> __path_lookup_intent_open+0x22/0x90   <c015f93c>
path_lookup_open+0x23/0x2b
 <c016010d> open_namei+0x6a/0x68f   <c0164938> fifo_open+0x0/0x2a0



--------------enigCD61BE709BF30F2DFD56AEDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFEFH8/Kc8oZ1MoTeoRAs0iAJ9GGSr2mMMtuSfQ1Cope4eVxmfDJQCfUAnj
rEDpUCy2nOg11dG67qNmuGo=
=Gv7d
-----END PGP SIGNATURE-----

--------------enigCD61BE709BF30F2DFD56AEDC--
