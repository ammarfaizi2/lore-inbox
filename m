Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316063AbSETOxR>; Mon, 20 May 2002 10:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316067AbSETOxQ>; Mon, 20 May 2002 10:53:16 -0400
Received: from hopi.hostsharing.net ([66.70.34.150]:23776 "EHLO
	hopi.hostsharing.net") by vger.kernel.org with ESMTP
	id <S316063AbSETOxP>; Mon, 20 May 2002 10:53:15 -0400
Date: Mon, 20 May 2002 16:53:12 +0200
From: Michael Hoennig <michael@hostsharing.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: pollard@tomcat.admin.navo.hpc.mil, linux-kernel@vger.kernel.org
Subject: Re: suid bit on directories
Message-Id: <20020520165312.3fb29ba2.michael@hostsharing.net>
In-Reply-To: <200205201403.JAA08246@tomcat.admin.navo.hpc.mil>
Organization: http://www.hostsharing.net
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

> > > No. You loose the fact that the file was NOT created by the user.
> > 
> > the user in my example above would be wwwrun or httpd - and that does
> > not make any sense at all! It would make much more sense if the new
> > files belonged to the owner of the directory, who is the one who owns
> > the virtual host.
> 
> You can't tell who the user is. ANY user would be able to do that.

of course not, but many features have to be used carefully, like the suid
bit on files too! 

I don't want to make the bahaviour or a suid bit on directories the
default! I just would like it as a mount option, or even something which
you have to compile into the kernel.

> > > > I do not even see a security hole if nobody other than the user
> > > > itself and httpd/web can reach this area in the file system,
> > > > anyway. And it is still the users decision that files in this
> > > > (his) directory should belong to him.
> > > 
> > > 1. users will steal/bypass quota controls
> > 
> > Not in my example - acutally even the other way around.
> 
> And just how is it prevented? quotas are applied based on either group
> or user. Normally it is based on user. Once the uid is set, then the
> quotas start being deducted. If the the user procedes to store 10 G of
> music files, who is charged? And how do you know who put them there.

Why do you ignore my example? In my example the use who runs the webserver
owns all the files, that is wrong. With the suid bit on directories, this
could be fixed. 

> > > 2. Consider what happens if a user creates a file in such a
> > > directory and   it is executable. - since the file is fully owned by
> > > a different user, it   appears to have been created by that user.
> > > What protection mask is on   the file? Can the creator (not owner)
> > > make it setuid?(nasty worm   propagation method)
> > 
> > Again: it depends on the usage. In my case it is the other way around.
> > A use should know what he is doing if he is setting this flag on a
> > directory.  And making such files suid again, has to be prevented by
> > the code - that I even mentioned in my first mail on this issue.
> 
> How are you going to control it?

Only the owner of the directories can set this flag. There is nothing to
control. 

UNIX users are able to give rights to everybody to their files, right? How
do you control that?

You don't! You just let it to the users to give access to there files to
whomever you want. My case is similar.

> > > > Actually, the suid bit on directories works at least under
> > > > FreeBSD. Is there any reason, why it does not work under Linux?
> > > 
> > > I don't believe it is in the POSIX definition.
> > 
> > I only said, it works under FreeBSD, it is an option there.
> 
> Then use FreeBSD.

No comment.

	Michael

-- 
Hostsharing eG / c/o Michael Hönnig / Boytinstr. 10 / D-22143 Hamburg
phone:+49/40/67581419 / mobile:+49/177/3787491 / fax:++49/40/67581426
http://www.hostsharing.net ---> Webhosting Spielregeln selbst gemacht
