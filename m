Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbUKJAVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbUKJAVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUKJAVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:21:30 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:45956 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261806AbUKJAVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:21:18 -0500
Message-ID: <41915EF9.6060604@g-house.de>
Date: Wed, 10 Nov 2004 01:21:13 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Matt Domsch <Matt_Domsch@dell.com>, Linus Torvalds <torvalds@osdl.org>,
       Pekka Enberg <penberg@gmail.com>, Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
References: <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de> <20041109234053.GA4546@lists.us.dell.com>
In-Reply-To: <20041109234053.GA4546@lists.us.dell.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matt Domsch schrieb:
> 
> -BIOS EDD facility v0.16 2004-Jun-25, 16 devices found
> +BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
> 
> So with the latest EDD patch noted above, it's finding more disks than
> before.  How many disks do you actually have in the system?

i have one scsi disk (sda) and two atapi cdrom drives:

hda: CRD-8483B, ATAPI CD/DVD-ROM drive
hdb: AOPEN CD-RW CRW3248 1.17 20020620, ATAPI CD/DVD-ROM drive
...
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sda: drive cache: write back

the "scsi0 : sym-2.1.18k" is on a pci card, the atapi devices are
connected onboard. if it helps:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/lspci-v.txt
http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/lspci-vv.txt

> I'll review the assembly again to see where I could have miscounted,
> and see how that may affect the EDD sysfs exports.  Likely no answer
> from me before tomorrow though.

that's ok, real life kicks in here too...

thanks,
Christian.

PS: do you have *any* idea how this could be related to the snd-es1371
driver (which is producing the oops then)?
- --
BOFH excuse #449:

greenpeace free'd the mallocs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkV75+A7rjkF8z0wRAl67AJ9P+SF1WfRe7r2zoF9D/b/fyDeD0QCfe6/f
Uxt5DVlb/IzW9VSWuFJqLlI=
=Hpg9
-----END PGP SIGNATURE-----
