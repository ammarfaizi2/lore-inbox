Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVIJUqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVIJUqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVIJUqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:46:42 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:42089 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932293AbVIJUqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:46:42 -0400
Date: Sat, 10 Sep 2005 22:48:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/12] kbuild: mips use generic asm-offsets.h support
Message-ID: <20050910204817.GH29334@mars.ravnborg.org>
References: <11263057061465-git-send-email-sam@ravnborg.org> <Pine.LNX.4.61.0509101949240.3743@scrub.home> <20050910193033.GA31516@mars.ravnborg.org> <Pine.LNX.4.61.0509102217270.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509102217270.3743@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.

> > kbuild looks for the Kbuild file before it looks for Makefile.
> > In a desire to move some of the functionality away form the top-level
> > Makefile and in to a kbuild file this is needed.
> 
> Why don't you put it into scripts/Makefile...?
Because it does not build a build-support program.
That would be the last place where one would look for
rules to build asm-offsets.h for example.
When the functionalty to start the recursive build of all kernel
directories are moved to top-level Kbuild the location in the
top-level directory makes even more sense.

Same goes when the post processing steps are moved to the top-level
Kbuild file. Here we again will benefit form having the full kbuild
funtionality available.

> > The Kbuild file in the top-level directory will take
> > over more and more functionality from the top-level
> > Makefile to the extent that I hope to end up with two
> > readable files.
> 
> If the top-level Makefile gets to big, we can move things into scripts/,
> that's really no reason to start using Kbuild, in the end it's still a 
> Makefile and I'd prefer to call it like that.
A makefile is a file that does something intelligent when used as input
to make. It is long time since this property did not hold for the
kernel.
The Kbuild name is a much more natural name in the respect that it
tells you this file contain kbuild info. So one know when browsing
a directory structure that a Kbuild file is input to kbuild, and follow
a much more strict syntax than ordinary Makefiles.

	Sam
