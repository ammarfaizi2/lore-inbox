Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUHYWeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUHYWeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUHYWdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:33:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:38026 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266218AbUHYWV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:21:58 -0400
Date: Wed, 25 Aug 2004 15:21:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040825215217.GK5414@waste.org>
Message-ID: <Pine.LNX.4.58.0408251516390.17766@ppc970.osdl.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
 <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
 <20040825215217.GK5414@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Aug 2004, Matt Mackall wrote:
> > 
> > It's the UNIX way.
> 
> I thought the UNIX way is "everything's a file", not "everything's a
> directory".

It really was. Directories were historically largely just files too, 
although with the special "lookup" operation. 

Historic unix didn't have readdir/rmdir/mkdir/rename or really much _any_
special directory handling. Directories were just files, and you read them 
like files.

Of course, even in that early unix, "directories" were very much a 
reality even apart from the fact that they happened to be implemented 
pretty much like files. Nobody has ever claimed that the UNIX way is 
"everything is _one_ file", after all ;)

> > Will it potentially break something? Sure. Do we care? Me, I'll take that 
> > kind of extension _any_ day over xattrs, that are fundamentally flawed in 
> > my opinion and totally useless.
> 
> There's always the option that they're both broken.

Yes. Highly likely. However, something like that _does_ end up what a 
Windows fileserver wants. IOW, even if it's broken, _something_ is likely 
forced on us by that nasty thing we call "real users". Damn them.

		Linus
