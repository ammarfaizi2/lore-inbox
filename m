Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbUCMVwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 16:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbUCMVwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 16:52:24 -0500
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:128 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S263196AbUCMVwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 16:52:11 -0500
Date: Sat, 13 Mar 2004 16:54:34 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Marek Szuba <scriptkiddie@wp.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4, or what I still don't quite like about the new stable
 branch
In-Reply-To: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
Message-ID: <Pine.LNX.4.58.0403131642270.4325@dust.p68.rivermarket.wintek.com>
References: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, Marek Szuba wrote:

[Snip]

> 4. Module autounloading. Is it actually possible? Will it be possible?
> If not, why? The old method of periodically invoking "modprobe -ras" via
> cron doesn't seem to accomplish anything and I really liked the idea of
> keeping only the required modules in memory at any given moment without
> having to log in as root to unload the unneeded ones - after all, if the
> autoloader can only add them what's the point of not going the
> monolithic way? The docs on the new approach towards modules are
> virtually nonexistent in the kernel source package and while I suppose I
> could simply write a script which would scan the list of
> currently-loaded modules for the unused ones and remove them one by one,
> but this approach feels terribly crude comparing with the elegance of
> the old solution. I use module-init-tools-3.0, a serious improvement
> over 0.9.15 if I may say so but, unless I'm thinking about it with
> completely wrong base assumptions, still far from perfect.

Safe module unloading is a very difficult problem.  So much so that
disallowing unloading modules completely has been discussed in the past.  
Digging around an lkml archive for more info on why module unloading is
inherently problematic, and not at all easy to do (well, not at all easy
to do well) is recommended.

-- 
Alex Goddard
agoddard at purdue dot edu
