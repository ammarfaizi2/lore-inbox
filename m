Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUBUAWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbUBUAWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:22:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:59819 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261445AbUBUAWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:22:33 -0500
Subject: Re: fb_console_init fix.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040220235410.GB17771@kroah.com>
References: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org>
	 <1077317816.9623.20.camel@gaston>  <20040220235410.GB17771@kroah.com>
Content-Type: text/plain
Message-Id: <1077322606.10864.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 11:16:47 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-21 at 10:54, Greg KH wrote:

> What's wrong with the current range of init call sections?  Can't that
> work for fb devices today?

We can probably work with those. I just don't fell like changing that
part of fbdev right now. More important fixes to get in first (and
there's a shitload of crap related to calling the setup functions in
fbdev's that need fixing too if/when we change that init stuff).

My idea about adding an initcall level was for pure convenience, but
may be wrong. It's handy to have the console inited before the rest
that's all ;) We can leave that out for now, maybe just linking
drivers/video before the rest is enough to get that anyway.

Ben.


