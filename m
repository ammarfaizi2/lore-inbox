Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbTGILWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 07:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268198AbTGILWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 07:22:40 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:21430 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268177AbTGILV7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 07:21:59 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: Forking shell bombs
Date: Wed, 9 Jul 2003 13:36:03 +0200
User-Agent: KMail/1.5.2
References: <20030708193401.24226.95499.Mailman@lists.us.dell.com> <20030708202819.GM1030@dbz.icequake.net>
In-Reply-To: <20030708202819.GM1030@dbz.icequake.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307091336.12271.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 08 July 2003 22:28, Ryan Underwood wrote:
> Hi,
>
> > That's what per-user process limits are for.  Doesn't matter if it's a
> > shellscript or something else; any system without limits set is
> > vulnerable.
>
> I agree, but it would also be nice to have a way to clean up after the
> fact without giving up the box.  My limit is set at 2047 processes
> which, while being a lot, doesn't seem like enough to guarantee a dead
> box.  (Don't many busy systems have more than this number running at any
> given time?)
>
> > It's a base redhat kernel, after the cannot allocate memory, my system
> > returned to normal operation and it didnt die.
> > Is this the type of behavior you were looking for? or am i off base?
> >
> > Linux sloth 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 i686 i386
> > GNU/Linux
> >
> > $ :(){ :|:&};:
> > [1] 3071
> >
> > $
> > [1]+  Done                    : | :
> >
> > $ -bash: fork: Cannot allocate memory
> > -bash: fork: Cannot allocate memory
> > -bash: fork: Cannot allocate memory
> > -bash: fork: Cannot allocate memory
>
> Nope, on my system running stock 2.4.21, after hitting enter, wait about 2
> seconds, and the system is frozen.  Telnet connects but never gets a
> shell.  None of the SysRq process-killing combos have any effect.  After
> a few failed killalls (which eventually killed the one shell I was able
> to get), and Alt-SysRq-S never completing the sync, I gave up and
> Alt-SysRq-B.
>
> What does ulimit -u say on your system?  2047 on mine.

mb@lfs:~> ulimit -u
2047

my system doesn't freeze.
It becomes _very_ slow, but I can kill the forking processes.
After killing, the system runs just fine.
I'm using 2.4.21.

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 13:34:31 up 12 min,  2 users,  load average: 1.32, 1.22, 0.74

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/C/4soxoigfggmSgRAjRDAJ9lH45Hr0LoAJTLwG4/Xlo6a2pE7ACeMUVl
ITJ5Tucg2LLpYqkQ2Vk/dmY=
=qCMR
-----END PGP SIGNATURE-----

