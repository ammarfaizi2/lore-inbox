Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264537AbSIREOT>; Wed, 18 Sep 2002 00:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264546AbSIREOT>; Wed, 18 Sep 2002 00:14:19 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:43993 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S264537AbSIREOS>; Wed, 18 Sep 2002 00:14:18 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: dcooppan@attbi.com, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.19 error with usbcore.o
Date: Wed, 18 Sep 2002 14:12:21 +1000
User-Agent: KMail/1.4.5
References: <3D87FFCC.6040003@attbi.com>
In-Reply-To: <3D87FFCC.6040003@attbi.com>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209181412.04433.bhards@bigpond.net.au>
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 18 Sep 2002 14:23, Daya Cooppan wrote:
> Hi
>
> I think there is a bug in kernel 2.4.19 under the usb section. I
> proceeded to build kernel 2.4.19 on a RH7.3, DELL SMP system. I have a
> wireless usb mouse, usb SanDisk, etc. Anyway the problem showed up when
> I was trying to get the usb mouse to work. This is not a new system ...I
> did have all the hw and sw components working under 2.4.5.
It has been reported before, but I couldn't reproduce it.

> The default for the USB section is to included USB support (y) in the
> kernel. I am assuming the usbcore.o got incorporated into the kernel
> build tree during [make dep; make bzImage; make modules; make
> modules_install]. I continued to get mousedev errors ...verified that I
> had mouse support, hid support, uhci support, all this look good. As
> soon as I changed "USB Support" from (y) to (m), i.e. made usbcore.o a
> loadable module WALLA! usb devices started to work. Question: Is there a
> bug with (y) support for "USB Support" ?
Can you provide an exact copy of the CONFIG_USB and CONFIG_INPUT lines from
your kernel .config for a working case, and a broken case?

> I also noticed usbdrv.o resulted in errors when included (y) in the kernel:
This is probably important :-|
Looks like some include breakage. I'll take another look if you send me the
two cases for the kenrel .config.
<snip>

- --
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9h/0lW6pHgIdAuOMRAjIdAKC2P9R5LJ7QnoDbH/HPtGUnNWOqtACdGaTt
MDIxcw51mvIcuhukjYpYm88=
=nuTs
-----END PGP SIGNATURE-----

