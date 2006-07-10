Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWGJPs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWGJPs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWGJPs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:48:59 -0400
Received: from mail.gmx.de ([213.165.64.21]:58289 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965112AbWGJPs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:48:56 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 10 Jul 2006 17:48:54 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <20060710142245.GG5210@suse.de>
Message-ID: <20060710154854.26270@gmx.net>
MIME-Version: 1.0
References: <20060710121110.26260@gmx.net> <20060710125150.GM25911@suse.de>
 <20060710130754.26280@gmx.net> <20060710132529.GD5210@suse.de>
 <20060710135427.26270@gmx.net> <20060710142245.GG5210@suse.de>
Subject: Re: splice() and file offsets
To: Jens Axboe <axboe@suse.de>
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

> > Yes, I understand what the code is doing, but *why* do 
> > things this way?  (To put things another way: why not *always 
> > have splice() update the file offset?)  I realise there may be
> > some good reason for this, and if there is, it will go into the
> > man page!
> 
> The good reason is why update the current position? I just told the
> kernel to ignore the current position and use the given offset, why
> would I bother updating the current position? The whole point of
> providing an offset is to ignore the current position.
> 
> I must say I cannot understand why you are confused or find this
> illogical, it makes perfect sense to me.

Yes, now it's clear to me too.

[...]

> > No!  It does not!  See the sendfile.2 man page: "sendfile() 
> > does not modify the current file offset of in_fd."  
> 
> I didn't read the man page, I read the source. And it clearly updates
> the file offset, in fact the actual sendfile portion is just a supplied
> actor to the generic page cache read functions.

Doh!  I took what I "knew", re-read the sendfile.2 manual page to 
check, misread the source, and then wrote an inadequate 
test program :-{.  (The sendfile manual page is now fixed.)

> If you don't believe me, read the source and do another test app.
> splice() behaves identically, as previously stated.

Now I believe you; sorry to have wasted your time...

Cheers,

Michael
-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
