Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUDFUBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbUDFUBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:01:25 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:45956 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S263984AbUDFUBR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:01:17 -0400
Message-Id: <200404062001.i36K1429024400@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Tue, 06 Apr 2004 11:16:03 PDT."
             <20040406181603.13828.qmail@web40506.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040406181603.13828.qmail@web40506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1255166829P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Apr 2004 16:01:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1255166829P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Apr 2004 11:16:03 PDT, Sergiy Lozovsky said:

> My code works during system calls (before the real
> one). Interrupts are enabled. If it enters the loop
> scheduler still can switch tasks (using timer for
> example). If it doesn't work in such way I can easily
> call schedule(); implicitly after some time limit will
> be reached - it's VM, so it's easy to do such things.

Yes, but your security manager is *still* in an infinite loop, and eventually
you *will* come to a grinding halt, as each process gets queued up waiting for
a decision from the security manager.

As an aside, the original posting said it was a restricted subset of Lisp that
didn't include recursion.  Aside from the technical difficulties of detecting
two or more routines that mutually recurse, it's unclear that Lisp without
recursion is at all interesting or useful....

This is sounding more and more like the old adage: "When all you have
is a hammer, everything starts looking like a thumb".


--==_Exmh_1255166829P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAcwx/cC3lWbTT17ARAvC1AJsGEjWh1IbFsVKPZZswEWjElmyTcQCg+6In
HHYdqvGx3Z9buL2jrDxVIAE=
=UEmu
-----END PGP SIGNATURE-----

--==_Exmh_1255166829P--
