Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262892AbTC1Kq4>; Fri, 28 Mar 2003 05:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbTC1Kq4>; Fri, 28 Mar 2003 05:46:56 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:15347 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S262892AbTC1Kqy>; Fri, 28 Mar 2003 05:46:54 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Oleg Drokin <green@namesys.com>
Subject: Re: NFS/ReiserFS problems 2.5.64-mbj1
Date: Fri, 28 Mar 2003 11:57:42 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       Bill Huey <billh@gnuppy.monkey.org>
References: <20030327092207.GA1248@gnuppy.monkey.org> <20030327200702.A30403@namesys.com> <200303281012.26031.schlicht@uni-mannheim.de>
In-Reply-To: <200303281012.26031.schlicht@uni-mannheim.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_vqCh+EeyjL8ka8h";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303281157.51743.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_vqCh+EeyjL8ka8h
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Mar 27, 2003 18:07, Oleg Drokin wrote:
> sb->s_export_op->find_exported_dentry is NULL
> in reiserfs_decode_fh, well. In fact we never set this field at all.
> What is supposed to be there, anyway?
> I guess following patch should fix the problem.

Yes, it did fix the problem, but now I was not allowed anymore to compile N=
=46S=20
as a module as I need reiserfs to be in the kernel... :-(

> In fact I guess somebody should put find_exported_dentry() declaration to
> include/linux/fs.h or something like that.
> Also absolutely the same problem must exist if you try to export fat=20
filesystem.

That is true, too. I saw the Oops with a VFAT partition, too

I just wonder why the code in fs/nfsd/export.c lines 684-687 does not work.=
=20
This code should set the find_exported_dentry field correctly. But I do not=
=20
know when this function (exp_export()) is called...

Regards
      Thomas

--Boundary-02=_vqCh+EeyjL8ka8h
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+hCqvYAiN+WRIZzQRApRdAJ4zScG+Rb+S51XWoAVR4nKzmmoUmwCfSThV
1c/QVazY8YDcwsol5m5FwC8=
=bR3a
-----END PGP SIGNATURE-----

--Boundary-02=_vqCh+EeyjL8ka8h--

