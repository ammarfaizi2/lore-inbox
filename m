Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVCYWbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVCYWbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVCYW3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:29:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:25521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261852AbVCYW1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:27:16 -0500
Date: Fri, 25 Mar 2005 14:27:13 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jason@stdbev.com, linux-kernel@vger.kernel.org,
       Steven Cole <elenstev@mesatop.com>
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
Message-ID: <20050325222713.GL28536@shell0.pdx.osdl.net>
References: <20050325002154.335c6b0b.akpm@osdl.org> <42446B86.7080403@mesatop.com> <424471CB.3060006@mesatop.com> <20050325122433.12469909.akpm@osdl.org> <4244812C.3070402@mesatop.com> <761c884705af2ea412c083d849598ca7@stdbev.com> <20050325140654.430714e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325140654.430714e2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> 
> (Please dont' edit the cc line.  Just do reply-to-all)
> 
> "Jason Munro" <jason@stdbev.com> wrote:
> >
> > > [  146.301026] rock: directory entry would overflow storage
> > > [  146.301044] rock: sig=0x5245, size=8, remaining=0
> > > [  158.388397] rock: directory entry would overflow storage
> > > [  158.388415] rock: sig=0x5850, size=36, remaining=34
> > > [root@spc1 steven]#
> > 
> > 
> > Same results with mm3 here, though mm2 will not boot on my machine so I'm
> > not sure about that. 2.6.12-rc1 works fine, rc1-mm3 successfully mounts the
> > cdrom device but shows no contents. Releveant dmsesg output:
> > 
> > rock: directory entry would overflow storage
> > rock: sig=0x4543, size=28, remaining=0
> > rock: directory entry would overflow storage
> 
> Seems that I am unable to read.  It's the new rock-ridge bounds checking.
> 
> It worked for me.  Is someone able to get an image of a failing filesystem
> into my hands?

I'm interested as well.  It should only be the last in the series.
Does reverting it allow the CD to work?  (I'm trying to make sure the
other overflow check in the series isn't breaking things, I doubt is,
but...).

ftp.kernel.org:/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/broken-out/rock-handle-directory-overflows.patch

thanks,
-chris
