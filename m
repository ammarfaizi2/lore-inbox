Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVCUOXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVCUOXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVCUOXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:23:13 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:11934 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261808AbVCUOXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:23:07 -0500
Message-ID: <423ED8C7.1020008@yahoo.co.jp>
Date: Mon, 21 Mar 2005 23:23:03 +0900
From: "Tetsuji \"Maverick\" Rai" <badtrans666@yahoo.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050315
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: prompt_ramdisk=1 and load_ramdisk=1 doesn't work with 2.6.11 on floppy
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am making a small boot-floppy linux distro with kernel 2.6.11.   The
kernel is so big that I need to load ramdisk from the second floppy
and I don't use initrd.   My problem is the kernel wouldn't prompt to
load ramdisk image.  I tried syslinux, grub and lilo as boot loader
and for syslinux, I put syslinux.cfg as follows:
- --------------
DEFAULT bzImage noinitrd ramdisk_size=10240 ramdisk_start=0
prompt_ramdisk=1 load_ramdisk=1 root=/dev/ram0 disksize=1.44
prompt 1
timeout 50
- ---------------

kernel boots as usual, however it stops without loading ramdisk floppy
saying:

- -----------
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
- -----------
This error message makes sense because it hasn't loaded ramdisk image
(block(1,0) means /dev/ram0, IMHO).  But in my kernel configuration,
ramdisk is enabled and the default size is 8192kb.  The boot message
says the size of ramdisk is 10240kb, so I guess the kernel recognizes
kernel options.  Then why doesn't prompt for the ramdisk floppy?

I've read syslinux is not compatible with kernel 2.6.something in this
mailing-list archive, tried with grub and lilo with the same kernel
options, but in vain..  so I guess the loader doesn't matter.

Thanks in advance!

- --
Tetsuji Rai (in Tokyo) aka AF-One (Athlete's Foot-One) Maverick6664
Maverick's Linux http://maverick.trickip.net/
Aviation jokes http://www.geocities.com/tetsuji_rai
Profile http://maverick.ns1.name/
maverick6664@abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijk.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCPtjEUJQIBQjS0i0RAm4kAKCF7w1Y7n8i4kTq91r3cfsE0fii2wCdEf+4
c6lBXN1zHcVaE2be1j4jN9w=
=xDxL
-----END PGP SIGNATURE-----


