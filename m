Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263454AbSJHVsx>; Tue, 8 Oct 2002 17:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263436AbSJHVsN>; Tue, 8 Oct 2002 17:48:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:21162 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263267AbSJHVq4>;
	Tue, 8 Oct 2002 17:46:56 -0400
Date: Tue, 8 Oct 2002 14:54:19 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <andre@linux-ide.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
In-Reply-To: <Pine.GSO.4.21.0210081735370.5897-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210081446170.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That would be nice, if it worked that way.  As it is we have
> 
> driver allocates foo
> driver grabs a reference to foo->dev
> ....
> somebody else grabs/drops temporary references to foo->dev
> ....
> driver call put_device(&foo->dev)
> driver frees structures refered from foo.
> driver frees foo.
> 
> _IF_ the last two steps were done by ->release(), your arguments would
> work.  Actually they are done by driver right after the put_device() call.
> 
> If you are willing to change that (== move all destruction into ->release()) -
> yeah, then embedded struct device will work.  It's a hell of a work though.

Yes, and we're willing to do a lot of it. 

That's been the intention the whole time, and would have been done sooner,
but it's taken a freakin' long time to figure out what assumptions to make
in the core. And of course, they're not always right. ;) Which means
there's more work to be done there. The feedback is greatly appreciated,
and I'm always open to more..

Thanks,

	-pat

