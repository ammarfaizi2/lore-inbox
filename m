Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265537AbUFTVem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbUFTVem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUFTVem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:34:42 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:56388 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265537AbUFTVe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:34:27 -0400
Date: Sun, 20 Jun 2004 23:45:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 2/2] kbuild: Improved external module support
Message-ID: <20040620214543.GA10332@mars.ravnborg.org>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruen@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620212353.GD10189@mars.ravnborg.org> <1087766729.2805.15.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087766729.2805.15.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 11:25:29PM +0200, Arjan van de Ven wrote:
> 
> > #   3) The build symlink now points to the output of the kernel
> > #      compile.
> > #      - When a kernel is compiled with output and source
> > #        mixed, the build and source symlinks will point
> > #        to the same directory. In this case there is
> > #        no change in behaviour.
> 
> > #   It is recommended that distributions pick up this
> > #   method, and especially start shipping kernel output and
> > #   source separately.
> > #   
> 
> I don't see the point of this; module builds don't use the output of the
> kernel compile but the SOURCE, eg the headers and Makefiles.
When building modules they use _both_ the source and partly the output.
The output needed is what is required for kbuild to work, and optionally
Module.symvers for symbol versions.

> I don't see a reason for this change; at least what I ship right now for
> the Fedora Core 2 kernel seems to work for all modules with sane
> makefiles so far....

Did you put the output of the kernel compile in a separate output directory,
reusing the same src for several configurations?
If not you do not need the change, and thus do not get any benefit. On the
other hand everything should work as-is for you.

	Sam
