Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVAGXGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVAGXGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVAGXCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:02:39 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:7687 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261679AbVAGXCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:02:07 -0500
Message-Id: <200501072301.j07N1TW2027950@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/04/2005 with nmh-1.1-RC3
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paul@linuxaudiosystems.com, arjanv@redhat.com, hch@infradead.org,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk, joq@io.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-Reply-To: Your message of "Fri, 07 Jan 2005 14:36:38 PST."
             <20050107143638.L2357@build.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <200501071620.j07GKrIa018718@localhost.localdomain> <1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org> <200501072207.j07M7Lda004987@turing-police.cc.vt.edu>
            <20050107143638.L2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1105138889_12694P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jan 2005 18:01:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1105138889_12694P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Jan 2005 14:36:38 PST, Chris Wright said:

> > We already *know* how to (in principle) fix the capabilities system to make
> > it useful.  We should probably investigate doing that and at the same time
> > fixing the current CAP_SYS_ADMIN mess (which we also have at least some ideas
> > on fixing). The remaining problem is possible breakage of software that's doing
> > capability things The Old Way (as the inheritance rules are incompatible).
> 
> Fixing CAP_SYS_ADMIN whole other can o' worms.  No point in tangling the
> two.

Yes, it's two entire cans.  The problem is that in *both* cases, we're probably
going to have to do an API change.  It may be preferable to only require changes
on the userspace side once, rather than change it once to fix the inheritance
problems in 2.7/2.6.N+10 or whatever it will be, and then again in 2.9/2.6.N+20
or whatever....

> > Linus at one time said that a 2.7 might open if there was some issue that
> > caused enough disruption to require a fork - could this be it, or does somebody
> > have a better way to address the backward-combatability problem?
> 
> There's at least two ways.  Introduce a new capability module or introduce
> a PF flag to opt in.  Neither are great

A new PF flag strikes me as marginally better, especially if we have a way to
propogate from Elf headers in a way similar to Execshield's use of elf_ex.e_phnum
to set the executable-stack...

--==_Exmh_1105138889_12694P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB3xTJcC3lWbTT17ARAjwdAJ9M+QaPiC+JMTXKpYpgarNdxLUPTwCg10OQ
WtowWdV3fZ0jshH9VjYq4ww=
=TH0s
-----END PGP SIGNATURE-----

--==_Exmh_1105138889_12694P--
