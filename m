Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbUBQGtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUBQGtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:49:17 -0500
Received: from h80ad2696.async.vt.edu ([128.173.38.150]:33201 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266051AbUBQGtM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:49:12 -0500
Message-Id: <200402170648.i1H6muER029579@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH} 2.6 and grsecurity 
In-Reply-To: Your message of "Tue, 17 Feb 2004 01:13:59 EST."
             <Xine.LNX.4.44.0402170110400.19316-100000@thoron.boston.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0402170110400.19316-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-56350232P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Feb 2004 01:48:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-56350232P
Content-Type: text/plain; charset=us-ascii

On Tue, 17 Feb 2004 01:13:59 EST, James Morris said:
> On Mon, 16 Feb 2004 Valdis.Kletnieks@vt.edu wrote:

> > Agreed - the only one that seems at all a *big* win is randomizing PID's
> > (and even there it probably should default a higher value for pid_max to
> > increase the search space).  But as long as I was looking at it anyhow.. :)
> 
> How is this a big win?  Looks like cargo cult security to me.

Well.. I'll tell ya.. Yes, it's not totally bulletproof security.  And yes, the
*right* thing to do is to go and fix all the userspace programs that use
predictable values of mktemp() in bogus ways. On the other hand, Fedora Core 2
Test 1 is running around 1,900+ RPMs.  That's a lot of code to audit, and Linux
doesn't have a Theo doing it.  And that's not counting any 3rd party code that
a system might have on it.  And even after that, it's often a hard sell getting
a full-blown thing like a locked-down SELinux onto a user's system - but it's
often a lot easier to sell the user a kernel that's been hardened to resist some
of the more common classes of attacks.

The PaX/exec-shield code is the same way - we all *know* that both are
defeatable given enough effort.  Why is it seen as useful?  Because it at least
locks the barn doors and makes the cattle rustler fit the cow out that tiny
window instead.. ;)

No, this won't stop a truly determined and skilled hacker.  However, it puts
a major crimp in the style of a script kiddie who's got an exploit that depends
on "we can predict the next PID to within 3 or 4".  And quite frankly, I've spent
a lot more of the last 2 decades cleaning the latter off systems than the former.

It's all about raising the bar...

> > Or they OK because they're only doing a separately distributed patch?
> 
> No.

Hmm... :)

--==_Exmh_-56350232P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAMblYcC3lWbTT17ARAufpAJwMtJ36wyXe4HTS5v546EXabyvNkgCfcSLv
aBLBQ0Y3d5VAKle7c1pEmeM=
=aatm
-----END PGP SIGNATURE-----

--==_Exmh_-56350232P--
