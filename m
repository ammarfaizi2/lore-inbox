Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUIGWDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUIGWDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 18:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUIGWDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:03:31 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:65493 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268672AbUIGWDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:03:25 -0400
Message-Id: <200409072201.i87M1CaS005935@laptop11.inf.utfsm.cl>
To: Spam <spam@tnonline.net>
cc: Hans Reiser <reiser@namesys.com>, Christer Weinigel <christer@weinigel.se>,
       David Masover <ninja@slaphack.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Spam <spam@tnonline.net> 
   of "Tue, 07 Sep 2004 23:29:35 +0200." <2010165891.20040907232935@tnonline.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 07 Sep 2004 18:01:12 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> said:
> Horst von Brand <vonbrand@inf.utfsm.cl> said:
> > Hans Reiser <reiser@namesys.com> said:
> >> Horst von Brand wrote:
> >> >Hans Reiser <reiser@namesys.com> said:
> >> >>Horst von Brand wrote:
> >> >>>Spam <spam@tnonline.net> said:
> >> >>>>Christer Weinigel <christer@weinigel.se> said:

[...]

> >> >>>>>2. How do we want to expose named streams?
> >> >>>>>  One suggestion is file-as-directory in some form.

> >> >>>Which is broken, as it forbids hard links to files.

> >> >>No, it forbids hard links to the directory aspect of the file-directory
> >> >>duality.

> >> >How do you distinguish a "hard link to the directory personality" from
> >> >"hard link to the file personality"?

> >> Put in (undoubtedly overly) simple terms, if you can do it to a file you
> >> can do it to the file personality, but if you currently can only do it
> >> to a directory and get an error from attempting it to a file then in the
> >> new scheme doing it to the hard link only gives the same error.

> > Let me sort this out: If it can't be done POSIXly to a directory, it can't
> > be done in Reiser4 to a file (which really is a directory too). So there
> > can be exactly _one_ hard link to a file. Way borken.

>   But you can make a hard link to a file in reiser4,

IIUC, this isn't safe (you might tie your filesystem into a knot this way,
as LWN puts it). Sure, you can do it right now (just as I was able to
create hard links to directories in some propietary Unix way back;
untangling the resulting mess, complete with segfaulting fsck, was a whole
world of fun... it just happened rarely enough that it did not matter very
much); production versions will have to forbid it (or incurr in _huge_
overheads locking everything in sight, or detecting loops).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
