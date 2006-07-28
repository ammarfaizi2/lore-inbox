Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161214AbWG1SUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161214AbWG1SUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbWG1SUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:20:17 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:38606 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161214AbWG1SUP (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:20:15 -0400
Message-Id: <200607281820.k6SIK9Vb003499@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2-mm1 - hard lockups on Dell C840
In-Reply-To: Your message of "Thu, 27 Jul 2006 01:56:39 PDT."
             <20060727015639.9c89db57.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20060727015639.9c89db57.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154110809_3129P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 14:20:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154110809_3129P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Jul 2006 01:56:39 PDT, Andrew Morton said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/

I'm seeing pseudorandom hard lockups soon after boot on a Dell Latitude C840.
It just siezes up, even alt-sysrq is totally wedged, need to power cycle to
recover.  There doesn't seem to be a really obvious trigger - the first time it
died after all the /etc/rc5.d scripts, while trying to start the X server. The
second, I brought it up single-user, and it didn't even live long enough to
give me a prompt.  Multiple attempts hung at different places, but always
within 2-3 minutes.

2.6.18-rc1-mm1 works fine, as does 2.6.18-rc2 plus origin.patch and git-libata-all.patch
(vanilla -rc2 won't recognize my piix controller, not in a mood to reconfigure
to use ide rather than libata).

Off to go play bisect-the-mm, though it may be later in weekend before I
finish that...

--==_Exmh_1154110809_3129P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEylVZcC3lWbTT17ARAlRVAKC7NYGT3vI1MYDVoa0+Li4UKgr3CgCg+RSO
1JOQaxlyHYboIScv/H/TCZw=
=yST8
-----END PGP SIGNATURE-----

--==_Exmh_1154110809_3129P--
