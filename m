Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVECWRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVECWRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVECWRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:17:48 -0400
Received: from h80ad252c.async.vt.edu ([128.173.37.44]:25867 "EHLO
	h80ad252c.async.vt.edu") by vger.kernel.org with ESMTP
	id S261854AbVECWRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:17:39 -0400
Message-Id: <200505032217.j43MHT8b027905@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about Ext2/3 append-only attributes 
In-Reply-To: Your message of "Tue, 03 May 2005 16:58:13 EDT."
             <4ae3c1405050313585b1921ba@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <4ae3c1405050313585b1921ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115158648_3418P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 May 2005 18:17:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115158648_3418P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 May 2005 16:58:13 EDT, Xin Zhao said:
> I read some specification says that if append-only is set to a
> directory, you can only create or modify files in that directory, but
> no delete.

Could you be more specific on "some specification", and convince us that
what you read wasn't in fact wrong about things?

> But when I tried this attribute on a directory,  I was not able to
> create new files in that directory.  let's say the derectory is /dev, 
> I set it to be append-only with:

Well, creating a new file implies creating a new entry in the directory
pointing at the inode, which is "appending" to the directory.  So this
isn't at all surprising, and I'd consider the spec that says "create or modify"
to be broken.

Were you possibly thinking of the +t (sticky) bit on a directory, which when
set restricts who can unlink the file?


--==_Exmh_1115158648_3418P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCd/h4cC3lWbTT17ARAgRkAKD9ogC//AT2QbkNcTXBY6L123x3NgCg4XjS
eyR7gCoda4/RGRWiijj6dTY=
=Ob5s
-----END PGP SIGNATURE-----

--==_Exmh_1115158648_3418P--
