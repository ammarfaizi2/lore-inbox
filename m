Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTI2F52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 01:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTI2F52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 01:57:28 -0400
Received: from h80ad26f5.async.vt.edu ([128.173.38.245]:48578 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262836AbTI2F50 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 01:57:26 -0400
Message-Id: <200309290557.h8T5vGtH014179@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Indraneel Majumdar <indraneel@smartpatch.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple link 
In-Reply-To: Your message of "Mon, 29 Sep 2003 00:43:22 CDT."
             <20030929054322.GA445@smartpatch.net> 
From: Valdis.Kletnieks@vt.edu
References: <20030929054322.GA445@smartpatch.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1278771444P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Sep 2003 01:57:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1278771444P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 Sep 2003 00:43:22 CDT, Indraneel Majumdar <indraneel@smartpatch.net>  said:
> Hi,
> I was wondering if it's possible to link to multiple directories at the
> same time:
> 
> link <link_name> <target1> <target2> <target3>...

Not really a kernel question, but anyhow..

'man 2 link' and 'man 2 symlink' will tell you that the system calls only make
one link at a time.  What /bin/ln does is a userspace question, but Kerhnigan
and Pike would likely say the Right Answer is:

% for i in target1 target2 target3; do ln link-name $i; done

If you're asking something else, such as "How do I hardlink a directory to more
than one parent?", that *is* a kernel question, but the generic answer is "You
don't, unless you have a novel way to identify the Right Answer for 'where does
../ point?'".  Check the archives, it was beaten to death a few weeks ago....


--==_Exmh_1278771444P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/d8m7cC3lWbTT17ARAveXAJ48xmveR1Owz+P6xJT1t0lF0Bk+iwCg7Ow7
SItNVbO7I1MqlLmAoqWBaRg=
=1ODA
-----END PGP SIGNATURE-----

--==_Exmh_1278771444P--
