Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265845AbUFOTHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbUFOTHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFOTGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:06:37 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:25396 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265845AbUFOTFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:05:13 -0400
Date: Tue, 15 Jun 2004 21:14:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615191418.GD2310@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org> <20040615190951.C7666@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615190951.C7666@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:09:51PM +0100, Russell King wrote:
> > 
> > Compared to the original behaviour where the all: target picked the default
> > target for a given architecture, this patch adds the following:
> 
> This isn't the case on ARM.  I've always told people 'make zImage'
> or 'make Image'.  I've never told people to use just 'make' on its
> own - in fact, I've never used 'make' on its own with the kernel.

Why not?
Letting the build system select a default target is often a
better choice than some random choice by a developer.

> 
> > - One has to select the default kernel image only once
> >   when configuring the kernel.
> > - There exist a possibility to add more than half a line of text
> >   describing individual targets. All relevant information can be
> >   specified in the help section in the Kconfig file
> 
> You can't fit details for 500 platforms into half a line of text.
Not discussing different platforms, only discussing kernel targets.
For arm I see the following:
zImage, Image bootpImage uImage
And some test targets: zImg, Img, bp, i, zi

Not counting the test targets it is only 4 target of which 3 is
documented in help today.

> 
> > If we remove the current support for for example uboot we create an
> > additional step in between the make and copy image.
> 
> uboot support on ARM was only recently added, and only happened
> because I happened to misread the patch.  Had I been more on the
> ball, the support would NOT have been merged.  However, as it did
> get merged, I didn't want to create extra noise by taking it out.
> 
> Please don't take this as acceptance that throwing the uboot crap
> into the kernel for ARM was something I found agreeable.  I still
> find it distasteful that boot loaders have to define their own
> image formats and the kernel has to conform to the boot loader
> authors whims.

Maybe Wolgang can jump in here - I do not know why mkimage is needed.
But I do like to have it present for convinience.
It is btw called mkuboot.sh in scripts/ to better say what it does.

	Sam
