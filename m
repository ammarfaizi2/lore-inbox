Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVELRWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVELRWV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 13:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVELRWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 13:22:21 -0400
Received: from mail.dif.dk ([193.138.115.101]:653 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262083AbVELRWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 13:22:15 -0400
Date: Thu, 12 May 2005 19:26:10 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
 cleanup)
In-Reply-To: <42835BDB.40505@grupopie.com>
Message-ID: <Pine.LNX.4.62.0505121925160.2390@dragon.hyggekrogen.localhost>
References: <20050510161657.3afb21ff.akpm@osdl.org>
 <20050510.161907.116353193.davem@davemloft.net> <20050510170246.5be58840.akpm@osdl.org>
 <20050510.170946.10291902.davem@davemloft.net>
 <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost>
 <20050510172913.2d47a4d4.akpm@osdl.org> <Pine.LNX.4.62.0505110236520.2386@dragon.hyggekrogen.localhost>
 <4281E78B.2030103@grupopie.com> <20050511225657.GM6884@stusta.de>
 <42834935.9060404@grupopie.com> <42835BDB.40505@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Paulo Marques wrote:

> Paulo Marques wrote:
> > Adrian Bunk wrote:
> > 
> > > On Wed, May 11, 2005 at 12:07:55PM +0100, Paulo Marques wrote:
> > > [...]
> > > 
> > > > Just a small sugestion: do a sha (or md5sum, or whatever hash function
> > > > you prefer) to vmlinux before and after applying the patches.
> > > > 
> > > > If all is well, it shouldn't change (since this is just whitespace
> > > > cleanup), and it is a little more robust than just checking the size.
> > > 
> > > That's wrong.
> > > 
> > > vmlinux contains the date of the compilation.
> > 
> > You're right, I forgot about that...
> > 
> > Removing UTS_VERSION from init/version.c would make this work, or are there
> > other places where this might be a problem?
> 
> Ok, I've just tested this.
> 
> At least with my config, if I remove both instances of UTS_VERSION from
> init/version.c, the resulting vmlinux files are exactly identical with the
> same sha1sum.
> 
> So maybe Jesper can use this to make *really* sure that there are no actual
> changes with the patches, just whitespace changes.
> 

Yeah, that does seem to work. I had not thought of that - thanks.


/Jesper Juhl

