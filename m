Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUCKOTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCKOTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:19:09 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:52721 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261351AbUCKOS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:18:59 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>
Subject: Re: UID/GID mapping system
Date: Thu, 11 Mar 2004 08:18:36 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <1078775149.23059.25.camel@luke> <04031015412900.03270@tabby> <1078993376.1576.33.camel@quaoar>
In-Reply-To: <1078993376.1576.33.camel@quaoar>
MIME-Version: 1.0
Message-Id: <04031108183602.05054@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 02:22, Søren Hansen wrote:
> ons, 2004-03-10 kl. 22:41 skrev Jesse Pollard:
> > > > > > and unlimited number of groups assigned to a single user?
> > > > >
> > > > > No. That's not my problem, is it? I just provide the mapping
> > > > > system.
> > > >
> > > > but the mapping system has to be able to handle it.
> > >
> > > How do you figure that?
> >
> > I should have said "designed to handle it" in a future expansion. I was
> > wrong in making 64 bits as important as it looks.
>
> I'm not talking about the 64 bits uid's and gid's. I'm talking about the
> mapping system having to handle users' group memberships. Why would it
> have to do that?

NFS v2/3 have a limit of gids that can be passed. I know on v2 it is limited
to 16. If the group that is permitted access is not in that list, then file
access will fail, even though the user IS supposed to have access. The list
of groups that is allowed is only the first 16 of a potentially very large
list.

> > > > > The maps are on the client, so that's no issue. The trick is to
> > > > > make it totally transparent to the filesystem being mounted, be it
> > > > > networked or non-networked.
> > > >
> > > > The server cannot trust the clients to do the right thing.
> > >
> > > The server can't trust the client as it is now anyway. The client can
> > > do whatever it wants already. There is no security impact as I see it.
> >
> > Ah - but if the server refuses to map the uid then the server is more
> > protected.
>
> Yes. I know. This is not the problem i was trying to fix. This
> discussion is going nowhere.
> If I redesigned the way house doors worked, you'd be moaning about the
> fact that the TV inside the house might be broken or stolen by someone
> who enters the house. That's true. It might very well be. The only way
> to secure it is to give your key to noone. The second you give you key
> to someone else, you're basically fscked. And of course I know this is a
> problem. It's a huge problem. I hope someone will fix it some day. It is
> not, however, what I'm trying to do here.

Then you don't understand the problem yet. Just because UIDs don't show up
properly on the client is no reason to map them in an insecure manner. And
it has nothing to do with house doors or TV sets.
