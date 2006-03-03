Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWCCOFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWCCOFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 09:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWCCOFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 09:05:20 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:4226 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750940AbWCCOFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 09:05:19 -0500
Date: Fri, 3 Mar 2006 09:04:59 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Alexander Mieland <dma147@linux-stats.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: how to find out which module was built by which .config variables?
In-Reply-To: <200603031439.24367.dma147@linux-stats.org>
Message-ID: <Pine.LNX.4.58.0603030902160.15978@gandalf.stny.rr.com>
References: <200603031420.46801.dma147@linux-stats.org>
 <Pine.LNX.4.61.0603031434520.2581@yvahk01.tjqt.qr> <200603031439.24367.dma147@linux-stats.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Mar 2006, Alexander Mieland wrote:

> Am Friday 03 March 2006 14:35 schrieben Sie:
> > >Hello,
> > >
> > >I need to create a database with configuration options (the ones
> > >in .config) and the resulting kernel modules.
> >
> > Let's pick 8139too.ko for example.
> > Find /usr/src/linux -name 8139too.ko
> > In that same directory, look at the Makefile:
> > obj-$(CONFIG_8139TOO) += 8139too.o
>
> Ahh, great, this helps much more!
> Thanks. ;)
>

I have a perl script that reads the current modules, Kconfigs and
makefiles that I use to trim the .config to a minimum.  I does do what you
ask.  Basically find the options that match the modules.

It's here:

http://www.kihontech.com/code/streamline_config.pl

-- Steve
