Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbSBIVlz>; Sat, 9 Feb 2002 16:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287699AbSBIVlp>; Sat, 9 Feb 2002 16:41:45 -0500
Received: from bitmover.com ([192.132.92.2]:61068 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S287684AbSBIVlf>;
	Sat, 9 Feb 2002 16:41:35 -0500
Date: Sat, 9 Feb 2002 13:41:32 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Lang <dlang@diginsite.com>
Cc: Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
        Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020209134132.J13735@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <dlang@diginsite.com>, Larry McVoy <lm@bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020209090527.B13735@work.bitmover.com> <Pine.LNX.4.44.0202091258110.25220-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0202091258110.25220-100000@dlang.diginsite.com>; from dlang@diginsite.com on Sat, Feb 09, 2002 at 01:01:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 01:01:34PM -0800, David Lang wrote:
> do you have a script that can go back after the fact and see what can be
> hardlinked?
> 
> I'm thinking specififcly of the type of thing that will be happening to
> your server where you have a bunch of people putting in a clone of one
> tree who will probably not be doing a clone -l to set it up, but who could
> have and you want to clean up after the fact (and perhapse again on a
> periodic basis, becouse after all of these trees apply a changeset from
> linus they will all have changed (breaking the origional hardlinks) but
> will still be duplicates of each other.

We don't, but we can, and we should.  "bk relink tree1 tree2" seems like 
the right interface.

Right now we aren't too worried about the disk space, the data is sitting 
on a pair of 40GB drives and we're running the trees in gzip mode, so they
are 75MB each.  But yes, it's a good idea, we should do it, and probably
should figure out some way to make it automatic.  I'll add it to the
(ever growing) list, thanks.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
