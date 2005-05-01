Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVEALUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVEALUe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 07:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEALUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 07:20:34 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:57692 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261592AbVEALU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 07:20:27 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [UML] Compile error when building with seperate source and object directories
Date: Sun, 1 May 2005 13:30:57 +0200
User-Agent: KMail/1.8
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>
References: <1114570958.5983.50.camel@mythical> <20050428202647.GA25451@ccure.user-mode-linux.org> <20050428215328.GC13052@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050428215328.GC13052@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505011330.58205.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 23:53, Al Viro wrote:
> On Thu, Apr 28, 2005 at 04:26:47PM -0400, Jeff Dike wrote:
> > > That's because that stuff is not merged yet.  Speaking of which, where
> > > does the current UML tree live and who should that series be Cc'ed to?
> >
> > My patchset lives at http://user-mode-linux.sf.net/patches.html, and
> > things like this should be CC-ed to me.
> >
> > > I've got a decent split-up and IMO that should be mergable.  Patches
> > > are on ftp.linux.org.uk/pub/people/viro/UM*; summary in the end of
> > > mail. That's a sanitized and split version of old UML-kbuild patch.
> >
> > Thanks, merged into my tree.  It'll be visible at the above URL next time
> > I push the site out, and I'll merge this and a bunch of other stuff to
> > Linus and Andrew shortly.
>
> OK...  Out of old UML-kbuild only the chunk in ptrace.c is not covered
> by that (note that e.g. top-level Makefile is not modified at all in
> the new version).  arch/um/kernel/ptrace.c is a separate story - we
> need per-arch helper there.
For now I've added an #ifdef to re-include that code for x86, while excluding 
it for x86_64. Also, is that up-to-date wrt. 2.6.12-rc3? I had merged part of 
your code (at least the most urgent ones).

Also, I'm thinking to a generic support for those conditional double 
includes... I'll post it when it'll be ready.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

