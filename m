Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTETURK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 16:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTETURK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 16:17:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4235 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261159AbTETURI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 16:17:08 -0400
Message-Id: <200305202030.h4KKU1ug011128@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: /proc/kcore - how to fix it 
In-Reply-To: Your message of "Tue, 20 May 2003 13:05:15 PDT."
             <DD755978BA8283409FB0087C39132BD101B00DDE@fmsmsx404.fm.intel.com> 
From: Valdis.Kletnieks@vt.edu
References: <DD755978BA8283409FB0087C39132BD101B00DDE@fmsmsx404.fm.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1928944008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 20 May 2003 16:30:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1928944008P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 May 2003 13:05:15 PDT, "Luck, Tony" said:

> What about discontiguous memory.  Since /proc/kcore is super-user only
> we could continue with the attitude that the user should be careful not
> to touch memory that doesn't exist, or we could be kind and provide an
> API so that the architecture specific code that finds the memory can tell
> /proc/kcore what exists.

"don't touch memory that doesn't exist" is a bad idea unless there is *some*
sort of API that allows the program to intuit what does/doesn't exist.  If
the program can't find out what is legal without hitting an oops or worse,
nobody will use /proc/kcore, and then why bother implementing it?

(Note that I'd consider "look *here* for a pointer to known-existing memory,
then look 24 bytes into there for a pointer to a linked list of memory
block address/size pairs" sufficient, no need for a fancy /proc interface.
Of course, that's just my opinion - those who don't have memories of
pointer chasing in S/360 assembler under OS/MVT may have other opinions ;)

--==_Exmh_1928944008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+ypBIcC3lWbTT17ARAq1KAJ4o/hjlZcsI9Tv9LBpvY9zxbwhO/QCbBoZo
EBcJ1g8p6RFULfWBxzh0/vk=
=uCNH
-----END PGP SIGNATURE-----

--==_Exmh_1928944008P--
