Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUCLNwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUCLNwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:52:36 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:61173 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262114AbUCLNwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:52:33 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: =?CP 1252?q?S=F8ren=20Hansen?= <sh@warma.dk>
Subject: Re: UID/GID mapping system
Date: Fri, 12 Mar 2004 07:52:09 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <1078775149.23059.25.camel@luke> <04031108183602.05054@tabby> <1079015949.1576.106.camel@quaoar>
In-Reply-To: <1079015949.1576.106.camel@quaoar>
MIME-Version: 1.0
Message-Id: <04031207520900.07660@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 08:39, Søren Hansen wrote:
> tor, 2004-03-11 kl. 15:18 skrev Jesse Pollard:
> > > Yes. I know. This is not the problem i was trying to fix. This
> > > discussion is going nowhere.
> > > If I redesigned the way house doors worked, you'd be moaning about the
> > > fact that the TV inside the house might be broken or stolen by someone
> > > who enters the house. That's true. It might very well be. The only way
> > > to secure it is to give your key to noone. The second you give you key
> > > to someone else, you're basically fscked. And of course I know this is
> > > a problem. It's a huge problem. I hope someone will fix it some day. It
> > > is not, however, what I'm trying to do here.
> >
> > Then you don't understand the problem yet.
>
> That's funny. I thought it was the privilege of the designer to decide
> what he has tried to design. When did this change?
>
> I'll repeat it just one more time:
> Imagine two systems with all the same users on them. The users however
> have different uid's on the two systems. This fscks up the ownerships. I
> fix this by translating the uid's before they hit the wire. Well,
> actually before they hit the nfs layer. Behold! All is well, and all
> users have access to their own files.

As long as it is done on the server, there is no problem.

> > Just because UIDs don't show up properly on the client is no reason to
> > map them in an insecure manner.
>
> Let's just for a second assume that I'm the slow one here. Why is the
> world a less secure place after this system is incorporated into the
> kernel?

Because a rogue client will have access to every uid on the server.

Mapping provides a shield to protect the server.

If mapping is going to be done, then it must be done on the server.

Mapping is only usefull when you are crossing security domains. It is
less than usefull within one security domain since that confuses the
issue of access rights and identity.
