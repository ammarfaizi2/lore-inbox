Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261557AbSKCB66>; Sat, 2 Nov 2002 20:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261558AbSKCB66>; Sat, 2 Nov 2002 20:58:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21767 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261557AbSKCB65>; Sat, 2 Nov 2002 20:58:57 -0500
Date: Sat, 2 Nov 2002 18:05:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David D. Hagood" <wowbagger@sktc.net>
cc: Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>, <davej@suse.de>
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <3DC47659.4060006@sktc.net>
Message-ID: <Pine.LNX.4.44.0211021803240.2300-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2 Nov 2002, David D. Hagood wrote:
> Linus Torvalds wrote:
> >
> > And pathnames are a _hell_ of a lot better and straightforward interface
> > than inode numbers are. It's confusing when you change the permission on
> > one path to notice that another path magically changed too.
> 
> Would this not allow a user to add permissions to a file, by creating a 
> new directory entry and linking it to an existing inode?
> 
> Would that not be a greater security hole?

No. The file itself has _no_ capabilities at all. If you just link to it,
you can give it whatever capabilities _you_ have as a user (well, normal
users don't really have any capabilities to give, but you get the idea).

		Linus

