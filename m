Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUFOPik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUFOPik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbUFOPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:38:40 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:21148 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S265508AbUFOPii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:38:38 -0400
Date: Tue, 15 Jun 2004 08:38:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040615153836.GC11113@smtp.west.cox.net>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org> <20040614220549.L14403@flint.arm.linux.org.uk> <20040615044020.GC16664@mars.ravnborg.org> <20040615093807.A1164@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615093807.A1164@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:38:07AM +0100, Russell King wrote:

> On Tue, Jun 15, 2004 at 06:40:20AM +0200, Sam Ravnborg wrote:
> > The advantage is that you now have a good place to document all of
> > these formats - your Kconfig file.
> > And you select the default target for the user.
> > 
> > How did I know uboot required mkimage before - now it can be documented
> > in Kconfig.
> > So the situation above is actually a good example why it is whortwhile
> > to move the kernel image selection to the config stage.
> > 
> > If they all should be part of the kernel build is another discussion.
> 
> You missed my point.
> 
> How does a user know which format they need to build the kernel with
> _if_ the kernel configuration contains all the formats and the boot
> loader documentation fails to mention it?

I think what Sam was saying is that you document what boards are
supported by what firmwares, in the Kconfig.  But what I don't think Sam
saw would be just how ugly that's going to look (and become another
point where every new board port touches, and possibly conflicts with
another new board port).

> As I tried to point out, boot loaders on ARM historically seem to have
> been "My First ARM Project" type things so there's lots of them out
> there - there aren't 3 or so found on x86.

And that's another good reason not to.

-- 
Tom Rini
http://gate.crashing.org/~trini/
