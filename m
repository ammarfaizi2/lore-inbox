Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268329AbUG2QEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268329AbUG2QEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268330AbUG2QEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:04:10 -0400
Received: from linux.us.dell.com ([143.166.224.162]:17837 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S268352AbUG2QDn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:03:43 -0400
Date: Thu, 29 Jul 2004 11:02:18 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: David Balazic <david.balazic@hermes.si>
Cc: Dave Jones <davej@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
Message-ID: <20040729160218.GA20901@lists.us.dell.com>
References: <B1ECE240295BB146BAF3A94E00F2DBFF090202@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF090202@piramida.hermes.si>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 29, 2004 at 03:05:10PM +0200, David Balazic wrote:
> > David, you had said before that by downgrading your BIOS you no longer
> > saw the delay.  Is this not still true?
> >=20
> Still true, downgrading removes the delay.

OK, then I'm inclined to believe it's a BIOS bug really...

> > You also mentioned that Grub made different calls.  I'll check that
> > out too.
> >=20
> Can you make a patch, that only accesses hd0 and hd1 ?

Reduce the value of
#define EDD_MBR_SIG_MAX 16

in include/linux/edd.h  to whatever value you like, e.g. 2.

> Or one which prints what is it doing, on each step ?
> ( I tried this one myself, but it did not work :blush: , IA32 assembler
> is not my strong side )

That's more PITA - it's in real mode, before anything's ever been
printed.  I'd prefer not to have to figure that out if I can avoid it.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBCR+KIavu95Lw/AkRAt4tAJ9CYLmsy2+3JAdG/wiEIS9IkAXmRQCgjfig
/1wTFQ7iYPUTtW3B4od5ayI=
=PJEd
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
