Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271391AbRHOT52>; Wed, 15 Aug 2001 15:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271390AbRHOT5T>; Wed, 15 Aug 2001 15:57:19 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:37281 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S270921AbRHOT5N>; Wed, 15 Aug 2001 15:57:13 -0400
Date: Wed, 15 Aug 2001 21:57:23 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, mag@fbab.net,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits
Message-ID: <20010815215723.F9870@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E15Wz1n-00033Y-00@the-village.bc.nu> <Pine.LNX.4.33.0108150952001.2220-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0108150952001.2220-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 15, 2001 at 09:53:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 09:53:09AM -0700, Linus Torvalds wrote:
> > For that to work we need to seperate struct user from the uid a little, or
> > provide heirarchical pools (which seems overcomplex). Its common to want
> > to take a group of users (eg the chemists) and give them a shared limit
> > rather than per user limits
> 
> No, I think the answer there is to do all the same things for "struct
> group" as we do for user.
 
Not really. Large installations use ACLs instead of groups. 

Why? Because if we have 2^31 users, there might be a slight
chance, that we need more then 32 group memberships per user.

So let's better stop relying more and more on this group brain
damage and start supporting ACLs. We can support building ACL
groups, but please let the user and not the admin build them.

It's called user data, because the user owns it and should
decide, which people are allowed to access it. 

Please look at AFS groups, to see what I mean.

All serious admins I know miss the ACL feature in Linux. One
product even emulates them via groups.


Regards

Ingo Oeser
-- 
I just found out that the brain is like a computer.
If that's true, then there really aren't any stupid people.
Just people running Windows.
