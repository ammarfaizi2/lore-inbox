Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbTEEQ4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTEEQzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:55:52 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:25609 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263704AbTEEQzc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:55:32 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Bug 660] New: compile failure in net/decnet/dn_route.c
Date: Mon, 5 May 2003 19:07:29 +0200
User-Agent: KMail/1.5.1
References: <10210000.1052152520@[10.10.2.4]>
In-Reply-To: <10210000.1052152520@[10.10.2.4]>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051907.42721.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 May 2003 18:35, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=660
>
>            Summary: compile failure in net/decnet/dn_route.c
>     Kernel Version: 2.5.68-bk11
>             Status: NEW
>           Severity: low
>              Owner: jgarzik@pobox.com
>          Submitter: john@larvalstage.com
>
>
> Distribution:  Gentoo 1.4rc4
> Hardware Environment:  Abit KG7-RAID, AMD AthlonXP 2100+ Palomino
> Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
> Problem Description:
>
>   gcc -Wp,-MD,net/decnet/.dn_route.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=athlon
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=dn_route
> -DKBUILD_MODNAME=decnet -c -o net/decnet/.tmp_dn_route.o
> net/decnet/dn_route.c net/decnet/dn_route.c: In function
> `dn_route_output_slow':
> net/decnet/dn_route.c:1058: `flp' undeclared (first use in this function)
> net/decnet/dn_route.c:1058: (Each undeclared identifier is reported only
> once net/decnet/dn_route.c:1058: for each function it appears in.)
> net/decnet/dn_route.c: In function `dn_route_input_slow':
> net/decnet/dn_route.c:1183: structure has no member named `fwmark'
> make[2]: *** [net/decnet/dn_route.o] Error 1
> make[1]: *** [net/decnet] Error 2
> make: *** [net] Error 2

already fixed in 2.5.69

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 19:06:31 up  1:31,  3 users,  load average: 1.36, 1.17, 1.07
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tppeoxoigfggmSgRAjntAJwMpOlZP9wuc3SMTe5YVtuUCu06ugCeJSnn
yw5itEpvi/mDela7sy4D4pg=
=Go7K
-----END PGP SIGNATURE-----

