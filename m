Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUBEEil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 23:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUBEEil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 23:38:41 -0500
Received: from h80ad267c.async.vt.edu ([128.173.38.124]:62338 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262360AbUBEEij (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 23:38:39 -0500
Message-Id: <200402050438.i154cAf6013993@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Bill Davidsen <davidsen@tmr.com>
Cc: the grugq <grugq@hcunix.net>, "Theodore Ts'o" <tytso@mit.edu>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch 
In-Reply-To: Your message of "Wed, 04 Feb 2004 18:47:54 EST."
             <402184AA.2010302@tmr.com> 
From: Valdis.Kletnieks@vt.edu
References: "Your message of Wed, 04 Feb 2004 12:05:07 EST." <40212643.4000104@tmr.com> <200402041714.i14HEIVD005246@turing-police.cc.vt.edu>
            <402184AA.2010302@tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-499155087P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Feb 2004 23:38:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-499155087P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 Feb 2004 18:47:54 EST, Bill Davidsen said:
> > This of course implies that 'chattr +s' (or whatever it was) has to fail
> > if the link count isn't exactly one.
> 
> Do you disagree that the count does need to be one?

I'm not prepared to say that there's no scenario where we *dont* care
how many links there are, as long as the file *does* get wiped when the
last one goes away.

The MH mail handler stores each message in a file - so a mail message is easily
stored in multiple folders by simply using multiple hard links.  I could
easily see having mail that I want to +s and go away when I remove it from
the last folder it was in....

> I agree with everything you said, "useful" doesn't always map to "easy." 
> But if you agree that the count needs to be one on files, then you could 
> also fail if you tried to add it to a directory which was not empty.

Yes you could.  The question is whether that's a desired semantic or not.

> In case I didn't make it clear, the use I was considering was to create 
> a single directory in which created files would really go away when 
> deleted. I hadn't considered doing it after files were present, what you 
> say about overhead is clearly an issue. I think I could even envision 
> some bizarre race conditions if the kernel had to do marking of each 
> file, so perhaps it's impractical.

As I said, ugly and murky....

> But what happens when the 'setgid' bit is put on a directory? At least 
> in 2.4 existing files do NOT get the group set, only files newly 
> created. So unless someone feels that's a bug which needs immediate 
> fixing, I can point to it as a model by which the feature could be 
> practically implemented.

Ahh.. but now you're suggesting a different model than "directory must
be empty".  Obviously more discussion of what we *want* it to do is needed ;)

--==_Exmh_-499155087P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIcixcC3lWbTT17ARAkSEAJ90BjG+ajH29TVG4G5Rfsw26vv0ogCguLBK
MhvG2LNicr6GXf3RWHrk4PA=
=mYCE
-----END PGP SIGNATURE-----

--==_Exmh_-499155087P--
