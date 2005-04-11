Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVDKBJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVDKBJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 21:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVDKBJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 21:09:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:52704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261251AbVDKBJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 21:09:16 -0400
Date: Sun, 10 Apr 2005 18:11:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
In-Reply-To: <20050411003005.GG5902@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504101805080.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz>
 <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu>
 <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu>
 <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
 <20050411003005.GG5902@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Apr 2005, Petr Baudis wrote:
>
> Dear diary, on Sun, Apr 10, 2005 at 10:38:11PM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> told me that...
> ..snip..
> > Can you pull my current repo, which has "diff-tree -R" that does what the 
> > name suggests, and which should be faster than the 0.48 sec you see..
> 
> Am I just missing something, or your diff-tree doesn't handle
> added/removed directories?

You're not missing anything, I did it that way on purpose. I thought it 
would be easier to do the expansion in the caller (who knows what it is 
they want to do with the end result).

But now that I look at merging, I realize that was actually the wrong
thing to do. A merge algorithm definitely wants to see the expanded tree,
since it will compare/join several of the diff-tree output things. 

So I'll either fix it or decide to just go with your version instead. I'm 
not overly proud. 

			Linus
