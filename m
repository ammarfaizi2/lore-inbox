Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbUCPITl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263536AbUCPITl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:19:41 -0500
Received: from [193.108.190.253] ([193.108.190.253]:42162 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S263516AbUCPITg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:19:36 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <04031511053600.13518@tabby>
References: <1078775149.23059.25.camel@luke> <04031207520900.07660@tabby>
	 <1079103602.1571.26.camel@quaoar>  <04031511053600.13518@tabby>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1079424522.1566.20.camel@quaoar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 09:08:43 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 2004-03-15 kl. 18:05 skrev Jesse Pollard:
> > > Because a rogue client will have access to every uid on the server.
> > As opposed to now when a rogue client is very well contained?

You didn't answer this.

> > > Mapping provides a shield to protect the server.
> > A mapping system could provide extra security if implemented on the
> > server. That's true. This is, however, not what I'm trying to do. This
> > system is NOT a security related one (it doesn't increase nor decrease
> > security), but rather a convenience related one.
> Then it becomes an identity mapping (as in 1:1) and is therefore
> not usefull.

If you don't find it useful, don't use it.

> If you are doing double mapping, then I (as a server administrator)
> would not export the filesystem to you.

Whereas now all clients are trustworthy?

> The current situation is always a 1:1 mapping (NFS version < 4).

Didn't you just say 1:1 mapping isn't useful?

> If you as an administrator of a client host violate the UIDs assigned to
> you (by hiding the audit trail), then you are violating the rules established
> in that security domain; and should not be trusted - and the client host
> should not have an available export.

Exporting filesystems via NFS is always insecure. This system just makes
it more convenient for the client. The very picosecond you decide to
allow e.g. the entire LAN to mount your filesystems you've thrown
security out the window.

What do you propose I do, if my company e.g. is running Solaris on the
servers and I want to mount something from one of the servers on my
laptop? I can't go and demand them to make changes to their Solaris nfs
implementations (well, I COULD, but I COULD also hammer nails through my
toes. Neither will make a difference). If I just mount the filesystem,
the ID's a bound to be messed up unless the user and group database on
my laptop is EXACTLY the same as on the server. News flash: They aren't.
And I KNOW that I'm far from alone with this problem. That do you
propose I do then?

And what about this:
The server's user database uses UID's 1000 and up for regular users. If
I create 2000 users on my laptop with uid's 1000-2999 and mount the
filesystem from the server? I can just log in with each of these users
and access the files of the user on the server with the same UID as my
local user. See? No mapping involved and yet I have access to everything
I want. So, you can't trust nfs clients now either! So what's the big
deal if I make it more convenient to use it by implementing a mapping
system that maps my local uid to my uid on the server?

-- 
Salu2, Søren.

