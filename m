Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVLLTOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVLLTOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 14:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVLLTOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 14:14:23 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:25661 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932160AbVLLTOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 14:14:22 -0500
Date: Mon, 12 Dec 2005 20:14:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Petr Baudis <pasky@suse.cz>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] Link lxdialog with mconf directly
Message-ID: <20051212191422.GB7694@mars.ravnborg.org>
References: <20051212004159.31263.89669.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212004159.31263.89669.stgit@machine.or.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 01:41:59AM +0100, Petr Baudis wrote:
>   The following series revives one three years old patch, turning lxdialog
> to a library and linking it directly to mconf, making menuconfig nicer and
> things in general quite simpler and cleaner.
> 
>   The first two patches make slight adjustements to kbuild in order to make
> liblxdialog possible. The third patch does the libification itself and
> appropriate modifications to mconf.c.

Why not just copy over relevant files to scripts/kconfig?
Then no playing tricks with libaries etc. is needed, and everythings
just works.

It is only 8 files and prefixing them with lx* would make them
stand out compared to the rest. It is not like there is any user planned
for the lxdialog functionality in the kernel, and kconfig users outside
the kernel I beleive copy lxdialog with rest of kconfig files.

Btw. the work you are doing are clashing with a general cleanup effort
of lxdialog I have in -mm at the moment.
I received only very limited feedback = looks ok.
Integrating principles from your old patch was on my TODO list.

I have something in the works that uses linked list instead of a
preallocated array, to keep the dynamic behaviour. I will probarly make
a version with the linked list approach but otherwise use your changes
to mconf.c. But it will take a few days until I get to it.

	Sam
