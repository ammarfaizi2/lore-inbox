Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUCKOjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUCKOjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:39:41 -0500
Received: from [193.108.190.253] ([193.108.190.253]:56237 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S261369AbUCKOjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:39:37 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <04031108183602.05054@tabby>
References: <1078775149.23059.25.camel@luke> <04031015412900.03270@tabby>
	 <1078993376.1576.33.camel@quaoar>  <04031108183602.05054@tabby>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1079015949.1576.106.camel@quaoar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 15:39:10 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2004-03-11 kl. 15:18 skrev Jesse Pollard:
> >> I should have said "designed to handle it" in a future expansion. I was
> >> wrong in making 64 bits as important as it looks.
> > I'm not talking about the 64 bits uid's and gid's. I'm talking about the
> > mapping system having to handle users' group memberships. Why would it
> > have to do that?
> NFS v2/3 have a limit of gids that can be passed. I know on v2 it is limited
> to 16. If the group that is permitted access is not in that list, then file
> access will fail, even though the user IS supposed to have access. The list
> of groups that is allowed is only the first 16 of a potentially very large
> list.

This is NOT the responsibility of the mapping system! I'm not
implementing a new network file system. All I do, is supply a system
that tells the client that what the server refers to as gid 26 is gid
523 locally. Who is a member and who is not is irrelevant!

> > Yes. I know. This is not the problem i was trying to fix. This
> > discussion is going nowhere.
> > If I redesigned the way house doors worked, you'd be moaning about the
> > fact that the TV inside the house might be broken or stolen by someone
> > who enters the house. That's true. It might very well be. The only way
> > to secure it is to give your key to noone. The second you give you key
> > to someone else, you're basically fscked. And of course I know this is a
> > problem. It's a huge problem. I hope someone will fix it some day. It is
> > not, however, what I'm trying to do here.
> Then you don't understand the problem yet.

That's funny. I thought it was the privilege of the designer to decide
what he has tried to design. When did this change?

I'll repeat it just one more time:
Imagine two systems with all the same users on them. The users however
have different uid's on the two systems. This fscks up the ownerships. I
fix this by translating the uid's before they hit the wire. Well,
actually before they hit the nfs layer. Behold! All is well, and all
users have access to their own files.

> Just because UIDs don't show up properly on the client is no reason to
> map them in an insecure manner.

Let's just for a second assume that I'm the slow one here. Why is the
world a less secure place after this system is incorporated into the
kernel?

> And it has nothing to do with house doors or TV sets.

Really? Dang, I need rewrite the entire thing now! (I BTW still reserve
the right to be sarcastic and to make other good analogies).

-- 
Salu2, Søren.

