Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbUADHXT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 02:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUADHXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 02:23:19 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:64689 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264418AbUADHXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 02:23:17 -0500
Date: Sat, 3 Jan 2004 23:23:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alex Buell <alex.buell@munted.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively enough  on low-memory PCs
Message-ID: <20040104072312.GM1882@matchmail.com>
Mail-Followup-To: Alex Buell <alex.buell@munted.org.uk>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk> <20040103103023.77bf91b5.jlash@speakeasy.net> <20040103145557.369a12c4.akpm@osdl.org> <Pine.LNX.4.58.0401040014360.4975@slut.local.munted.org.uk> <20040103190543.3b2d917f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040103190543.3b2d917f.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 07:05:43PM -0800, Andrew Morton wrote:
> Alex Buell <alex.buell@munted.org.uk> wrote:
> >
> > On Sat, 3 Jan 2004, Andrew Morton wrote:
> > 
> > > John Lash <jlash@speakeasy.net> wrote:
> > > >
> > > > As it stands, it will maintain as many unused entries as there are used entries.
> > > >  If this low memory system las a large, stable, number of inuse dentry objects,
> > > >  the unused entries will match it thereby holding double the memory and possibly
> > > >  causing the problem you see.
> > > 
> > > Yup.   There is a fix in 2.6.1-rc1 for this.
> > 
> > Which change would that be? It would be nice to back-port that to 2.4.x if 
> > that's possible?
> 
> It is not backportable.
> 
> You could try increasing `count' in shrink_dcache_memory() and
> shrink_icache_memory().  Also you should be using 2.4.23 or later because
> it does have improvements in the memory reclaim area.

Also, if there are any improvements considered for the 2.4 VM, it should be
on top of the -aa series.  That's where the latest updates are, and it
doesn't make sence to work from a base that already has seperate
improvements available.
