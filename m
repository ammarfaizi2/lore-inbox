Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUBYVDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUBYVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:03:05 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:898 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S261486AbUBYU6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:58:12 -0500
Date: Wed, 25 Feb 2004 13:58:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Message-ID: <20040225205811.GC1052@smtp.west.cox.net>
References: <20040218225010.GH321@elf.ucw.cz> <20040224232703.GC9209@elf.ucw.cz> <20040224233809.GK1052@smtp.west.cox.net> <200402251249.28519.amitkale@emsyssoft.com> <20040225155823.GP1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225155823.GP1052@smtp.west.cox.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 08:58:23AM -0700, Tom Rini wrote:
> On Wed, Feb 25, 2004 at 12:49:28PM +0530, Amit S. Kale wrote:
> > On Wednesday 25 Feb 2004 5:08 am, Tom Rini wrote:
[snip]
> > > - Issues w/ handling 'D' and 'k' packets cleaner (and I think there was
> > >   a correctness fix in there, too, but it was a while ago).
> > 
> > Is this wrt kgdb_killed.., kgdb_might..., remove breakpoints?
> 
> This will be part of the patch I hope to post today:
> http://ppc.bkbits.net:8080/linux-2.6-kgdb/patch@1.1500.2.19?nav=index.html|ChangeSet@-4w|cset@1.1500.2.19

After looking at what's in your stub now, and at the gdb source code,
I've filed a gdb bug (remote/1571) as the protocol docs and code don't
agree on what's expected from a detach.  The docs say that gdb doesn't
look for a reply (so we wouldn't/shouldn't make one) but the code does,
and will print out an error code, if one happens.  So I'm going to leave
this bit of code alone for now.

-- 
Tom Rini
http://gate.crashing.org/~trini/
