Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbUEJWks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUEJWks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUEJWks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:40:48 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:50050 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S262311AbUEJWjg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:39:36 -0400
Message-Id: <200405102239.i4AMdW2E012211@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Edward Falk <efalk@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add path-oriented proc_mkdir_path() function to /proc 
In-Reply-To: Your message of "Mon, 10 May 2004 15:09:08 PDT."
             <E1BNIxQ-00013R-Fo@peregrine.corp.google.com> 
From: Valdis.Kletnieks@vt.edu
References: <E1BNIxQ-00013R-Fo@peregrine.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1050822742P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 May 2004 18:39:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1050822742P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 May 2004 15:09:08 PDT, Edward Falk <efalk@google.com>  said:
> Hi all; apologies if there's a maintainer I should be sending this to
> as well; couldn't find one in the maintainers list or in the source code.
> 
> This patch adds the function proc_mkdir_path() to fs/proc/generic.c.
> This allows kernel code to create e.g. "/proc/foo/bar/baz" without needing
> to check the hard way if /proc/foo/ and /proc/foo/bar/ already exist.

Hmm.. Looks like a useful utility function (there's certainly enough deep
trees in my /proc/sys tree), but I wonder...

1) Do we have cases where code should be implementing "it had *better* exist"
checks?  This may be important if an intermediate directory "should have" been
created by sysctl or something, and has special permission needs..

2) Alternatively, does using this open up accidental collisions where we should
have checked something *doesnt* exist already, and complain if it does?

(Feel free to address either one by adding a "Dont do that then" comment ;)

--==_Exmh_1050822742P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoASjcC3lWbTT17ARAs+lAKCSFplGHTQCyz1nsJbfo+iZpBqn9QCfWeME
ocNs+CYeZJvT6YxztLlwN7s=
=nr/H
-----END PGP SIGNATURE-----

--==_Exmh_1050822742P--
