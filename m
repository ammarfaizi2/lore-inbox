Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbUCBWpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUCBWnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:43:42 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:20689 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262278AbUCBWnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:43:03 -0500
Date: Tue, 2 Mar 2004 15:43:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb: fix kgdbeth compilation and make it init late enough
Message-ID: <20040302224301.GK20227@smtp.west.cox.net>
References: <20040302112500.GA485@elf.ucw.cz> <20040302153250.GE16434@smtp.west.cox.net> <20040302222827.GD1225@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302222827.GD1225@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 11:28:27PM +0100, Pavel Machek wrote:

> Hi!
> 
> > > CONFIG_NO_KGDB_CPUS can not be found anywhere in the patches => its
> > > probably not needd any more.
> > 
> > I don't know if we can do that.  There's some funky locking stuff done
> > on SMP, which for some reason can't be done to NR_CPUS (or, no one has
> > tried doing that).
> 
> There was no CONFIG_NO_KGDB_CPUS anywhere else in the CVS, that means
> that test could not have been right.

That doesn't mean the right answer is to remove it.  However, after
talking with George (who might speak up now anyhow) for 2.6 we can just
do the SMP locking stuff at NR_CPUS, since that's configurable.

-- 
Tom Rini
http://gate.crashing.org/~trini/
