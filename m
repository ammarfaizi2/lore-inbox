Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbVFXBYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbVFXBYU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVFXBYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:24:19 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:13309 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262981AbVFXBYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:24:02 -0400
Message-ID: <42BB60AA.1060606@namesys.com>
Date: Thu, 23 Jun 2005 18:23:54 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@pobox.com>, David Masover <ninja@slaphack.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins (back to flames, oh well)
References: <20050620235458.5b437274.akpm@osdl.org>	 <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com>	 <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>	 <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com>	 <42B8F4BC.5060100@pobox.com>  <42BA4F7E.6000402@namesys.com> <1119546015.17063.14.camel@localhost.localdomain>
In-Reply-To: <1119546015.17063.14.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I am entitled to get some advantage from being the first on the block
>>    
>>
>
>You were not first on the block. Linus was, 
>
>thats why it's Linux (well
>not directly his fault about the name) and why he sets policy. I've
>never heard Linus espousing such an idea so I wonder why you think that
>way. Rather I've heard Linus tell groups of people with differing ideas
>about interfaces to go figure it out first and build the right interface
>then come back with a consensus (for example with SELinux)
>  
>
We aren't people with differing ideas about interfaces, we are one
filesystem team with functionality that no other filesystem has yet
expressed a concrete desire to use, and some guy who complains about it
after it has been the basis for coding for 4 years without expressing
any desire to use it himself, merely expressing a desire that we not use
it because he never paid any attention to our website or mailing list
for the last 4 years as we developed it.  

Oh, and he says it is duplicative without explaining where in VFS
plugins and pluginids are currently defined. 

Oh, and rather than saying "clever guys, thanks for coming up with this,
I am going to go write a patch that makes your ideas available to other
filesystems to do this", he says, stay out of the tree because your code
is so crappy that it has to be used by everyone else before you can go in.

There is absolutely nothing preventing him from generalizing it to other
filesystems after we go into the tree.  If you take the existing code as
a base, the generic part of the work required is I hope small.   The fs
specific part is more though, as each filesystem has to implement
methods for storing and retrieving plugins, and then a set of plugins
(and their methods).

It is all pure turf war.  Some guy suddenly realized that VFS was not
doing something, and got upset that someone else was writing code that
did the job.  Since it was someone else's code, and ready to go, and he
had nothing himself written yet, it had to be crap and kept out.

In fairness, it might be possible to eliminate a function indirection or
two if the effort was made.   There is no need to do it this week as
merging our code will not make it the least bit more difficult to change
things later, but hey, if someone wants it, happy to discuss the right
way to do it.

This is why Linux doesn't have the contributors its market share would
suggest it should expect.  Contributing to Linux is such a misery.

If you guys would just say "plugins, interesting, can we make it more
general so other filesystems can use it?"  I would be happy to have Zam
do it for you.
