Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280086AbRKEBIO>; Sun, 4 Nov 2001 20:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280089AbRKEBID>; Sun, 4 Nov 2001 20:08:03 -0500
Received: from brick.homesquared.com ([216.177.65.65]:31208 "EHLO
	brick.homesquared.com") by vger.kernel.org with ESMTP
	id <S280086AbRKEBHw>; Sun, 4 Nov 2001 20:07:52 -0500
Message-ID: <002d01c16595$e4bb57e0$fe0aa8c0@kennet.coplanar.net>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Lonnie Cumberland" <lonnie@outstep.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3BE5D6EC.8040204@outstep.com>
Subject: Re: Special Kernel Modification
Date: Sun, 4 Nov 2001 17:04:59 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um, what about chmod command?  You don't want people to be able to see
directories like /bin?  You would have those anyway in a chroot environment.
Use chmod to turn off read and execute(search) permissions to anything they
don't
need to run (ie /bin, /usr/bin, /lib, etc).  Sorry if that sounds dumb, but
there's not much information to go on.

Also, for a special xserver, all you need to make it run staroffice or
something else, is change the
shell script that starts the x server and/or the user's session.  Xdm has a
bunch of options for that.

There are also kernel "capabilities"...

----- Original Message -----
From: Lonnie Cumberland <lonnie@outstep.com>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, November 04, 2001 4:01 PM
Subject: Special Kernel Modification


> The basic problem that I am running into is that I am working on an
> Internet related project and thus need to ensure various types of
> document security for the eventual users of this system, if things go
well.
>
> I have look into using things like "chroot" to restrict the users for
> this very special server, but that solution is not what we need.
>
> I am building a special xserver that will allow users to login and then
> the xserver will run a single application such as StarOffice. When the
> user exits from the application then the Xserver will log them out.
>
> My problem is that I need to find a way to prevent the user from
> navigating out of their home directories.
>
> I have also looking the possiblility of writing my own filesystem, but I
> am told that this needs to be done at the VFS level.
>
> Is there someone who might be able to give me some information on how I
> could add a few lines to the VFS filesystem so that I might set some
> type of extended attribute to prevent users from navigating out of the
> locations.
>
> Any help would be greatly appreciated,
> Lonnie Cumberland
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

