Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWGLBhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWGLBhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 21:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWGLBhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 21:37:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751198AbWGLBhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 21:37:06 -0400
Date: Tue, 11 Jul 2006 18:36:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: pavel@ucw.cz, roubert@df.lth.se, stern@rowland.harvard.edu,
       dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
Message-Id: <20060711183647.5c5c0204.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607120248050.12900@scrub.home>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
	<20060710094414.GD1640@igloo.df.lth.se>
	<Pine.LNX.4.64.0607102356460.17704@scrub.home>
	<20060711124105.GA2474@elf.ucw.cz>
	<Pine.LNX.4.64.0607120016490.12900@scrub.home>
	<20060711224225.GC1732@elf.ucw.cz>
	<Pine.LNX.4.64.0607120132440.12900@scrub.home>
	<20060711165003.25265bb7.akpm@osdl.org>
	<Pine.LNX.4.64.0607120213060.12900@scrub.home>
	<20060711173735.43e9af94.akpm@osdl.org>
	<Pine.LNX.4.64.0607120248050.12900@scrub.home>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 02:52:24 +0200 (CEST)
Roman Zippel <zippel@linux-m68k.org> wrote:

> > IOW, someone needs to find a way to make the new code work like the old
> > code without re-breaking Pavel's keyboard.  But the bitchin-to-patchin
> > ratio here seems to exclude that outcome.
> 
> Traditionally that responsibility is in the hands of whose who break it in 
> the first place

If that person cannot reproduce the problem but another skilled kernel
developer can then it would make sense for he-who-can-reproduce-it to do
some work.

Still, I doubt if that's the case here.


Is the below correct?

Old behaviour:

	a) press alt
	b) press sysrq
	c) release alt
	d) press T
	e) release T
	f) release sysrq

New behaviour:

	a) press alt
	b) press sysrq
	c) release sysrq
	d) press T
	e) release T
	f) release alt

If so, then the old behaviour was weird and the new behaviour is sensible. 
What, actually, is the problem?

