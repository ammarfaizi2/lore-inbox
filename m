Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVCOWgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVCOWgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVCOWgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:36:35 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:27916 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261989AbVCOWeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:34:09 -0500
Message-ID: <423762DE.5000501@tuxrocks.com>
Date: Tue, 15 Mar 2005 15:34:06 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Valdis.Kletnieks@vt.edu, Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [PATCH 0/5] I8K driver facelift
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com> <200503150812.j2F8CABo004744@turing-police.cc.vt.edu>            <MPG.1ca0de763cbc3456989715@news.gmane.org> <200503151730.j2FHUT3k018541@turing-police.cc.vt.edu>
In-Reply-To: <200503151730.j2FHUT3k018541@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Valdis.Kletnieks@vt.edu wrote:
> Well, (a) the next rev of the patch will hopefully provide more access to the
> second thermal probe than just detecting its existence (it still doesn't do
> the sysfs or whatever magic to make the actual value accessible), and (b) the
> probe I *know* about is on the CPU, and runs over 40C easily as well (it's sitting
> at 49C right now).  Remember we're talking about a laptop here, there's not
> a lot of room for a big heat sink in there.. ;)

I've been trying to work out how to do this through dynamic sysfs
attributes, but I have not found a way to create arbitrary attributes
like this.  It's not hard to define them at kernel compile time, but
selecting the right number of sensors to compile in seems arbitrary.  My
Inspiron 9200 has 4 sensors, and who knows how many next year's model
will have.  It just doesn't seem like the Linux Kernel way of doing
things to arbitrarily limit it like this.

I've looked into several ways of creating sysfs attributes, but haven't
found anything that works right/well.  One of the most interesting was
in this past LKML thread - http://lkml.org/lkml/2004/8/20/287  If I
could replace the sysfs_attr_show() with my own, I believe that might
work (the attribute is passed into the function, so the name should be
available).

It's odd that it's so easy to compile sysfs attributes into the kernel,
but nobody seems to know how to generate them dynamically.

Thoughts?  Suggestions?

Thanks,
Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCN2LeaI0dwg4A47wRAhWEAKC+CcoLmoyvS6RXy7n7gtTnKjPXsACgtCbE
zofgMMEmc5mAzrQKdKwpIMQ=
=xNOU
-----END PGP SIGNATURE-----
