Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275335AbTHMToa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275340AbTHMToa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:44:30 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4224 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S275335AbTHMToX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:44:23 -0400
Message-Id: <200308131944.h7DJiMpS001539@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1 and rootflags 
In-Reply-To: Your message of "Tue, 12 Aug 2003 23:41:37 EDT."
             <200308130341.h7D3fbqe003559@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <200308121855.h7CIt6St002437@turing-police.cc.vt.edu> <20030812142519.69a04b7c.akpm@osdl.org>
            <200308130341.h7D3fbqe003559@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1275784882P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Aug 2003 15:44:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1275784882P
Content-Type: text/plain; charset=us-ascii

On Tue, 12 Aug 2003 23:41:37 EDT, Valdis.Kletnieks@vt.edu said:

> If there's a consensus that a 'rootopts=' would be a Good Thing, I'll write a
> patch.  If not, I'll just fix the initial value of root_mountflags in init/do_mount.c ;)

OK.. I'm a dork. ;)

Turns out that root_mountflags (at least in *my* config) ends up applying to
the initrd root - so to do what I *wanted* to do I needed to fix the 'mount'
command in /linuxrc:

echo Mounting root filesystem
mount -o noatime,nodev --ro -t ext3 /dev/rootvg/root /sysroot
pivot_root /sysroot /sysroot/initrd

D'oh! :)

--==_Exmh_1275784882P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/OpUWcC3lWbTT17ARAvmSAKCOa2YNcwgotHV97fgog+DoG7JTAgCg2LWh
tljVtI0DSUYlqbWBe6p9E6k=
=CD6u
-----END PGP SIGNATURE-----

--==_Exmh_1275784882P--
