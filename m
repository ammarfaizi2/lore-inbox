Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVJEKXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVJEKXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbVJEKXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:23:36 -0400
Received: from h80ad251d.async.vt.edu ([128.173.37.29]:2702 "EHLO
	h80ad251d.async.vt.edu") by vger.kernel.org with ESMTP
	id S965101AbVJEKXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:23:35 -0400
Message-Id: <200510051023.j95ANApC015320@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: "D. Hazelton" <dhazelton@enter.net>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Your message of "Wed, 05 Oct 2005 11:09:42 BST."
             <20051005100942.GN10538@lkcl.net> 
From: Valdis.Kletnieks@vt.edu
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510050122.39307.dhazelton@enter.net>
            <20051005100942.GN10538@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128507789_2910P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Oct 2005 06:23:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128507789_2910P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Oct 2005 11:09:42 BST, Luke Kenneth Casson Leighton said:
> On Wed, Oct 05, 2005 at 01:22:33AM +0000, D. Hazelton wrote:
> > On Tuesday 04 October 2005 19:47, Marc Perkel wrote:
> 
> > As someone else pointed out, this is because unlinking is related to 
> > your access permissions on the parent directory and not the file.
>  
>  that's POSIX.
> 
>  i trust that POSIX has not been hard-coded into the entire design of
>  the linux kernel filesystem architecture _just_ because it's ... POSIX.

No, what got hard-coded were the concepts of inodes as the actual description
of filesystem objects, directories as lists of name-inode pairs, and the whole
user/group/other permission thing.  "unlink depends on the directory
permissions not the object unlinked" has been the semantic that people depended
on ever since some code at Bell Labs started supporting tree-structured
directories and multiple hardlinks.  POSIX merely codified existing behavior in
this case.


--==_Exmh_1128507789_2910P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQ6mNcC3lWbTT17ARAooJAJ0dptt/PTOPdS3NcNIWlh7HJqTNNQCffNY6
LvqIer5Zcag/HmMwUWDlSYU=
=mPIv
-----END PGP SIGNATURE-----

--==_Exmh_1128507789_2910P--
