Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSERKei>; Sat, 18 May 2002 06:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSERKeh>; Sat, 18 May 2002 06:34:37 -0400
Received: from hopi.hostsharing.net ([66.70.34.150]:21977 "EHLO
	hopi.hostsharing.net") by vger.kernel.org with ESMTP
	id <S312414AbSERKeh>; Sat, 18 May 2002 06:34:37 -0400
Date: Sat, 18 May 2002 12:34:35 +0200
From: Michael Hoennig <michael@hostsharing.net>
To: Cedric Ware <cedric.ware@enst.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suid bit on directories
Message-Id: <20020518123435.6905c1e0.michael@hostsharing.net>
In-Reply-To: <20020518105252.A3897@enst.fr>
Organization: http://www.hostsharing.net
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cedric,

> > I do not even see a security hole if nobody other than the user itself
> > and httpd/web can reach this area in the file system, anyway. And it
> > is still the users decision that files in this (his) directory should
> > belong to him.
> 
> I guess it is considered a security hole if a user can create files not
> belonging to him.

where is it so much different from the guid flat on directories?  That way
too, you could get rights of a group of which you are not a member.  As
far as I can see, all what has to be prevented, is to create files with
suid flag set within such a folder - not even for a microsecond
(race-condition).  Or do I miss something?  Other issues are quota, but
this problem already exists with guid bit for directories.  And in my case
(mod_php), it is even worse the way it is.

> > Actually, the suid bit on directories works at least under FreeBSD. Is
> 
> Not under 4.x (nor OpenBSD 2.9); or did I do anything wrong?

OpenBSD is extremely carefully about security issues.  Thus, it might not
work at all in OpenBSD.  But it works under FreeBSD (as an option which
has to be compiled into the kernel).  This is exactly what I would like to
have for Linux.

	Michael

-- 
Hostsharing eG / c/o Michael Hönnig / Boytinstr. 10 / D-22143 Hamburg
phone:+49/40/67581419 / mobile:+49/177/3787491 / fax:++49/40/67581426
http://www.hostsharing.net ---> Webhosting Spielregeln selbst gemacht
