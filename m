Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272062AbRIDSH2>; Tue, 4 Sep 2001 14:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272061AbRIDSHT>; Tue, 4 Sep 2001 14:07:19 -0400
Received: from [194.213.32.141] ([194.213.32.141]:3844 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S272058AbRIDSHH>;
	Tue, 4 Sep 2001 14:07:07 -0400
Date: Tue, 4 Sep 2001 17:03:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
Message-ID: <20010904170322.B48@toy.ucw.cz>
In-Reply-To: <999595577.11178.3.camel@nomade> <Pine.GSO.4.21.0109040612300.26423-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0109040612300.26423-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Sep 04, 2001 at 06:15:17AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Read-only is more complex - in addition to mount side ("does anyone want
> > > it to be r/w") there is a filesystem side ("does fs agree to be r/w")...
> > 
> > How about, say, a reiserfs mounted r/o on a shared partition (loopback
> > over nfs) ? If it contains errors, maybe 2 "clients" will attempt to
> > rollback at the same time. Is the solution to never mount, even r/o,
> > remote journalling fs ?
> 
> ??? Rollback is purely local thing, so NFS client doesn't matter at all.
> And nfsd is just an application running on server, whether it's a kernel
> thread or a normal process.

Notice he said *loopback* over nfs [i.e. mount /nfs/xyzzy -o loop,ro -t 
reiserfs]. Or think nbd.

And yes, being able to mount reiserfs without replaying log is usefull.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

