Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTDWTQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264587AbTDWTQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:16:05 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52864 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264582AbTDWTQA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:16:00 -0400
Message-Id: <200304231928.h3NJS73j002919@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Chris Wright <chris@wirex.com>
Cc: lkml <linux-kernel@vger.kernel.org>, lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68 
In-Reply-To: Your message of "Wed, 23 Apr 2003 12:15:17 PDT."
             <20030423121517.C15094@figure1.int.wirex.com> 
From: Valdis.Kletnieks@vt.edu
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil> <20030423191749.A4244@infradead.org> <20030423112548.B15094@figure1.int.wirex.com> <20030423125452.I26054@schatzie.adilger.int>
            <20030423121517.C15094@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_300256906P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Apr 2003 15:28:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_300256906P
Content-Type: text/plain; charset=us-ascii

On Wed, 23 Apr 2003 12:15:17 PDT, Chris Wright <chris@wirex.com>  said:
> * Andreas Dilger (adilger@clusterfs.com) wrote:

> > The only reason to use a common "system.security" is if the actual data
> > stored therein was usable by more than a single security module.
> 
> Or, as mentioned, if you care to print out the label with standard
> fileutils.

The requirement that things like ls, find, cp and so on know where to look
for these things trumps any "purity of labels" arguments.

In addition, a case can be made that different modules *should* use the
same name - because that way when you're re-labelling a file system for
a new security module, you can actually *detect* old crufty conflicting
labels added by some previous module.

"Warning: file %s was already labelled with attribute %s"

If you do as Chris suggests, you can't implement this in a clean manner.

--==_Exmh_300256906P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+pulHcC3lWbTT17ARAnbTAKDQ4v4uepnX45/VsIYLDGzJz3NUjgCgyeBA
Du58yyud1GpD35q3iVaq3Tg=
=tFo1
-----END PGP SIGNATURE-----

--==_Exmh_300256906P--
