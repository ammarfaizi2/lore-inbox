Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVD1VxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVD1VxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVD1VxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 17:53:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48594 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262272AbVD1VxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 17:53:13 -0400
Date: Thu, 28 Apr 2005 22:53:28 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>
Subject: Re: [UML] Compile error when building with seperate source and object directories
Message-ID: <20050428215328.GC13052@parcelfarce.linux.theplanet.co.uk>
References: <1114570958.5983.50.camel@mythical> <20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk> <20050428202647.GA25451@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428202647.GA25451@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 04:26:47PM -0400, Jeff Dike wrote:
> > That's because that stuff is not merged yet.  Speaking of which, where does
> > the current UML tree live and who should that series be Cc'ed to?
> 
> My patchset lives at http://user-mode-linux.sf.net/patches.html, and things
> like this should be CC-ed to me.
> 
> > I've got a decent split-up and IMO that should be mergable.  Patches are
> > on ftp.linux.org.uk/pub/people/viro/UM*; summary in the end of mail.
> > That's a sanitized and split version of old UML-kbuild patch.
> 
> Thanks, merged into my tree.  It'll be visible at the above URL next time
> I push the site out, and I'll merge this and a bunch of other stuff to
> Linus and Andrew shortly.

OK...  Out of old UML-kbuild only the chunk in ptrace.c is not covered
by that (note that e.g. top-level Makefile is not modified at all in
the new version).  arch/um/kernel/ptrace.c is a separate story - we
need per-arch helper there.
