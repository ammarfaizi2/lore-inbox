Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTELWCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbTELWBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:01:48 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39047 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262842AbTELWAl (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:00:41 -0400
Message-Id: <200305122212.h4CMCDJ5031682@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export. 
In-Reply-To: Your message of "Mon, 12 May 2003 17:51:25 EDT."
             <200305121754_MC3-1-388D-BC60@compuserve.com> 
From: Valdis.Kletnieks@vt.edu
References: <200305121754_MC3-1-388D-BC60@compuserve.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1759990914P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 May 2003 18:12:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1759990914P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 May 2003 17:51:25 EDT, Chuck Ebbert said:
> Alan Cox wrote:
> 
> >>   ...and on a related topic, if someone wrote a patch to optionally clear
> >> the swap area at swapoff would it ever be accepted?
> >
> > man dd ?
> 
>   "That can be done manually" does not get you the check mark in
> the list of features.  Management wants idiot-resistant security.

In particular, the code that handles the zeroing out of resource objects
before re-use needs to be "inside" the trusted-base perimeter.  This has
been well-understood for years - even my August 83 copy of the Orange Book
says (for class C2):

2.2.1.2 Object Reuse

All authorizations to the information contained within a storage object
shall be revoked prior to initial assignment, allocation, or reallocation
to a subject from the TCB's pool of unused storage objects.  No information,
including encrypted representations of information, produced by a prior
subject's actions is to be available to any subject that obtains access
to an object that has been released back to the system.

(OK.. it doesn't have to be in-kernel, but the function *does* have to
be inside the TCB, not out in random userland)...


--==_Exmh_-1759990914P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+wBw9cC3lWbTT17ARAt4RAJ9B42hSbYUYm1NmkccpICTAi4182gCg1eCX
rvdRNH6c4R34KzUKnQVyV5M=
=kSq/
-----END PGP SIGNATURE-----

--==_Exmh_-1759990914P--
