Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVIJVJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVIJVJt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVIJVJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:09:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59594 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932309AbVIJVJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:09:48 -0400
Date: Sat, 10 Sep 2005 23:09:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/12] kbuild: mips use generic asm-offsets.h support
In-Reply-To: <20050910204817.GH29334@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0509102303080.3728@scrub.home>
References: <11263057061465-git-send-email-sam@ravnborg.org>
 <Pine.LNX.4.61.0509101949240.3743@scrub.home> <20050910193033.GA31516@mars.ravnborg.org>
 <Pine.LNX.4.61.0509102217270.3743@scrub.home> <20050910204817.GH29334@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Sep 2005, Sam Ravnborg wrote:

> > Why don't you put it into scripts/Makefile...?
> Because it does not build a build-support program.
> That would be the last place where one would look for
> rules to build asm-offsets.h for example.

Weird, why are the rules to build *.o files in scripts/Makefile.build?

> Same goes when the post processing steps are moved to the top-level
> Kbuild file. Here we again will benefit form having the full kbuild
> funtionality available.

So why is this benefit only available via Kbuild?
If the toplevel Makefile is to crowded, why don't you move things into 
scripts/?

> > If the top-level Makefile gets to big, we can move things into scripts/,
> > that's really no reason to start using Kbuild, in the end it's still a 
> > Makefile and I'd prefer to call it like that.
> A makefile is a file that does something intelligent when used as input
> to make. It is long time since this property did not hold for the
> kernel.
> The Kbuild name is a much more natural name in the respect that it
> tells you this file contain kbuild info. So one know when browsing
> a directory structure that a Kbuild file is input to kbuild, and follow
> a much more strict syntax than ordinary Makefiles.

If we continue in this direction, it would be even more natural to merge 
the Makefile with Kconfig, so I don't see the point in introducing Kbuild 
in first place, if we later remove it again anyway.

bye, Roman
