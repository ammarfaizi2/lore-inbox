Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTESWR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTESWR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:17:28 -0400
Received: from zok.SGI.COM ([204.94.215.101]:4022 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262737AbTESWR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:17:26 -0400
Date: Mon, 19 May 2003 15:29:37 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] pull $CROSS_COMPILE from env. if present
Message-ID: <20030519222937.GA20366@sgi.com>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030519195333.GC18426@sgi.com> <20030519215917.GA1281@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519215917.GA1281@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 11:59:17PM +0200, Sam Ravnborg wrote:
> On Mon, May 19, 2003 at 12:53:33PM -0700, Jesse Barnes wrote:
> > Simple patch to pull CROSS_COMPILE from the environment if it's
> > present, which makes it easier to compile the kernel with different
> > compiler versions and such.
> 
> I like it, but...
> 
> If we do it for CROSS_COMPILE we should do it for ARCH as well.
> Something like
> ifeq ($(origin ARCH), undefined)
> ARCH := $(SUBARCH)
> endif
> 
> And then group ARCH and CROSS_COMPILE togeher in the Makefile, and
> provide a few meaningful comments.
> I will test it tomorrow if you do not beat me in it.

That's a good idea too, I used that awhile back when all my ia64
compiles were x86->ia64 cross-compiles...

Thanks,
Jesse
