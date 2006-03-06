Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752445AbWCFV7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbWCFV7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbWCFV7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:59:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27540 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752445AbWCFV7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:59:35 -0500
Date: Mon, 6 Mar 2006 22:59:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: jonathan@jonmasters.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] inotify hack for locate
Message-ID: <20060306215906.GB4836@elf.ucw.cz>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> <9a8748490603051342r64f1dd65qecf72a8016a0d520@mail.gmail.com> <35fb2e590603051350o27a00274r4566e65e3fb99721@mail.gmail.com> <440BFFAB.2040405@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440BFFAB.2040405@aitel.hist.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >That's not the point. It usually does. I'm interested to know if
> >anyone has written a daemon that can sit and just do this
> >synchronously on my desktop - then not only do I /not/ have to run
> >updatedb every day but I can also have a locate that is always up to
> >the minute.
> > 
> >
> I haven't heard about anyone doing this.  You could modify
> the VFS to notify you everytime a file is created, moved or deleted.
> That should give you what you want, but at the cost of delaying
> those operations.
> 
> Another option would be to make a filesystem that stores its
> directory structure (or a copy of it) in a single file, so that
> a locate-like program can do quick lookups of the always-correct
> data.

Better way is probably to create M-RECURSIVE-TIME field in inode --
similar to MTIME but counting modifications in directories. There are
many applications that would like to watch file modifications, and
some of them (like locate) are not running all the time.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
