Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUBJXvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 18:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUBJXvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 18:51:43 -0500
Received: from c-24-15-25-98.client.comcast.net ([24.15.25.98]:59801 "EHLO
	chris.pebenito.dhs.org") by vger.kernel.org with ESMTP
	id S262130AbUBJXvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 18:51:41 -0500
Subject: Re: 2.6.3-rc1-mm1 (SELinux + ext3 + nfsd oops)
From: Chris PeBenito <pebenito@gentoo.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>
In-Reply-To: <20040209014035.251b26d1.akpm@osdl.org>
References: <20040209014035.251b26d1.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Eq2Yb7eyYAR7eGLRSh73"
Message-Id: <1076457099.29471.39.camel@chris.pebenito.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 17:51:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Eq2Yb7eyYAR7eGLRSh73
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I got an oops on boot when nfsd is starting up on a SELinux+ext3
machine.  It exports /home, which is mounted thusly:

/dev/sda1 on /home type ext3 (rw,nosuid,nodev,noatime,data=3Djournal,errors=
=3Dremount-ro)

Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c017fcab>]    Not tainted
EFLAGS: 00010282
EIP is at ext3_xattr_get+0x2b/0x200
eax: ffffffd4   ebx: 00000000   ecx: ffffffea   edx: c02c0af1
esi: c02c0af2   edi: c02ad415   ebp: ffffffd4   esp: ca59bb50
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1435, threadinfo=3Dca59a000 task=3Dca59d8e0)
Stack: 00000007 00100000 00000206 ffffff74 ca59bbc8 cbfe5ba0 c01469c9 c02f4=
92c
       c02c0af2 c02ad415 ca59bbd0 c01817ba 00000000 00000006 c02c0af1 cbcef=
6e0
       000000ff c03921f4 00000005 c017fa65 00000000 c02c0af1 cbcef6e0 00000=
0ff
Call Trace:
 [<c01469c9>] wake_up_buffer+0x9/0x20
 [<c01817ba>] ext3_xattr_security_get+0x3a/0x60
 [<c017fa65>] ext3_getxattr+0x45/0xc0
 [<c01af1e6>] inode_doinit_with_dentry+0x2e6/0x540
 [<c0159c03>] d_splice_alias+0x63/0xc0
 [<c017a96f>] ext3_lookup+0x6f/0xa0
 [<c0151d2a>] __lookup_hash+0x6a/0xa0
 [<c0151d6f>] lookup_hash+0xf/0x20
 [<c0151dd8>] lookup_one_len+0x58/0x80
 [<c0190260>] find_exported_dentry+0x460/0x580
 [<c01b2c14>] selinux_ip_postroute_last+0x1b4/0x200
 [<c01f715a>] boomerang_start_xmit+0x11a/0x2e0
 [<c024fa11>] qdisc_restart+0x11/0xe0
 [<c0246437>] dev_queue_xmit+0x157/0x1e0
 [<c025ae2c>] ip_finish_output2+0x8c/0x180
 [<c024f020>] nf_hook_slow+0xa0/0x100
 [<c0242303>] __kfree_skb+0x63/0xe0
 [<c02466b5>] net_tx_action+0x35/0xc0


--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Eq2Yb7eyYAR7eGLRSh73
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAKW6KvI7kLeavkkMRAo7nAKCDVMOFuWlw59osm7Ers3Ye8i9BOgCeLrxd
3dBvTi3xfLqhokoLTKCXL+E=
=BP2u
-----END PGP SIGNATURE-----

--=-Eq2Yb7eyYAR7eGLRSh73--
