Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbTE3WNL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 18:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTE3WNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 18:13:11 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:19627 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264007AbTE3WNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 18:13:10 -0400
Date: Sat, 31 May 2003 00:26:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030530222630.GF3308@wohnheim.fh-wedel.de>
References: <20030530212013.GE3308@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0305301431390.2671-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0305301431390.2671-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 14:38:07 -0700, Linus Torvalds wrote:
> On Fri, 30 May 2003, Jörn Engel wrote:
> > 
> > How about an all or nothing approach?  If you really want to get rid
> > of K&R, change indentation as well, rip out some of the rather
> > tasteless macros (ZEXPORT, ZEXPORTVA, ZEXTERN, FAR, ...) and so on.
> 
> I'd love to, but I suspect we lack the motivation to do so, and there 
> aren't any obvious upsides. Yes, the code is ugly, but it's also fairly 
> stable so people seldom need to look at it.

Well, since I'm currently working on the zlib anyway...

> The motivation for doing the ANSI-fication is just that there is now a 
> sanity checker tool that will complain loudly about bad typing, and since 
> I wrote it and I hate old-style K&R sources, it doesn't parse them. 

Sounds nice.  Did I miss it on lkml, or haven't you made it public
yet?

> I wouldn't mind syncing more, but one reason _against_ syncing the zlib 
> sources have been the ugliness of them. Is there any reason for the 
> K&R'ness any more, or the strange allocators?

The allocaters could be useful when lots of zlibs are fighting over
scarce memory, at least when operating in userspace.  K&R and
indentation seem to be personal style (inflate and deflate also have a
different style, when you look closely).  FAR, uInt and friends should
be portability wrappers, there was even a turboc bugfix in the code
before 1.1.4.

Who knows, the performance might even slightly improve after shaving
off some of the useless wrappers.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
