Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbUCJR7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUCJR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:59:18 -0500
Received: from [193.108.190.253] ([193.108.190.253]:25472 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S262727AbUCJR7K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:59:10 -0500
Subject: Re: UID/GID mapping system
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <04031009285900.02381@tabby>
References: <1078775149.23059.25.camel@luke> <04030910465700.32521@tabby>
	 <1078855981.1768.12.camel@homer>  <04031009285900.02381@tabby>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1078941525.1343.19.camel@homer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 18:58:46 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 2004-03-10 kl. 16:28 skrev Jesse Pollard:
> > Er.. no. I just use the uid_t and gid_t. Are they 64bit?
> 32 bits currently.

Ok.. But those are the data types in use in the v-nodes, right?

> > > and unlimited number of groups assigned to a single user?
> > No. That's not my problem, is it? I just provide the mapping system.
> but the mapping system has to be able to handle it.

How do you figure that?

> > The maps are on the client, so that's no issue. The trick is to make it
> > totally transparent to the filesystem being mounted, be it networked or
> > non-networked.
> The server cannot trust the clients to do the right thing.

The server can't trust the client as it is now anyway. The client can do
whatever it wants already. There is no security impact as I see it.

> The server cannot trust the client.

I know! That's an entirely different issue. The very nanosecond you give
another machine access to your filesystem, you're up shit creek anyway.
The only difference between the way things are now and after the system
I'm suggesting is in place, is that the ownerships will look sane on the
client. What possible extra security implications could this cause?

> Since different organizations are in charge of the server, how can that server trust
> the client?

Please explain how you in any way can trust a client mounting an nfs
export from your server? You can't. All you can do is keep your fingers
crossed and your hacksaw sharpened (in case you want a more hands-on
security scheme). Maps or no maps, this is the same issue.

> A violation (even minor) on the client could cause a significant
> violation of the server.

Yes. Just like it can now.

> As in a shipping department mounting a server, and a financial client
> mounting from the same server - a violation on the shipping client COULD
> expose financial data; and the server not even know. Or worse - the 
> shipping depeartment has been outsourced...
> The server MUST control access to its resources.

Yes. As always. 

If you have an idea for a patch that fixes all these issues, I'll more
than happy to see it.

-- 
Søren Hansen <sh@warma.dk>

