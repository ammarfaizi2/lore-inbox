Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315974AbSETNYH>; Mon, 20 May 2002 09:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315980AbSETNYG>; Mon, 20 May 2002 09:24:06 -0400
Received: from hopi.hostsharing.net ([66.70.34.150]:55739 "EHLO
	hopi.hostsharing.net") by vger.kernel.org with ESMTP
	id <S315974AbSETNYG>; Mon, 20 May 2002 09:24:06 -0400
Date: Mon, 20 May 2002 15:24:03 +0200
From: Michael Hoennig <michael@hostsharing.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suid bit on directories
Message-Id: <20020520152403.3dcc6cc2.michael@hostsharing.net>
In-Reply-To: <200205201304.IAA07423@tomcat.admin.navo.hpc.mil>
Organization: http://www.hostsharing.net
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

> The setgid bit on a directory is to support BSD activities. It used to
> be used for mail delivery.

this is actually similar usage to my example:

> > It would be a good solution to make files created by Apaches mod_php
> > in safe-mode, not owned by web:web (or httpd:httpd or somethign)
> > anymore, but the Owner of the directory. 
> 
> No. You loose the fact that the file was NOT created by the user.

the user in my example above would be wwwrun or httpd - and that does not
make any sense at all! It would make much more sense if the new files
belonged to the owner of the directory, who is the one who owns the
virtual host.

> > I do not even see a security hole if nobody other than the user itself
> > and httpd/web can reach this area in the file system, anyway. And it
> > is still the users decision that files in this (his) directory should
> > belong to him.
> 
> 1. users will steal/bypass quota controls

Not in my example - acutally even the other way around.

> 2. Consider what happens if a user creates a file in such a directory
> and   it is executable. - since the file is fully owned by a different
> user, it   appears to have been created by that user. What protection
> mask is on   the file? Can the creator (not owner) make it setuid?
> (nasty worm   propagation method)

Again: it depends on the usage. In my case it is the other way around. A
use should know what he is doing if he is setting this flag on a
directory.  And making such files suid again, has to be prevented by the
code - that I even mentioned in my first mail on this issue.

> > Actually, the suid bit on directories works at least under FreeBSD. Is
> > there any reason, why it does not work under Linux?
> 
> I don't believe it is in the POSIX definition.

I only said, it works under FreeBSD, it is an option there.

	Michael

-- 
Hostsharing eG / c/o Michael Hönnig / Boytinstr. 10 / D-22143 Hamburg
phone:+49/40/67581419 / mobile:+49/177/3787491 / fax:++49/40/67581426
http://www.hostsharing.net ---> Webhosting Spielregeln selbst gemacht
