Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264135AbTFDVVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbTFDVVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:21:49 -0400
Received: from pointblue.com.pl ([62.89.73.6]:55058 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S264135AbTFDVVn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:21:43 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: 2.4.21-rc7 ACPI broken
Date: Wed, 4 Jun 2003 22:16:14 +0100
User-Agent: KMail/1.5.2
References: <F760B14C9561B941B89469F59BA3A847E96F25@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F25@orsmsx401.jf.intel.com>
Cc: acpi-support@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306042216.19142@gjs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I know that latest acpi patch is against -rc3, but it aply to -rc7 just with 
one problem in documentation, so i dont care. Anyway, recompilation if it 
fails:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-rc7/include -Wall -Wstrict-prototypes 
- -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
- -pipe -mpreferred-stack-boundary=2 -march=i686 -falign-functions=0 
- -falign-jumps=0 -falign-loops=0   -nostdinc -iwithprefix include 
- -DKBUILD_BASENAME=acpiphp_glue  -c -o acpiphp_glue.o acpiphp_glue.c
acpiphp_glue.c: In function `find_host_bridge':
acpiphp_glue.c:815: warning: passing arg 2 of `acpi_get_object_info' from 
incompatible pointer type
acpiphp_glue.c:821: error: subscripted value is neither array nor pointer
acpiphp_glue.c:826: error: incompatible type for argument 1 of `strcmp'
make[3]: *** [acpiphp_glue.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.21-rc7/drivers/hotplug'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.21-rc7/drivers/hotplug'
make[1]: *** [_subdir_hotplug] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.21-rc7/drivers'
make: *** [_dir_drivers] Error 2

Any chance to get quick fix of that ?
Please CC me, i am not subscribed to acpi mailing list.

Thanks

> > > Old ACPI code, get patch from http://sf.net/projects/acpi
> > and report back
> > > if problems persist.
> > Any chance to get patch against latest -rc7 ?
> It's big, and deemed too risky. We are shooting for 2.4.22-pre1.
> Did it work for you?

- --
Grzegorz Jaskiewicz
K4 Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3mGiqu082fCQYIgRAsBBAJ991RPum0QFcwRVqI8d3KTZp2NI6QCfSjAT
0obQhDO93Od0EjTHArZjEB0=
=oJ9C
-----END PGP SIGNATURE-----

