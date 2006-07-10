Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422694AbWGJQsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWGJQsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWGJQsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:48:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28937 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1422694AbWGJQso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:48:44 -0400
Date: Mon, 10 Jul 2006 18:51:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Michael Kerrisk <mtk-manpages@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice() and file offsets
Message-ID: <20060710165120.GI5210@suse.de>
References: <20060710121110.26260@gmx.net> <20060710125150.GM25911@suse.de> <20060710130754.26280@gmx.net> <20060710132529.GD5210@suse.de> <20060710135427.26270@gmx.net> <20060710142245.GG5210@suse.de> <20060710154854.26270@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710154854.26270@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2006, Michael Kerrisk wrote:
> Jens,
> 
> > > Yes, I understand what the code is doing, but *why* do 
> > > things this way?  (To put things another way: why not *always 
> > > have splice() update the file offset?)  I realise there may be
> > > some good reason for this, and if there is, it will go into the
> > > man page!
> > 
> > The good reason is why update the current position? I just told the
> > kernel to ignore the current position and use the given offset, why
> > would I bother updating the current position? The whole point of
> > providing an offset is to ignore the current position.
> > 
> > I must say I cannot understand why you are confused or find this
> > illogical, it makes perfect sense to me.
> 
> Yes, now it's clear to me too.
> 
> [...]
> 
> > > No!  It does not!  See the sendfile.2 man page: "sendfile() 
> > > does not modify the current file offset of in_fd."  
> > 
> > I didn't read the man page, I read the source. And it clearly updates
> > the file offset, in fact the actual sendfile portion is just a supplied
> > actor to the generic page cache read functions.
> 
> Doh!  I took what I "knew", re-read the sendfile.2 manual page to 
> check, misread the source, and then wrote an inadequate 
> test program :-{.  (The sendfile manual page is now fixed.)
> 
> > If you don't believe me, read the source and do another test app.
> > splice() behaves identically, as previously stated.
> 
> Now I believe you; sorry to have wasted your time...

No worries, glad we got it sorted out :-)

-- 
Jens Axboe

