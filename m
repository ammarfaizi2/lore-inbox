Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbUKEQBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUKEQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUKEQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:01:25 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:640 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261152AbUKEQBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:01:23 -0500
Message-Id: <200411050723.iA57NGUv023856@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Serge Hallyn <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [0/6] LSM Stacking 
In-Reply-To: Your message of "Thu, 04 Nov 2004 17:04:31 CST."
             <1099609471.2096.10.camel@serge.austin.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-589413252P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Nov 2004 02:23:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-589413252P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Nov 2004 17:04:31 CST, Serge Hallyn said:
> The following set of patches add support required to stack most
> LSMs.  The most important patch is the first, which provides a
> method for more than one LSM to annotate information to kernel
> objects.  LSM's known to use the LSM fields include selinux, bsdjail,
> seclvl, and digsig.  Without this patch (or something like it),
> none of these modules can be used together.

After fixing some blecherous line-wrap issues, the patches applied
OK to a 2.6.10-rc1-mm2-RT-V0.7.11 tree (a few offsets here and there,
no rejects).

I'm currently running with 3 LSM's stacked (SELinux, capabilities, and
a local LSM that provides OpenWall functionality), and all seems to be
working *mostly* OK.  I'll post the LSM as soon as I refactor a few
patches.

One issue:  I'm seeing this from /usr/sbin/sendmail:

% /usr/sbin/sendmail
drop_privileges: setuid(0) succeeded (when it should not)

I've not tracked down what's causing this indigestion yet (I suspect some
bad interaction with capabilities - that's what caused that message to be
added to Sendmail in the first place).

--==_Exmh_-589413252P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBiypkcC3lWbTT17ARAry8AJ9IszdVWOddaQ+hXf3EzIDNc+LIsQCg/A4C
9MEqgJ2ImOdb/LlmWcxhVgc=
=WR1y
-----END PGP SIGNATURE-----

--==_Exmh_-589413252P--
