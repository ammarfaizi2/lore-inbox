Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUFVJT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUFVJT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 05:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUFVJT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 05:19:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:59055 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261405AbUFVJTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 05:19:21 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Subject: Re: [PATCH 0/2] kbuild updates
Date: Tue, 22 Jun 2004 11:20:18 +0200
User-Agent: KMail/1.6.2
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620221824.GA10586@mars.ravnborg.org> <40D7C3D3.30DB5F72@users.sourceforge.net>
In-Reply-To: <40D7C3D3.30DB5F72@users.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406221120.18088.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 June 2004 07:29, Jari Ruusu wrote:
> Sam Ravnborg wrote:
> > On Mon, Jun 21, 2004 at 12:03:19AM +0200, Sam Ravnborg wrote:
> > > If I get just one good example I will go for the object directory, but
> > > what I have seen so far is whining - no examples.
> >
> > Now I recall why I did not like the object directory.
> > I will break all modules using the kbuild infrastructure!
>
> No it does not. If 'export KBUILD_OUTPUT=/foo' command is used before
> kernel is built, it is not any more difficult to compile external modules
> with that same env variable defined.

This clearly is not an option. We want the most trivial way of building 
external modules to continue working, no matter whether the kernel is using a 
separate output directory or not; with Sam's patch we get that:

	make -C /lib/modules/$(uname -r)/build M=$(pwd)

We also want to build modules for other configurations; this is as simple as 
passing another path in -C. For example, in the SUSE setup this would give 
you a module for an i386 bigsmp kernel:

	make -C /usr/scc/linux-obj/i386/bigsmp M=$(pwd)

The environment variable proposal is worthless: Where on earth should that 
environment variable come from?

> [cut the crap]
>
> In which case Andrew and Linus should consider revoking your kbuild
> maintainer status. I moved Andrew and Linus from CC list to TO list in hope
> to get this small question answered:
>
> Andrew, Linus,
> How about choosing someone else less destructive to maintain kbuild?

Jari, you have shown that you still didn't get it. Trying harder instead of 
badmouthing random people might help.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
