Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316094AbSETP5R>; Mon, 20 May 2002 11:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316097AbSETP5R>; Mon, 20 May 2002 11:57:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62214 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316094AbSETP5P>; Mon, 20 May 2002 11:57:15 -0400
Date: Mon, 20 May 2002 11:53:11 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
cc: michael@hostsharing.net, linux-kernel@vger.kernel.org
Subject: Re: suid bit on directories
In-Reply-To: <200205201403.JAA08246@tomcat.admin.navo.hpc.mil>
Message-ID: <Pine.LNX.3.96.1020520114319.28501C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Jesse Pollard wrote:

> Michael Hoennig <michael@hostsharing.net>:

> > > 1. users will steal/bypass quota controls
> > 
> > Not in my example - acutally even the other way around.
> 
> And just how is it prevented? quotas are applied based on either group
> or user. Normally it is based on user. Once the uid is set, then the
> quotas start being deducted. If the the user procedes to store 10 G of
> music files, who is charged? And how do you know who put them there.

  I won't repeat my previous, but obviously the owner of the file is
charged, and (b) if you care who put it there don't have a directory like
that. If you are a control freak you don't create the directory in the
first place. The behaviour is a feature not a problem.
 
> > > 2. Consider what happens if a user creates a file in such a directory
> > > and   it is executable. - since the file is fully owned by a different
> > > user, it   appears to have been created by that user. What protection
> > > mask is on   the file? Can the creator (not owner) make it setuid?
> > > (nasty worm   propagation method)
> > 
> > Again: it depends on the usage. In my case it is the other way around. A
> > use should know what he is doing if he is setting this flag on a
> > directory.  And making such files suid again, has to be prevented by the
> > code - that I even mentioned in my first mail on this issue.
> 
> How are you going to control it?

  The code is already in place to remove the setuid bit when changing
the owner of a file. I don't see more than an AND on the permissions in
creat() to provide this protection as the owner is changed.
 
> > > > Actually, the suid bit on directories works at least under FreeBSD. Is
> > > > there any reason, why it does not work under Linux?
> > > 
> > > I don't believe it is in the POSIX definition.
> > 
> > I only said, it works under FreeBSD, it is an option there.
> 
> Then use FreeBSD.

  If developers had taken that approach to suggestions for enhancements in
network code people would, and Linux would be saddled with the 1.x network
code (shudder). Ditto journaling, bitmapped filesystems, etc. All started
from features in other operating systems. To reverse your idea, if you
don't want progress stay with 2.2.xx and don't read a DEVELOPMENT list.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
"He stood across the path of progress, loudly crying HALT!"

