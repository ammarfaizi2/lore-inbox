Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266599AbUFRTlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUFRTlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUFRTk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:40:26 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9089 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266599AbUFRTjq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:39:46 -0400
Message-Id: <200406181940.i5IJeBDh032311@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness 
In-Reply-To: Your message of "Fri, 18 Jun 2004 13:12:34 PDT."
             <40D34CB2.10900@opensound.com> 
From: Valdis.Kletnieks@vt.edu
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de> <40D32C1D.80309@opensound.com> <20040618190257.GN14915@schnapps.adilger.int>
            <40D34CB2.10900@opensound.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1711540843P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Jun 2004 15:40:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1711540843P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Jun 2004 13:12:34 PDT, 4Front Technologies said:

> We precisely use this mechanism - we use 
> /lib/modules/<version>/build/include/linux/config.h to figure such features out
> but when the "build" part of the path doesn't point to the right source tree,
> where do you look?. SuSE ships kernel sources "unconfigured" which means that
> you have to rely on something else to tell you what the exact kernel
> configuration looks like.

Right, but hopefully you can tell it's a SuSE machine via other means, and
then apply a suitable workaround.

Or are you claiming that SuSE is *so* weird that you can't even apply a
test like:

if [ -test $SuSE ]; then
	echo Smells like a SuSE box - which of the following best describes your box?
	i=1
	for foo in ($likely_dirs) do;
		echo ${i}: $foo
		i=`expr $i + 1`
	done;
	read flavor
	echo You chose $flavor...
	ln -s /usr/src/linux/$flavor my_build
fi


--==_Exmh_1711540843P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA00UbcC3lWbTT17ARAuz2AJ4vMaN9JOIjQV4QVEKF9plgpS8c9ACePog9
sROgOBrH01s22lNiBSUiJW0=
=iOPX
-----END PGP SIGNATURE-----

--==_Exmh_1711540843P--
