Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270441AbTHGQJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270342AbTHGQJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:09:32 -0400
Received: from h80ad277d.async.vt.edu ([128.173.39.125]:25984 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270441AbTHGQHn (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:07:43 -0400
Message-Id: <200308071607.h77G7WPp005392@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Themel <themel@iwoars.net>, linux-kernel@vger.kernel.org
Subject: Re: Device-backed loop broken in 2.6.0-test2? 
In-Reply-To: Your message of "Wed, 06 Aug 2003 17:40:43 PDT."
             <20030806174043.27fd674a.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030806224022.GA3741@iwoars.net>
            <20030806174043.27fd674a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1649676586P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Aug 2003 12:07:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1649676586P
Content-Type: text/plain; charset=us-ascii

On Wed, 06 Aug 2003 17:40:43 PDT, Andrew Morton said:

> We're currently setting PF_READAHEAD across a call into the page allocator. 
> We end up calling writepage() with PF_READAHEAD set and the block layer
> aborts the writes, resulting in corrupted data.
> 
> It only seems to bite with loop-on-blockdev for some reason.

For what it's worth, I've been seeing these same symptoms on ext3 on an LVM
partition - so it's not *just* loop, it appears to be any filesystem that interposes
a mapping layer.  Hmm.. wonder if this explains the failures on RAID that somebody
was reporting, too....

/Valdis (who is off to apply the patch that Andrew attached, which doesn't appear to
be in -mm5)...


--==_Exmh_1649676586P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/MnlDcC3lWbTT17ARAsZUAKCz/+wdMf8OJgap3pjMFl7p8zW3jgCg1Tr3
swbv80ahXMvK+b1QIH4JSHI=
=L7xr
-----END PGP SIGNATURE-----

--==_Exmh_1649676586P--
