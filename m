Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVF0E0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVF0E0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 00:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVF0E0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 00:26:44 -0400
Received: from h80ad25a1.async.vt.edu ([128.173.37.161]:18054 "EHLO
	h80ad25a1.async.vt.edu") by vger.kernel.org with ESMTP
	id S261807AbVF0EZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 00:25:09 -0400
Message-Id: <200506270423.j5R4Np9n004510@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: David Masover <ninja@slaphack.com>
Cc: Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Sun, 26 Jun 2005 21:37:48 CDT."
             <42BF667C.50606@slaphack.com> 
From: Valdis.Kletnieks@vt.edu
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
            <42BF667C.50606@slaphack.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119846230_3633P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Jun 2005 00:23:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119846230_3633P
Content-Type: text/plain; charset=us-ascii

On Sun, 26 Jun 2005 21:37:48 CDT, David Masover said:

> Assume we can do on-disk caching, similar to fscache/cachefs for nfs.
> Now, benchmark:
> 
> $ unzip linux-2.6.12.zip && make -C linux-2.6.12
> 
> versus the hypothetical
> 
> $ make -C linux-2.6.12.zip/.../contents
> 
> This is an automatic performance gain, in theory, because the second
> command is identical to unzipping just the parts you need into
> linux-2.6.12, then running "make".

Nope, they're not identical.  The first specifically unzips it into the file
system, leaving the zip file intact.  The second, you're having to take all
those .o files and other stuff that the 'make' generates and put them back
into the .zip file *on the fly* - when the 'make' is half done, the .zip should
reflect a directory tree that has had half the make execute....

(Think - after that hyptothetical 'make' completes, where is 'vmlinux'? ;)

--==_Exmh_1119846230_3633P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCv39WcC3lWbTT17ARAnKeAKDZdxXYC0EQZ1VRglKzg/4J/KSbFgCfX5v9
azwJHdOITWjpAGEES9st47c=
=QZyr
-----END PGP SIGNATURE-----

--==_Exmh_1119846230_3633P--
