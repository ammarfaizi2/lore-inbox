Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265630AbUABUan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUABU33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:29:29 -0500
Received: from h80ad254a.async.vt.edu ([128.173.37.74]:32191 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265667AbUABU1y (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:27:54 -0500
Message-Id: <200401022027.i02KRe7X013502@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Claas Langbehn <claas@rootdir.de>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS forced shutdown with kernel 2.6.0 
In-Reply-To: Your message of "Fri, 02 Jan 2004 18:29:21 GMT."
             <20040102182921.A27237@infradead.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040102095051.GA19872@rootdir.de>
            <20040102182921.A27237@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1860073584P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Jan 2004 15:27:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1860073584P
Content-Type: text/plain; charset=us-ascii

On Fri, 02 Jan 2004 18:29:21 GMT, Christoph Hellwig said:

> I've seen the same bug a few times lately, but only if I had previous
> memory corruption due to code I was hacking on.  Can you reproduce it
> without the nvidia module loaded as that is likely source of such
> corruption?

While you're at it, see what *else* you can turn off - RAID, devfs, NFS, etc.

It's equally likely that you're tripping over some other kernel module's
use-after-free or chase-the-wrong-pointer bug.  I've seen a lot more bugfixes
for *those* on this list than cases where "I turned off nvidia and it started
working".

>From the 2.6.1-rc1 release notes:

Jeff Garzik:
  o [libata] fix use-after-free
Stephen Hemminger:
  o [ROSE]: Fix use after free in socket destruction

Andrew Morton, on broken iee1394:

> aargh, sorry.  You need to revert
>
>	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc1/2.6.1-rc1-mm1/broken-out/sysfs-add-vc-class.patch
>
> This is the totally weird tty oops which Greg and I have been starting
> at bemusedly for a few days.

That's *this week* or so. Yes, I understand the political and/or realistic
reasons for refusing to look at tainted kernels, but let's face it guys, *our*
code is to blame more often than NVidia's.  When was the last time there was a
*verified* report of "I turned the NVidia graphics module off and things
worked" that wasn't directly related to a graphics issue?


--==_Exmh_-1860073584P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/9dQ8cC3lWbTT17ARArKIAJ9DhuID6a64NS2C4syITqd0pPVr4QCfXlNZ
tdIH3vQ1sJnWfWhZCl7/KV0=
=Ji3J
-----END PGP SIGNATURE-----

--==_Exmh_-1860073584P--
