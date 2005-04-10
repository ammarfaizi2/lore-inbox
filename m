Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVDJQx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVDJQx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVDJQx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 12:53:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:13019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261520AbVDJQxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 12:53:22 -0400
Date: Sun, 10 Apr 2005 09:55:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: [ANNOUNCE] git-pasky-0.1
In-Reply-To: <20050410162723.GC26537@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504100939060.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz>
 <20050410162723.GC26537@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Apr 2005, Petr Baudis wrote:
> 
> Where did you get the sparse git database from, Linus? (BTW, it
> would be nice to get sparse.git with the directories as separate.)

When we were trying to figure out how to avert the BK disaster, and one of
Tridges concerns (and, in my opinion, the only really valid one) was that
you couldn't get the BK data in some SCM-independent way.

So I wrote some very preliminary scripts (on top of BK itself) to extract
the data, to show that BK could generate a SCM-neutral file format (a very
stupid one and horribly useless for anything but interoperability, but
still...). I was hoping that that would convince Tridge that trying to
muck around with the internal BK file format was not worth it, and avert
the BK trainwreck.

Larry was ok with the idea to make my export format actually be natively
supported by BK (ie the same way you have "bk export -tpatch"), but Tridge
wanted to instead get at the native data and be difficult about it. As a
result, I can now not only use BK any more, but we also don't have a nice
export format from BK.

Yeah, I'm a bit bitter about it. 

Anyway, the sparse data came out of my hack. It's very inefficient, and I
estimated that doing the same for the kernel would have taken ten solid
days of conversion, mainly because my hack was really just that: a quick
hack to show that BK could do it. Larry could have done it a lot better.

I'll re-generate the sparse git-database at some point (and I'll probably
do so from the old GIT database itself, rather than re-generating it from
my old BK data).

		Linus
