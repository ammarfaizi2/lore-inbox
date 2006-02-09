Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422808AbWBIF6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWBIF6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWBIF6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:58:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422808AbWBIF6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:58:04 -0500
Date: Wed, 8 Feb 2006 21:57:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: sam.robb@timesys.com, zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] kconfig: detect if -lintl is needed when linking
 conf,mconf
Message-Id: <20060208215733.0064e226.akpm@osdl.org>
In-Reply-To: <20060209054231.GB1615@quicksilver.road.mcmartin.ca>
References: <3D848382FB72E249812901444C6BDB1D0908A150@exchange.timesys.com>
	<20060209054231.GB1615@quicksilver.road.mcmartin.ca>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle McMartin <kyle@parisc-linux.org> wrote:
>
> On Mon, Jan 30, 2006 at 01:26:47PM -0500, Robb, Sam wrote:
> >   This patch attempts to correct the problem by detecting whether or not
> > NLS support requires linking with libintl.
> >
> 
> Sigh. Can everyone please stop assuming gcc can output to /dev/null? On 
> several platforms, ld tries to lseek in the output file, and fails if it 
> can't.

Ah.

> Is there any reason this problem can't be solved the same way it is
> for libcurses in menuconfig, by using gcc -print-filename? Or perhaps
> using tempfile?

Sam has plans to address this problem I guess we should drop that patch.

Linus, please nuke 5e375bc7d586e0df971734a5a5f1f080ffd89b68
