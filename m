Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268816AbUIBTxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268816AbUIBTxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268339AbUIBTxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:53:17 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3220 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S268657AbUIBTwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:52:37 -0400
Subject: Re: The argument for fs assistance in handling archives
From: Steve Bergman <steve@rueb.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       reiserfs <reiserfs-list@namesys.com>
In-Reply-To: <14260000.1094149320@flay>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
	 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
	 <4136A14E.9010303@slaphack.com>
	 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
	 <4136C876.5010806@namesys.com>
	 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
	 <4136E0B6.4000705@namesys.com>  <14260000.1094149320@flay>
Content-Type: text/plain
Date: Thu, 02 Sep 2004 14:52:24 -0500
Message-Id: <1094154744.12730.64.camel@voyager.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 11:22 -0700, Martin J. Bligh wrote:
> > For 30 years nothing much has happened in Unix filesystem semantics 
> > because of sheer cowardice 
> 
> Or because it works fine, and isn't broken.

OK.  I'm not a kernel hacker.  I'm not a crack C programmer.  Nor am I a
designer of filesystems.  I'm just a guy that puts together and supports
Linux systems for my customers.

In following this thread, I may be missing huge chunks of concept.

However, a few things are becoming clear to me:

1. The file as directory thing adds complexity that the administrator
has to deal with.  Symlinks are useful, but it's still aggravating to
tar off a directory structure, take it somewhere, and then realize that
all you have is links to something not in the archive because you didn't
get your tar switches just right.  Now we're talking about adding
another set of "files which are not really files" to the semantics.
More complexity.  I'll take simplicity over some ivory tower ideal of
"unified name space" any day.

2. The use of multiple streams within files by Linux apps would make
Linux as cross-platform unfriendly as MS is trying to be.  Say these
features start getting used and you copy an OO.org document from a Linux
box to a BSD box.  It's broken.  Of course, OO.org wouldn't use the
streams in the first place because it would destroy their cross platform
portability.  So what's the point?  No one who cares about cross
platform portability can use it.  Everyone who doesn't care about cross
platform portability please raise your hand.

3. MS does require attributes and multiple streams, which makes these
features important (even essential) to Samba, and Samba alone.  Samba is
important to Linux, so this can't be ignored. (Here I am implicitly
assuming that Samba will need kernel support for this to do it right.)

So it seems to me that the only real consideration is giving Samba what
it needs without making the semantics one bit more complex than
absolutely necessary.  It might even be wise to discourage use of these
ambiguous new objects by the casual application programmer.

Then again, maybe I just have tunnel vision... 


-Steve Bergman

