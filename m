Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUFUWw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUFUWw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266506AbUFUWw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:52:29 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:10052 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266505AbUFUWvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:51:36 -0400
Date: Tue, 22 Jun 2004 01:03:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040621230321.GI2903@mars.ravnborg.org>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20040620211905.GA10189@mars.ravnborg.org> <200406210151.43325.agruen@suse.de> <20040621223108.GC2903@mars.ravnborg.org> <200406220050.09791.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406220050.09791.agruen@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 12:50:09AM +0200, Andreas Gruenbacher wrote:
> On Tuesday 22 June 2004 00:31, Sam Ravnborg wrote:
> > But Martin has a point here.
> 
> Yes.
> 
> > Other modules uses the grep method - which will fail when the kernel
> > is build with separate output and source directories.
> 
> Is there anything fundamentally wrong with invoking the test script from 
> within the module makefile, when really necessary? This doesn't work very 
> well if you need the test results outside of the module build.
> 
> 	----- Makefile -----
> 	test_result := $(shell ...)
> 	ifneq ($(test_result),)
> 	EXTRA_CFLAGS := -DSOMETHING
> 	endif
> 	...
> 	-------- 8< --------

I like keeping the kbuild makefile clean as such - but otherwise not.
One has to secure that right CFLAGS etc is used though.

Also when make -j N is used one has to be very carefully with prerequisites - as always.

	Sam
