Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTE3VHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264121AbTE3VHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 17:07:00 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:38820 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264035AbTE3VG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 17:06:58 -0400
Date: Fri, 30 May 2003 23:20:13 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030530212013.GE3308@wohnheim.fh-wedel.de>
References: <20030530204055.GB3308@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0305301344170.2421-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0305301344170.2421-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 13:48:12 -0700, Linus Torvalds wrote:
> 
> I personally consider K&R prototypes to be useless, and downright evil. 
> Any project who still has them is either lazy or still living in the 80's, 
> and in either case I don't see any reason not to clean up the kernel side.
> 
> Besides, I'm not aware of any reason to ever really sync with zlib on that
> level (the kinds of syncs I do foresee would be security issues or similar
> if some exploit is found, but that's unlikely to be a major sync).
> 
> We've historically done other surgery to the zlib sources to make them a
> bit more readable at times (the zlib allocator was just doing ridiculous
> things, the kernel version was changed to allocate small structures
> directly on the stack and embed others statically).

How about an all or nothing approach?  If you really want to get rid
of K&R, change indentation as well, rip out some of the rather
tasteless macros (ZEXPORT, ZEXPORTVA, ZEXTERN, FAR, ...) and so on.
The code is ugly, no doubt, but has the advantage of being close to
the upstream variant.  I would hate to have the combined problems of
ugly and forked code.

You do have a point with the sync size.  The diff between 1.1.3 and
1.1.4 is 90k, of which only some 5k are functional changes.  The rest
extends the copyright times, adds/changes documentation, etc.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
