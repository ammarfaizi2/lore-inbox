Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUBPEaH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265385AbUBPEaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:30:06 -0500
Received: from h80ad24fd.async.vt.edu ([128.173.36.253]:31827 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265378AbUBPEaA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:30:00 -0500
Message-Id: <200402160429.i1G4TdAD018405@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chip Salzenberg <chip@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30 
In-Reply-To: Your message of "Sun, 15 Feb 2004 23:09:52 EST."
             <40304290.7090207@pobox.com> 
From: Valdis.Kletnieks@vt.edu
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com> <40302783.6020505@pobox.com> <20040216033740.GE3789@perlsupport.com> <40303D59.4030605@pobox.com> <200402160358.i1G3wC6W013389@turing-police.cc.vt.edu>
            <40304290.7090207@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1253340918P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Feb 2004 23:29:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1253340918P
Content-Type: text/plain; charset=us-ascii

On Sun, 15 Feb 2004 23:09:52 EST, Jeff Garzik said:
> Valdis.Kletnieks@vt.edu wrote:
> > On Sun, 15 Feb 2004 22:47:37 EST, Jeff Garzik said:

> >>to see if this sector is bad", and -hopefully- will unmark bad blocks 
> >>that were incorrectly marked bad.

That "hopefully" is the question here...

> Consider:  ext2 reads sector 1234.  drive returns "media error", and 
> then swaps the bad sector for a good one.  Reboot and run badblocks. 
> badblocks reads sector 1234, in whatever manner the drive chooses to 
> present sector 1234 to the OS.
> 
> "original" versus "redirected" block is invisible to the OS.  The OS 
> only knows that an event occured at a single point in time -- the media 
> error.

So it never sees the original incorrectly marked bad block, and thus can't
unmap it...  We'll never look at the original 1234 again and see that it was in
fact a good block, all we'll see is if the REPLACEMENT 1234 is good or bad.


--==_Exmh_1253340918P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAMEcycC3lWbTT17ARApEbAJ9hE4BTROuSBNjJde30VhwI/i46nACgykRO
9bUTYAA4r7DB4HR3VdbhmXc=
=qLW7
-----END PGP SIGNATURE-----

--==_Exmh_1253340918P--
