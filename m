Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261288AbTCYALy>; Mon, 24 Mar 2003 19:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbTCYALy>; Mon, 24 Mar 2003 19:11:54 -0500
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:5272 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S261288AbTCYALw>; Mon, 24 Mar 2003 19:11:52 -0500
Date: Tue, 25 Mar 2003 01:22:52 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Greg Kroah-Hartman <greg@kroah.com>, Gerd Knorr <kraxel@bytesex.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-Id: <20030325012252.7aafee8c.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.11claws41 (GTK+ 1.2.10; Linux 2.5.64)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.92QojB?'mRk7Nw"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.92QojB?'mRk7Nw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2003 15:26:47 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Summary of changes from v2.5.65 to v2.5.66
LT> ============================================
LT> Greg Kroah-Hartman <greg@kroah.com>:
LT>   o i2c i2c-i801.c: remove #ifdefs and fix all printk() to use dev_*()
LT>   o i2c i2c-i801.c: remove check_region() usage
LT>   o i2c i2c-i801.c: fix up the pci id matching, and change to use
LT>     proper pci ids
LT>   o i2c i2c-i801.c: fix up formatting and whitespace issues
LT>   o i2c i2c-piix4.c: remove check_region() call
LT>   o i2c i2c-piix4: remove #ifdefs and fix all printk() to use dev_*()
LT>   o i2c i2c-piix4.c: fix up formatting and whitespace issues
LT>   o i2c i2c-ali15x3.c: remove #ifdefs and fix all printk() to use
LT>     dev_*()
LT>   o i2c i2c-ali15x3.c: remove check_region() call
LT>   o i2c i2c-ali15x3.c: fix up formatting and whitespace issues
LT>   o i2c i2c-amd756.c: remove some #ifdefs and fix all printk() to use
LT>     dev_*()
LT>   o i2c i2c-amd8111.c: change a few printk() to dev_warn()
LT>   o i2c i2c-amd8111.c: change the pci driver name to have "2" in it
LT>     based on previous comments
LT>   o i2c: added i2c-isa bus controller driver
LT>   o i2c: add initial driver model support for i2c drivers
LT>   o USB: whiteheat bugfix (bugzilla.kernel.org #314)
LT>   o USB: pegasus: fix up GFP_DMA usages.  (bugzilla.kernel.org #418)

Hi,

I guess it's one of the I2C changes which breaks 2.5.66 and bttv, because
2.5.65 was still ok and there don't seem to be any relevant bttv changes.

With 2.5.66 I get a kernel oops with the following backtrace:

kobject_init + 0x2d/0x50
kobject_register + 0x17/0x70
get_bus + 0x1d/0x40
bus_add_driver + 0x5b/0xe0
driver_register + 0x2f/0x40
i2c_add_driver + 0x85/0xf0
bttv_init_module + 0x93/0xf0
msp3400_init_module + 0xf/0x20
init + 0x33/0x190
init + 0x0/0x190
kernel_thread_helper + 0x5/0x18

EIP is at kobject_get + 0x13/0x50
Code: 8b 43 10 85 c0 ...

Oops copied by hand, so I hope it's correct.

-Udo.

--=.92QojB?'mRk7Nw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE+f6FenhRzXSM7nSkRAirRAJ4jRMDDyuufUWCuk2toNt9T03gvuQCfezy7
BcC/bT0lOIAO0LgsqwwqBA4=
=ntVz
-----END PGP SIGNATURE-----

--=.92QojB?'mRk7Nw--
