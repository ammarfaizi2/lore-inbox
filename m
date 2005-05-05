Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVEEVTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVEEVTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 17:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEEVTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 17:19:49 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39479 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261757AbVEEVTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 17:19:47 -0400
Date: Thu, 5 May 2005 23:20:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Roskin <proski@gnu.org>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Saving ARCH and CROSS_COMPILE in generated Makefile
Message-ID: <20050505212003.GA16877@mars.ravnborg.org>
References: <1115248267.12758.21.camel@dv.roinet.com> <20050504232338.GF18977@parcelfarce.linux.theplanet.co.uk> <1115263105.17646.1.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115263105.17646.1.camel@dv.roinet.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > In any case, there's no reason to mess with that at all.  This stuff is
> > trivally dealt with by a wrapper script that takes target name as its
> > first argument (the rest is passed to make unchanged) and figures out
> > ARCH, CROSS_COMPILE, SUBARCH and build directory by it.  End of story.
> 
> I'm using such script now.  It's called kmake.

Use a Makefile called either makefile or GNUMakefile to call make with
correct arguments. No kmake script required.
And no difference in behaviour using O= or not.
You could teach kmake to create such a file if not present.


> I keep forgetting to run
> kmake instead of make, so it's an annoyance for me (usually it end up
> with a full screen of error messages, but I'm afraid I could get a mix
> of object files for different architectures in some cases).

Nope. .o files are rebuild if commandline changes. This works well.
This works so well that when you change name of gcc you have to rebuild
the kernel - no matter the arguments used.
It amy be a shift from gcc 2.96 to gcc 4.0.

	Sam
