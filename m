Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbTCOUTH>; Sat, 15 Mar 2003 15:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbTCOUSu>; Sat, 15 Mar 2003 15:18:50 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261530AbTCOUR2>;
	Sat, 15 Mar 2003 15:17:28 -0500
Date: Fri, 14 Mar 2003 13:29:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030314122903.GC8057@zaurus.ucw.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030311184043.GA24925@renegade> <22230000.1047408397@flay> <20030311192639.E72163C5BE@mx01.nexgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030311192639.E72163C5BE@mx01.nexgo.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You can wave your wand, and the soft changeset will turn into a universal 
> diff or a BK changeset.  But it's obviously a lot cleaner, extensible, 
> flexible and easier to process automatically than a text diff.  It's an 
> internal format, so it can be improved from time to time with little or no 
> breakage.
> 
> Did that make sense?

Yes.

Some kind of better-patch is badly needed.

What kind of data would have to be in soft-changeset?
* unique id of changeset
* unique id of previous changeset
(two previous if it is merge)
? or would it be better to have here
whole path to first change?
* commit comment
* for each file:
** diff -u of change
** file's unique id
** in case of rename: new name (delete is rename to special dir)
** in case of chmod/chown: new permissions
** per-file comment

? How to handle directory moves?

Does it seem sane? Any comments?

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

