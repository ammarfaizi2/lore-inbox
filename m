Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTDEWFk (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 17:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbTDEWFk (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 17:05:40 -0500
Received: from cpt-dial-196-30-178-31.mweb.co.za ([196.30.178.31]:12673 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262687AbTDEWFi (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 17:05:38 -0500
Subject: Slab corruption with ext3-handle-cache.patch
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uu145sb3GuoLMsWUIi4U"
Organization: 
Message-Id: <1049580790.29758.8.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 06 Apr 2003 00:13:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uu145sb3GuoLMsWUIi4U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I tried this patch a few days again, but not in the mm patch set.  So
when I got problems with slab corruption, I figured it was maybe a
patch I missed, and dropped it.

Now with 2.5.66-bk10+, it is merged, and I get it again.

----------------------------------------------------------
Slab corruption: start=3Dcfaeecc4, expend=3Dcfaeee77, problemat=3Dcfaeed28
Last user: [<c01890de>](ext3_destroy_inode+0x1b/0x1f)
Data:
***************************************************************************=
*************************3C 26 99 DF **************************************=
***************************************************************************=
***************************************************************************=
***************************************************************************=
********************************************************************A5=20
Next: 71 F0 2C .DE 90 18 C0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00=20
slab error in check_poison_obj(): cache `ext3_inode_cache': object was
modified after freeing
Call Trace:
 [<c0137894>] check_poison_obj+0x14f/0x18f
 [<c0138c8b>] kmem_cache_alloc+0x11c/0x141
 [<c01890aa>] ext3_alloc_inode+0x18/0x31
 [<c01890aa>] ext3_alloc_inode+0x18/0x31
 [<c0162c0c>] alloc_inode+0x1c/0x13d
 [<c0163510>] new_inode+0x13/0x7d
 [<c017fcf2>] ext3_new_inode+0x41/0x7c7
 [<c0138c8b>] kmem_cache_alloc+0x11c/0x141
 [<c018de05>] start_this_handle+0x94/0x1b9
 [<c018df46>] new_handle+0x1c/0x50
 [<c018e025>] journal_start+0xab/0xd2
 [<c0187fb4>] ext3_symlink+0xd6/0x2bd
 [<c015a4c7>] vfs_symlink+0x5c/0xa3
 [<c015a5f0>] sys_symlink+0xe2/0xf2
 [<c010a8fd>] sysenter_past_esp+0x52/0x71

-----------------------------------------------------------

If you need more info, just ask.


Regards,

--=20

Martin Schlemmer




--=-uu145sb3GuoLMsWUIi4U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+j1TzqburzKaJYLYRAoEFAJ9ESIWnlyiZm7XdnQRId5X5ZvmmRQCeICwV
JPLbpZyRMypz5/SJHRmJJOM=
=nmsd
-----END PGP SIGNATURE-----

--=-uu145sb3GuoLMsWUIi4U--

