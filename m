Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTI3KmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTI3KmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:42:19 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:23740 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261321AbTI3KmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:42:17 -0400
Date: Tue, 30 Sep 2003 12:42:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030930104201.GA11752@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <bla0k2$3bc$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bla0k2$3bc$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 September 2003 19:19:30 +0000, bill davidsen wrote:
> In article <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>,
> Linus Torvalds  <torvalds@osdl.org> wrote:
> 
> | Interesting. I'm pretty sure I did a "make allyesconfig" just before the
> | test6 release, so apparently x86 includes it indirectly through some path, 
> | and so it only shows up on m68k and arm?
> | 
> | This, btw, is a pretty common thing. I wonder what we could do to make 
> | sure that different architectures wouldn't have so different include file 
> | structures. It's happened _way_ too often.
> | 
> | Any ideas?
> 
> If CPU cycles are no object the include names and order can be picked
> out of the preprocessor output, add "-E" to the gcc call, pick only the
> lines starting with "1" and a header name, save in a text file. The
> problem is that config option (including arch) change the output, so
> it's only useful as a rough check.

How is this better than adding "-H", as Jamie suggested?

> Don't know if this is what you wanted, it does allow the comparison
> between arch's. Oh, it also shows that some headers are used a lot more
> than they need be, a few more ifdef's in the low level header files
> could reduce filesystem thrashing during a build. Some folks have
> machines which don't keep everything in memory :-(

How do you find the correct places to prune include lines?

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
