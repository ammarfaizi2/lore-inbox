Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUAJJd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 04:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUAJJd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 04:33:27 -0500
Received: from kknd.mweb.co.za ([196.2.45.84]:37306 "EHLO kknd.mweb.co.za")
	by vger.kernel.org with ESMTP id S264966AbUAJJdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 04:33:25 -0500
Date: Sat, 10 Jan 2004 11:37:12 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Alex <alex@meerkatsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot boot after new Kernel Build
Message-Id: <20040110113712.6c8b9483.bonganilinux@mweb.co.za>
In-Reply-To: <3FFFB60C.9010309@meerkatsoft.com>
References: <3FFFB60C.9010309@meerkatsoft.com>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__10_Jan_2004_11_37_12_+0200_u8UAzpSPZqNtOgTS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__10_Jan_2004_11_37_12_+0200_u8UAzpSPZqNtOgTS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2004 17:21:32 +0900
Alex <alex@meerkatsoft.com> wrote:

> Hi,
> I am trying to build a new kernel but what ever version 2.4.24, 2.6.0,
> 2.6.1 i am trying to build I come across the same problem.
> 
> when doing a "make install" i get the following error.
> 
> /dev/mapper/control: open failed: No such file or directlry
> Is device-mapper driver missing from kernel?
> Comman failed.
> 
> I have installed the lates packages
> device mapper 1.00.07
> initscripts 7.28.1
> modutils, lvm2.2.00.08
> mkinitrd-3.5.15.1-2
> 
> If I just ignore the message and try to boot the machine with the new
> kernel then I get a Kernel Panic.
> 
> VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unapble to mount root fs on unknown-block(0,0).
> 
> The boot command in grub is
> root (hd0,0)
> kernel /vmlinuz-2.6.1 ro root=LABEL=/ hdc=ide-scsi
> initrd /initrd-2.6.1.img
> 
> It is basically the same (except the version) as I use for 2.4.20-28 so
> I assume the label is correct.
	     ^^^^^^^^^
The label is the problem

update your /etc/fstab file to something like

/dev/hda1 / ext3 defaults 1 1

instead of
/ / ext3 default 1 1 (IIRC)

> 
> I saw quite a few messages of similar type but no real answer to the
> problem. Any Ideas what it could be ?  I am using RH9.0
> 
> Thanks
> Alex





--Signature=_Sat__10_Jan_2004_11_37_12_+0200_u8UAzpSPZqNtOgTS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//8fJ+pvEqv8+FEMRAnIyAJwNwW3fBoBg7cfNpWI8KInJVE/oNgCbBh8z
J/+i6eX12HeoIuM018d+j+Y=
=loBn
-----END PGP SIGNATURE-----

--Signature=_Sat__10_Jan_2004_11_37_12_+0200_u8UAzpSPZqNtOgTS--
