Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316027AbSETODb>; Mon, 20 May 2002 10:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316033AbSETODa>; Mon, 20 May 2002 10:03:30 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:9734 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316027AbSETOD3>; Mon, 20 May 2002 10:03:29 -0400
Date: Mon, 20 May 2002 09:03:28 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205201403.JAA08246@tomcat.admin.navo.hpc.mil>
To: michael@hostsharing.net, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: suid bit on directories
In-Reply-To: <20020520152403.3dcc6cc2.michael@hostsharing.net>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hoennig <michael@hostsharing.net>:
> 
> Hi Jesse,
> 
> > The setgid bit on a directory is to support BSD activities. It used to
> > be used for mail delivery.
> 
> this is actually similar usage to my example:
> 
> > > It would be a good solution to make files created by Apaches mod_php
> > > in safe-mode, not owned by web:web (or httpd:httpd or somethign)
> > > anymore, but the Owner of the directory. 
> > 
> > No. You loose the fact that the file was NOT created by the user.
> 
> the user in my example above would be wwwrun or httpd - and that does not
> make any sense at all! It would make much more sense if the new files
> belonged to the owner of the directory, who is the one who owns the
> virtual host.

You can't tell who the user is. ANY user would be able to do that.

> > > I do not even see a security hole if nobody other than the user itself
> > > and httpd/web can reach this area in the file system, anyway. And it
> > > is still the users decision that files in this (his) directory should
> > > belong to him.
> > 
> > 1. users will steal/bypass quota controls
> 
> Not in my example - acutally even the other way around.

And just how is it prevented? quotas are applied based on either group
or user. Normally it is based on user. Once the uid is set, then the
quotas start being deducted. If the the user procedes to store 10 G of
music files, who is charged? And how do you know who put them there.

> > 2. Consider what happens if a user creates a file in such a directory
> > and   it is executable. - since the file is fully owned by a different
> > user, it   appears to have been created by that user. What protection
> > mask is on   the file? Can the creator (not owner) make it setuid?
> > (nasty worm   propagation method)
> 
> Again: it depends on the usage. In my case it is the other way around. A
> use should know what he is doing if he is setting this flag on a
> directory.  And making such files suid again, has to be prevented by the
> code - that I even mentioned in my first mail on this issue.

How are you going to control it?

> > > Actually, the suid bit on directories works at least under FreeBSD. Is
> > > there any reason, why it does not work under Linux?
> > 
> > I don't believe it is in the POSIX definition.
> 
> I only said, it works under FreeBSD, it is an option there.

Then use FreeBSD.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
