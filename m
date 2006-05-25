Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWEYVaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWEYVaM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWEYVaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:30:11 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24742 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030429AbWEYVaJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:30:09 -0400
Message-Id: <200605252129.k4PLTx1r018031@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: devmazumdar <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
In-Reply-To: Your message of "Thu, 25 May 2006 21:19:33 -0000."
             <e55715+usls@eGroups.com>
From: Valdis.Kletnieks@vt.edu
References: <e55715+usls@eGroups.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148592598_2837P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 25 May 2006 17:29:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148592598_2837P
Content-Type: text/plain; charset=us-ascii

On Thu, 25 May 2006 21:19:33 -0000, devmazumdar said:
> How does one check the existence of the kernel source RPM (or deb) on
> every single distribution?.
> 
> We know that rpm -qa | grep kernel-source works on Redhat, Fedora,
> SuSE, Mandrake and CentOS - how about other RPM based distros?

There's no kernel-source RPM on recent Fedora.  Also, there's another problem...

On my laptop at the moment:

% rpm -q kernel
kernel-2.6.16-1.2215_FC6
% uname -r
2.6.17-rc4-mm3

Did you want the vendor kernel source, or the running kernel source?

Might want to look at the symlink at /lib/modules/`uname -r`/source which
is probably as sane as it gets... (Though admittedly Fedora points it
into the wild blue yonder of /usr/src/kernels/`uname -r` which isn't
where the non-existent kernel-source RPM puts it.  Getting the .src.rpm
and working from there leaves it in /usr/src/redhat/BUILD/yadda-yadda....)

--==_Exmh_1148592598_2837P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEdiHWcC3lWbTT17ARAiVJAJ4yLWsKZ9wOzJM26DYU4iX8Nj0c5QCfXn3Q
Rt3nCq8S5flEMiqi07C6oWc=
=sz1V
-----END PGP SIGNATURE-----

--==_Exmh_1148592598_2837P--
