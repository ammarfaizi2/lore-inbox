Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265682AbUFEI2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUFEI2k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 04:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUFEI2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 04:28:40 -0400
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:40162 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S265682AbUFEI2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 04:28:16 -0400
In-Reply-To: <1086390590.4588.70.camel@imladris.demon.co.uk>
References: <200406041000.41147.cijoml@volny.cz> <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com> <1086390590.4588.70.camel@imladris.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-21-742694562"
Message-Id: <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
From: Daniel Egger <de@axiros.com>
Subject: Re: jff2 filesystem in vanilla
Date: Sat, 5 Jun 2004 10:27:56 +0200
To: David Woodhouse <dwmw2@infradead.org>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-21-742694562
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 05.06.2004, at 01:09, David Woodhouse wrote:

> Linus' tree is updated periodically when I'm sufficiently happy with 
> the
> stability of the development tree in CVS, and when I have time to merge
> it, test it and read through all the changes for sanity -- which often
> involves redoing some of them. You should be OK using what's in the
> kernel -- let me know if you have problems.

The original version in the 2.4 kernel has a dramatic problem
leading to FS corruption, at least when used with blkmtd on CF.
That's why I'm using 2.4 and a CVS snapshot, not only because
it is much faster.

>> To use it on a non-MTD[1] device you will need an emulation layer,
>> the pseudo Block-MTD device. And you will need some additional 
>> partition
>> using ext2/ext3/reiserfs/FAT containing the kernel for your Grub/LILO
>> bootloader.

> JFFS2 on blkmtd isn't ideal -- it's designed to work on real flash. But
> it works. It could do with someone making it use the stuff we did for
> NAND -- batching writes into 512-byte chunks etc.

Believe it or not but JFFS2 is the only filesystem that works
reasonably on CF, especially when the system is used mostly read
only and the device is cut off from power every now and then. ;)

I tried different FS which we used read-only (and remounted it
r/w in case we needed it) in the last tries but we still were
able to kill a card without a problem and had FS corruption which
needed a console to fix.

Servus,
       Daniel

--Apple-Mail-21-742694562
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQMGEEjBkNMiD99JrAQI5xQgAuDG5FCWj1KSNZi20LBD1XRPEM/C+2pOV
rUjuSKoRpaDktOeRDWcwHcoUXh9eQ9OKvrTREcXLfVZqK/OpALj+UAdDTIFso4UB
ZaqUmIUQHiJRcAY/8VpMTJhNcn5nsY6JtpfdZ9B5OOv4a37i2+SmgcHc2oTBFqK5
dSrLYzIiwOwJTi6sKuB6nKAQV1XKKxGbWSlGomamqnHMcxo98I4uSc/8QipfIHRj
wkg4lN2IrLjgbXRXlKlZeOiurizw1odZ6kR9AUoxmPgJKq/PelRAs0oSt3Nit7WY
1DMloyWArrRzzfVzEgfgD31uPH8HzkOrrrZGsPWj6HyGSDx8D3KE8w==
=tw+7
-----END PGP SIGNATURE-----

--Apple-Mail-21-742694562--

