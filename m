Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUIPNPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUIPNPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUIPNPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:15:35 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:26779 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268045AbUIPNPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:15:19 -0400
Message-Id: <200409160634.i8G6YhOR008893@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: gene.heskett@verizon.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: journal aborted, system read-only 
In-Reply-To: Your message of "Mon, 13 Sep 2004 16:12:59 BST."
             <1095088378.2765.18.camel@sisko.scot.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <200409121128.39947.gene.heskett@verizon.net>
            <1095088378.2765.18.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1836963373P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Sep 2004 02:34:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1836963373P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Sep 2004 16:12:59 BST, "Stephen C. Tweedie" said:

> Well, we really need to see _what_ error the journal had encountered to
> be able to even begin to diagnose it.  But 2.6.9-rc1-mm3 and -mm4 had a
> bug in the journaling introduced by low-latency work on the checkpoint
> code; can you try -mm5 or back out
> "journal_clean_checkpoint_list-latency-fix.patch" and try again?

I just got bit by the 'journal aborted' problem under -rc1-mm5, so it
looks like that particular bug wasn't at fault here (also, I started seeing
the problem under -mm2, so that's another point against that theory...)

Sep 16 01:29:05 turing-police kernel: journal_bmap: journal block not found at offset 5132 on dm-8
Sep 16 01:29:05 turing-police kernel: Aborting journal on device dm-8.
Sep 16 01:29:05 turing-police kernel: ext3_abort called.

This happened about 4 minutes into a 'tar cf - | (cd && tar xf -)' pipeline
to clone a work copy of the -rc1-mm5 source tree (it got about 408M through the
543M before it blew up)....


--==_Exmh_1836963373P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBSTQDcC3lWbTT17ARAu/bAJ9TKpwVCqm9O67ps/XQwUVOQcQ/7QCgirVf
oEqvFxm9zyaPFdhBdWSsUUI=
=7tAi
-----END PGP SIGNATURE-----

--==_Exmh_1836963373P--
