Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVDMXmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVDMXmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVDMXmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:42:18 -0400
Received: from khc.piap.pl ([195.187.100.11]:7172 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261229AbVDMXmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:42:14 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Eger <eger@havoc.gtf.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
References: <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	<20050412040519.GA17917@havoc.gtf.org>
	<20050412081613.GA18545@pasky.ji.cz>
	<20050412204429.GA24910@havoc.gtf.org>
	<Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org>
	<20050412234005.GJ1521@opteron.random>
	<Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org>
	<20050413001408.GL1521@opteron.random>
	<Pine.LNX.4.58.0504121809380.4501@ppc970.osdl.org>
	<20050413204451.GP25554@waste.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 14 Apr 2005 01:42:11 +0200
In-Reply-To: <20050413204451.GP25554@waste.org> (Matt Mackall's message of
 "Wed, 13 Apr 2005 13:44:51 -0700")
Message-ID: <m3vf6q1bxo.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> Now if you can assume that blobs never change and are never deleted,
> you can simply append them all onto a log, and then index them with a
> separate file containing an htree of (sha1, offset, length) or the
> like.

That mean a problem with rsync, though.

BTW: I think the bandwidth increase compared to bkcvs isn't that obvious.
After a file is modified with git, it has to be transmitted (plus
small additional things.
If a file is modified with bkcvs, it has to be transmitted (the whole
RCS file) as well.

Only the initial rsync would be much smaller with bkcvs.
-- 
Krzysztof Halasa
