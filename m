Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVDMOr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVDMOr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVDMOr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:47:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10454 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261356AbVDMOrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:47:46 -0400
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Baudis <pasky@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0504130732230.4501@ppc970.osdl.org>
References: <20050409200709.GC3451@pasky.ji.cz>
	 <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>
	 <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz>
	 <1113311256.20848.47.camel@hades.cambridge.redhat.com>
	 <20050413094705.B1798@flint.arm.linux.org.uk>
	 <20050413085954.GA13251@pasky.ji.cz>
	 <1113384304.12012.166.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504130732230.4501@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 15:47:41 +0100
Message-Id: <1113403661.20848.144.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 07:38 -0700, Linus Torvalds wrote:
> David, we already can. The objects are _designed_ to be shared.
> 
> However, that is the ".git/objects" subdirectory. Not the per-view stuff. 
> For each _view_ you do need to have view-specific data, and the view index 
> very much is that. That's ".git/index". 

Yep, it takes very little to achieve that -- to allow multiple checked-
out trees from a single object database. Petr's already outlined what it
takes.

> In other words, that index file simply _cannot_ be shared. Don't even 
> think about it. Only madness will ensue.

If I use git in my home directory I cannot _help_ but share it.
Sometimes I'm using it from a BE box, sometimes from a LE box. Should I
really be forced to use separate checkouts for each type of machine?
It's bad enough having to do that for ~/bin :)

Seriously, it shouldn't have a significantly detrimental effect on the
performance if we just use explicitly sized types and fixed byte-order.
It's just not worth the pain of being gratuitously non-portable.

-- 
dwmw2

