Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVCaDTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVCaDTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVCaDTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:19:54 -0500
Received: from h80ad2599.async.vt.edu ([128.173.37.153]:3341 "EHLO
	h80ad2599.async.vt.edu") by vger.kernel.org with ESMTP
	id S261925AbVCaDTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:19:51 -0500
Message-Id: <200503310319.j2V3JhXJ009858@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Nick Orlov <bugfixer@list.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3: class_simple API 
In-Reply-To: Your message of "Sun, 27 Mar 2005 13:04:31 EST."
             <20050327180431.GA4327@nikolas.hn.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050327180431.GA4327@nikolas.hn.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1112239182_3808P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Mar 2005 22:19:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1112239182_3808P
Content-Type: text/plain; charset=us-ascii

On Sun, 27 Mar 2005 13:04:31 EST, Nick Orlov said:

> Problem is that the latest bk-driver-core patch included in the 2.6.12-rc1-mm3
> removes class_simple API without providing EXPORT_SYMBOL'ed (as opposed to
> EXPORT_SYMBOL_GPL) alternative.
> 
> As the result I don't see a way how out-of-the-kernel non-GPL drivers
> (nvidia in my case) could be fixed.

Umm.. try running the latest drivers?

[~]2 uname -a
Linux turing-police.cc.vt.edu 2.6.12-rc1-mm3 #1 PREEMPT Sat Mar 26 22:07:50 EST 2005 i686 i686 i386 GNU/Linux
[~]2 lsmod | grep nvidia
nvidia               3912636  14 
agpgart                25672  2 nvidia,intel_agp
[~]2 grep -i nvidia /var/log/kernmsg
Mar 30 21:58:19 turing-police kernel: [4294721.402000] nvidia: module license 'NVIDIA' taints kernel.
Mar 30 21:58:19 turing-police kernel: [4294721.434000] NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7167  Fri Feb 25 09:08:22 PST 2005

(All usual disclaimers about binary modules apply.  If 7167 doesn't work for
you, bug NVidia (Zander is usually quite helpful with providing patches) and/or
check the NVidia/Linux message boards (there's a link on the NVidia driver
download page).


--==_Exmh_1112239182_3808P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCS2xOcC3lWbTT17ARArHmAKCB3mfzV2338NZZ5rIFkwTyHQO1CQCg/W4e
uutKH5cWeNWlqBe61KGfXZY=
=9wDI
-----END PGP SIGNATURE-----

--==_Exmh_1112239182_3808P--
