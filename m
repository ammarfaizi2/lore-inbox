Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTEESHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbTEESHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:07:51 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:57099 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261183AbTEESHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:07:46 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Bug 659] New: compile failure in drivers/media/radio/miropcm20-rds.c
Date: Mon, 5 May 2003 20:12:45 +0200
User-Agent: KMail/1.5.1
References: <10320000.1052152541@[10.10.2.4]>
In-Reply-To: <10320000.1052152541@[10.10.2.4]>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305052012.58214.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 May 2003 18:35, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=659
>
>            Summary: compile failure in drivers/media/radio/miropcm20-rds.c
>     Kernel Version: 2.5.68-bk11
>             Status: NEW
>           Severity: low
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: john@larvalstage.com
>
>
> Distribution:  Gentoo 1.4rc4
> Hardware Environment:  Abit KG7-RAID, AMD AthlonXP 2100+ Palomino
> Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
> Problem Description:
>
>   gcc -Wp,-MD,drivers/media/radio/.miropcm20-rds.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon
> -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=miropcm20_rds -DKBUILD_MODNAME=miropcm20_rds -c -o
> drivers/media/radio/.tmp_miropcm20-rds.o
> drivers/media/radio/miropcm20-rds.c drivers/media/radio/miropcm20-rds.c:23:
> warning: `struct inode' declared inside parameter list
> drivers/media/radio/miropcm20-rds.c:23: warning: its scope is only this
> definition or declaration, which is probably not what you want
> drivers/media/radio/miropcm20-rds.c:38: warning: `struct inode' declared
> inside parameter list
> drivers/media/radio/miropcm20-rds.c:106: variable `rds_fops' has
> initializer but incomplete type
> drivers/media/radio/miropcm20-rds.c:107: unknown field `owner' specified in
> initializer
> drivers/media/radio/miropcm20-rds.c:107: warning: excess elements in struct
> initializer
> drivers/media/radio/miropcm20-rds.c:107: warning: (near initialization for
> `rds_fops')
> drivers/media/radio/miropcm20-rds.c:108: unknown field `read' specified in
> initializer
> drivers/media/radio/miropcm20-rds.c:108: warning: excess elements in struct
> initializer
> drivers/media/radio/miropcm20-rds.c:108: warning: (near initialization for
> `rds_fops')
> drivers/media/radio/miropcm20-rds.c:109: unknown field `open' specified in
> initializer
> drivers/media/radio/miropcm20-rds.c:109: warning: excess elements in struct
> initializer
> drivers/media/radio/miropcm20-rds.c:109: warning: (near initialization for
> `rds_fops')
> drivers/media/radio/miropcm20-rds.c:110: unknown field `release' specified
> in initializer
> drivers/media/radio/miropcm20-rds.c:111: warning: excess elements in struct
> initializer
> drivers/media/radio/miropcm20-rds.c:111: warning: (near initialization for
> `rds_fops')
> drivers/media/radio/miropcm20-rds.c:106: storage size of `rds_fops' isn't
> known make[3]: *** [drivers/media/radio/miropcm20-rds.o] Error 1
> make[2]: *** [drivers/media/radio] Error 2
> make[1]: *** [drivers/media] Error 2
> make: *** [drivers] Error 2
>
>
> Steps to reproduce:
>
> Multimedia devices  --->
> Radio Adapters  --->
> <*>   miroSOUND PCM20 radio RDS user interface (EXPERIMENTAL)
>
> CONFIG_RADIO_MIROPCM20_RDS=y
>

2.5.69 compiles for me, so it seems to be fixed.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 20:11:33 up  2:36,  3 users,  load average: 1.17, 1.63, 1.50
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tqmqoxoigfggmSgRAlhjAJ913EJa4+VIdcDsKIECATn0yY7GvQCcD2/W
Ffd9jsee2DCn99S0uDTiljc=
=yDHo
-----END PGP SIGNATURE-----

