Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTJAOFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTJAOFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:05:17 -0400
Received: from h80ad24ae.async.vt.edu ([128.173.36.174]:6034 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262117AbTJAOFL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:05:11 -0400
Message-Id: <200310011405.h91E55cG008853@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification for binaries 
In-Reply-To: Your message of "Wed, 01 Oct 2003 12:26:31 +0200."
             <20031001102631.GC398@elf.ucw.cz> 
From: Valdis.Kletnieks@vt.edu
References: <3F733FD3.60502@ericsson.ca>
            <20031001102631.GC398@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1482376194P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Oct 2003 10:05:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1482376194P
Content-Type: text/plain; charset=us-ascii

On Wed, 01 Oct 2003 12:26:31 +0200, Pavel Machek said:

> > Instead of writing a long detailed explication, I rather give you an 
> > example of how you can use it.
> 
> Can you also add example *why* one would want to use it?
> 
> AFAICS if I want to exec something, I can avoid exec() syscall and do
> mmaps by hand...

The idea isn't to stop you from calling exec*().

The idea is to ensure that if you do execve("/usr/bin/foobar",...) that the
foobar binary hasn't been tampered with and you're not about to launch a binary
differing from what you expected.   Note that on a properly administered
system, this is a *high* level of paranoia, as the file permissions should have
prevented writing to the binary in the first place.  It's also a maintenance
nightmare waiting to happen, as you get to re-sign all the binaries every time
you install a patch, and it won't help prevent trojaned shared libraries...


--==_Exmh_1482376194P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/et8OcC3lWbTT17ARAttpAJ4tH1UJ/qUlrkFIw6IYVJW0esCsqwCg09r6
+v1R4rMyWBbg3wJoNMwD3CE=
=n954
-----END PGP SIGNATURE-----

--==_Exmh_1482376194P--
