Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUADDF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 22:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbUADDF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 22:05:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:55525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264933AbUADDFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 22:05:43 -0500
Date: Sat, 3 Jan 2004 19:05:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alex Buell <alex.buell@munted.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively
 enough  on low-memory PCs
Message-Id: <20040103190543.3b2d917f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401040014360.4975@slut.local.munted.org.uk>
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
	<20040103103023.77bf91b5.jlash@speakeasy.net>
	<20040103145557.369a12c4.akpm@osdl.org>
	<Pine.LNX.4.58.0401040014360.4975@slut.local.munted.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Buell <alex.buell@munted.org.uk> wrote:
>
> On Sat, 3 Jan 2004, Andrew Morton wrote:
> 
> > John Lash <jlash@speakeasy.net> wrote:
> > >
> > > As it stands, it will maintain as many unused entries as there are used entries.
> > >  If this low memory system las a large, stable, number of inuse dentry objects,
> > >  the unused entries will match it thereby holding double the memory and possibly
> > >  causing the problem you see.
> > 
> > Yup.   There is a fix in 2.6.1-rc1 for this.
> 
> Which change would that be? It would be nice to back-port that to 2.4.x if 
> that's possible?

It is not backportable.

You could try increasing `count' in shrink_dcache_memory() and
shrink_icache_memory().  Also you should be using 2.4.23 or later because
it does have improvements in the memory reclaim area.


