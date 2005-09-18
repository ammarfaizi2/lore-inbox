Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVIRH33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVIRH33 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 03:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVIRH33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 03:29:29 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:2928 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751315AbVIRH32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 03:29:28 -0400
Date: Sun, 18 Sep 2005 09:30:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Fouts <Martin.Fouts@palmsource.com>
Cc: jesper.juhl@gmail.com, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: Why don't we separate menuconfig from the kernel?
Message-ID: <20050918073016.GB11257@mars.ravnborg.org>
References: <DE88BDF02F4319469812588C7950A97E93121E@ussunex1.palmsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE88BDF02F4319469812588C7950A97E93121E@ussunex1.palmsource.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 06:53:55PM -0700, Martin Fouts wrote:
> I don't have a patch yet, but I've just spent a bit of time looking at
> how kbuild works, and I believe there is a fairly straightforward way to
> keep kbuild in the kernel tree but make it easy to split it out so that
> someone could use it as a separate tool.
> 
> If this idea, appropriately modified, makes sense, I'll spend a bit of
> time to do a patch and set it up.
> 
> The basic idea is that kbuild stays in the kernel source tree, but a
> simple script is used to grab a copy of it out of the tree.  That copy
> is maintained as a separate "build/configuration" package, and the
> maintainer (yes, I'm volunteering) would keep the two versions in (near)
> sync.
> 
> After a quick glance, it looks like one would want to copy
> 
> Documentation/kbuild/*
> Scripts/kconfig/*
> Makefile
> 
> To this new copy.  The only real work to get started, it appears, and
> the reason why I'd rather have a discussion before I start, would be to
> split the toplevel Makefile up a bit, so that the 'pure kbuild' bits
> were moved into an include file. It's really that include file, not the
> toplevel Makefile that would need to be copied.
> 
> I suggest doing this because most of the make-related knowledge about
> kbuild itself is in that Makefile, but non-kernel users would not want
> the kernel specific targets.
> 
> I know of two other packages (busybox and ptxdist) that use kconfig now,
> and have been contemplating it for some of my projects, as well, so I'm
> interested enough to take the project on.
I'm a bit confused.
Do you want to take a copy of kbuild or kconfig?

kbuild is much more intiminate than kconfig althougth the latter has a
few kernel only issues too.

	Sam
