Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUHNKuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUHNKuL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 06:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUHNKuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 06:50:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:7944 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266386AbUHNKuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 06:50:00 -0400
Date: Sat, 14 Aug 2004 12:35:22 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040814103522.GA27399@alpha.home.local>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 03:41:58AM -0700, Linus Torvalds wrote:
> > I've just compiled and booted 2.6.8 on my dual athlon. Everything went
> > OK before I logged in as a non-root user whose home is mounted from
> > another linux box over NFSv3/UDP.
> 
> Damn. I think the stupid typo in fs/nfs/file.c from the fcntl f_op removal
> patch is the problem.

I confirm this. It's what I tried and this patch was enough to fix the
problem here, as I stated in a further mail. I first tested with the
complete patch that Jeff send, then with only this hunk and both work fine.

Cheers,
Willy

