Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbREZJTG>; Sat, 26 May 2001 05:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbREZJS4>; Sat, 26 May 2001 05:18:56 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:58250 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S262622AbREZJSr>;
	Sat, 26 May 2001 05:18:47 -0400
Message-Id: <m153aD1-000OizC@amadeus.home.nl>
Date: Sat, 26 May 2001 10:18:07 +0100 (BST)
From: arjan@fenrus.demon.nl
To: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux-2.4.5
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105252107010.1520-100000@penguin.transmeta.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0105252107010.1520-100000@penguin.transmeta.com> you wrote:

> If there are more situations like this, please get a stack trace on the
> deadlock (fairly easy these days with ctrl-scrolllock), and let's think
> about what make for the nasty pattern in the first place instead of trying
> to add more "reserved" pages.

What I've been seeing so far is that, say, 16 processes all need memory, and
start to write out stuff. All only half succeed, eg they allocate memory for
the writeout but don't actually get enough and sleep for more.
Now that isn't too much of a problem UNTIL kswapd is one of those.....

