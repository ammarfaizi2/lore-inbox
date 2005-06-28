Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVF1SBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVF1SBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVF1SBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:01:02 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57000 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262169AbVF1SA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:00:26 -0400
Message-Id: <200506281800.j5SI0FEe011475@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Sreeni <sreeni.pulichi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Management during Program Loading 
In-Reply-To: Your message of "Tue, 28 Jun 2005 13:49:46 EDT."
             <94e67edf05062810497c7a20b5@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <94e67edf05062810497c7a20b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119981615_3764P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jun 2005 14:00:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119981615_3764P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Jun 2005 13:49:46 EDT, Sreeni said:
> In our system we have a secure physical memory starting and ending at	
> predefined addresses. We want to execute certain programs, which have	
> to be running secure in those address spaces only.

Can you explain how this memory is "secure", and how you expect a kernel that's
running *outside* this secure space to load a program into it?

> Is it possible to force the loader to load the "particular" program 
> (both the code and data segment) at that pre-defined secure physical 	
> memory, without any major kernel changes?

It's more complicated than that - not only do you need to worry about running
the program in that space, you also need to worry about things like malloc()
space for the program, I/O buffers, and so on.....

--==_Exmh_1119981615_3764P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCwZAvcC3lWbTT17ARAq4PAKCLJuLIZ6LQ/2CfLWAAwBm7ADjCvwCgnV5B
RxzLPhuQND68pHwtRxHigxA=
=tCCK
-----END PGP SIGNATURE-----

--==_Exmh_1119981615_3764P--
