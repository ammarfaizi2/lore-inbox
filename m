Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWBTNUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWBTNUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWBTNUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:20:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41440 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030206AbWBTNUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:20:47 -0500
Date: Mon, 20 Feb 2006 14:20:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220132046.GA23277@atrey.karlin.mff.cuni.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220094728.GD19293@kobayashi-maru.wspse.de> <20060220105617.GF16042@elf.ucw.cz> <200602202104.26730.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602202104.26730.nigel@suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.
> 
> On Monday 20 February 2006 20:56, Pavel Machek wrote:
> > On Po 20-02-06 10:47:28, Matthias Hensler wrote:
> > > On Mon, Feb 20, 2006 at 01:53:33AM +0100, Pavel Machek wrote:
> > > > Only feature I can't do is "save whole pagecache"... and 14000 lines
> > > > of code for _that_ is a bit too much. I could probably patch my kernel
> > > > to dump pagecache to userspace, but I do not think it is worth the
> > > > effort.
> > >
> > > I do not think that Suspend 2 needs 14000 lines for that, the core is
> > > much smaller. But besides, _not_ saving the pagecache is a really _bad_
> > > idea. I expect to have my system back after resume, in the same state I
> > > had left it prior to suspend. I really do not like it how it is done by
> > > Windows, it is just ugly to have a slowly responding system after
> > > resume, because all caches and buffers are gone.
> >
> > That's okay, swsusp already saves configurable ammount of pagecache.
> 
> Really? How is it configured?


If you want to limit the suspend image size to N bytes, do

echo N > /sys/power/image_size

before suspend (it is limited to 500 MB by default).

								Pavel
-- 
Thanks, Sharp!
