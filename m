Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbTCIUCO>; Sun, 9 Mar 2003 15:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262592AbTCIUCO>; Sun, 9 Mar 2003 15:02:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14608 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262590AbTCIUCN>; Sun, 9 Mar 2003 15:02:13 -0500
Date: Sun, 9 Mar 2003 21:12:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030309201250.GC3618@atrey.karlin.mff.cuni.cz>
References: <20030305180222.GA2781@zaurus.ucw.cz> <Pine.LNX.4.33.0303070950030.991-100000@localhost.localdomain> <20030307202759.GA2447@elf.ucw.cz> <1047238788.12206.143.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047238788.12206.143.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > - It's dependent on the same exact kernel being loaded.
> > >
> > > It should only be dependent on the binary format of the written metadata.
> > 
> > ...which leads to simpler design and few megabytes less transfered to
> > / from disk. I do not think there's easy way to do it with different
> > kernels. State of devices before switching to new kernel is important...
> 
> I don't think so.
> 
> IMHO, the "old" kernel (used for loading the suspend image) should
> quiesce devices in a pretty "normal" way in the exact same way
> kexec does (and using the same code path/driver notifiers). I see
> no reason why there should be any kind of dependency between the
> "loader" kernel and the "loaded" kernel in this regard.

But if you add support for quiescing matrox in 2.6.5, you will not be
able to resume 2.6.5 from 2.6.4 kernel. And as bugs are going to be in
that area for a while I'd prefer people to suspend and resume with
same kernel.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
