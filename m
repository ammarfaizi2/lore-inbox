Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTFCSqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTFCSqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:46:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35848 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262256AbTFCSqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:46:40 -0400
Date: Tue, 3 Jun 2003 20:55:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: hugang <hugang@soulinfo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: software suspend in 2.5.70-mm3.
Message-ID: <20030603185551.GA3274@zaurus.ucw.cz>
References: <20030603211156.726366e7.hugang@soulinfo.com> <1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk> <20030603223511.155ea2cc.hugang@soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603223511.155ea2cc.hugang@soulinfo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Hi Pavel Machek:
> > > 
> > > I try the 2.5.70-mm3 with software suspend function. When suspend it will oops at ide-disk.c 1526 line
> > >    BUG_ON (HWGROUP(drive)->handler);
> > > 
> > > I'm disable this check, The software suspend can work, and also can resumed. But this fix is not best way. I found in ide-io.c 1196
> > >    hwgroup->handler = NULL;
> > > is the problem.
> > 
> > The only way to make the suspend work properly is to queue the suspend
> > sequence wit the other requests. Ben was doing some playing with this
> > but I'm not sure what happened to it.
> > 
> Yes the above patch is not safe, When i'm run updatedb and suspsned, After resume will oops at kjournal. 
> 
> Here is another test on it, it can works with updatedb.
> -
> I found a best way to fix it. here is it. With the patch, I'm run updatedb and suspend for 5 counts, every things is ok.
> 


Locating Ben's patch and forward-porting 
it would be way better...
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

