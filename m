Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUBESYw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUBESYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:24:52 -0500
Received: from gprs146-93.eurotel.cz ([160.218.146.93]:49024 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266020AbUBESYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:24:48 -0500
Date: Thu, 5 Feb 2004 19:23:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Tomas Zvala <tomas@zvala.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205182335.GB294@elf.ucw.cz>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <20040203152805.GI11683@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203152805.GI11683@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I believe he meant to write he umounted it.
> > The problem is that there is still some data left in CDRW's cache and it 
> > needs to be emptied. That happens when CDRW is ejected and reinserted 
> > (that is why windows burning software ie. Nero wants to eject the CDR/RW 
> > when it gets written or erased).
> > Maybe kernel could flush the buffers/caches or whatever is there when 
> > CDROM gets mounted. But im afraid about compatibility with broken drives 
> > such as LG.
> 
> There's no command to invalidate read cache, you are probably thinking
> of the SYNC_CACHE command to flush dirty data to media (which is what LG
> fucked up).
> 
> IMO, it's a user problem.

Does not look like so.

mount
umount
cdrecord -blank
mount
see old data

That looks pretty bad. If there's no other solution, we might just
document it, but...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
