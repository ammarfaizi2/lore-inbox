Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268979AbUIHC0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268979AbUIHC0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268977AbUIHC0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:26:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50879 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268972AbUIHC0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:26:14 -0400
Message-Id: <200409080015.i880Fald003078@localhost.localdomain>
To: David Lang <david.lang@digitalinsight.com>
cc: Christer Weinigel <christer@weinigel.se>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from David Lang <david.lang@digitalinsight.com> 
   of "Tue, 07 Sep 2004 15:56:08 MST." <Pine.LNX.4.60.0409071552070.10789@dlang.diginsite.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 07 Sep 2004 20:15:36 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> said:
> On Tue, 8 Sep 2004, Christer Weinigel wrote:
> > David Lang <david.lang@digitalinsight.com> writes:

[...]

> > So what happens if I have a text file foo.txt and add an author
> > attribute to it?  When I read foo.txt the next time it's supposed to
> > give me a serialized version with both the contents of foo.txt _and_
> > the author attribute?
> >
> > That would definitely confuse me.
> >
> > Or did I misunderstand something?

> good point. under my scheme you would need to access foo.txt/foo.txt or 
> foo.txt/. instead of just foo.txt

> I guess my way would work if there is a way to know that a file has been 
> extended

Out of the question if you want to use legacy tools.

>          (or if you just make it a habit of opening the file/file instead 
> of just file) but not for random additions of streams to otherwise normal 
> files.

And then a file called foo inside directory foo will have to be refered to
as foo/foo/foo...

> Oh well, it seemed like a easy fix (and turned out to be to easy to be 
> practical)

My gut feeling is that this whole concept is too messed up to be sorted
out. That something can easily be done given whatever underlying structure
there is doesn't make it worthwhile to do it. Just as it is absurdly easy
to allow hard links to directories if you look at how they are implemented,
but the consecuences aren't that easy to live with.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
