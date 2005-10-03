Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVJCC4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVJCC4U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 22:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVJCC4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 22:56:20 -0400
Received: from h80ad24a6.async.vt.edu ([128.173.36.166]:31877 "EHLO
	h80ad24a6.async.vt.edu") by vger.kernel.org with ESMTP
	id S932120AbVJCC4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 22:56:19 -0400
Message-Id: <200510030255.j932toIK012248@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Your message of "Mon, 03 Oct 2005 01:54:00 BST."
             <20051003005400.GM6290@lkcl.net> 
From: Valdis.Kletnieks@vt.edu
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
            <20051003005400.GM6290@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128308149_12821P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Oct 2005 22:55:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128308149_12821P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Oct 2005 01:54:00 BST, Luke Kenneth Casson Leighton said:

>  in the mid-80s), hardware cache line lookups (which means
>  instead of linked list searching, the hardware does it for
>  you in a single cycle), stuff like that.

OK.. I'll bite.  How do you find the 5th or 6th entry in the linked list,
when only the first entry is in cache, in a single cycle, when a cache line
miss is more than a single cycle penalty, and you have several "These are not
the droids you're looking for" checks and go on to the next entry - and do it
in one clock cycle?

Now, it's really easy to imagine an execution unit that will execute this
as a single opcode, and stall until complete.  Of course, this only really helps
if you have multiple execution units - which is what hyperthreading and
multi-core and all that is about.  And guess what - it's not news...

The HP2114 and DEC KL10/20 were able to dereference a chain of indirect bits
back in the 70's (complete with warnings that hardware wedges could occur if
an indirect reference formed a loop or pointed at itself). Whoops. :)

And all the way back in 1964, IBM disk controllers were able to do some rather
sophisticated offloading of "channel control words" (amazing what you could do
with 'Search ID Equal', 'Transfer In-Channel' (really a misnamed branch
instruction), and self-modifying CCWs).  But even then, they understood that
it was only a win if you could go do other stuff when you waited....


--==_Exmh_1128308149_12821P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQJ21cC3lWbTT17ARApo8AKDZlVwCkCSCz9pKtU84tU/JeJr8ZQCeInwD
WVR/tiTrZRtxNjd+qzz/liw=
=tjuo
-----END PGP SIGNATURE-----

--==_Exmh_1128308149_12821P--
