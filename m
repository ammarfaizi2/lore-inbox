Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbUCEPPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 10:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbUCEPPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 10:15:49 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:56228 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262623AbUCEPPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 10:15:47 -0500
Date: Fri, 5 Mar 2004 08:15:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: problem with cache flush routine for G5?
Message-ID: <20040305151542.GL26065@smtp.west.cox.net>
References: <40479A50.9090605@nortelnetworks.com> <1078444268.5698.27.camel@gaston> <20040304235754.GK26065@smtp.west.cox.net> <1078445065.5703.37.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078445065.5703.37.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 11:04:26AM +1100, Benjamin Herrenschmidt wrote:
> 
> > 
> > ... unless this is a 'G5' that's not in a pmac, it's not my code, and
> > the openfirmware bootloaders don't, IIRC, do any cache stuff.
> 
> Heh, well, they should. You need to flush the dcache & invalidate the
> icache over the kernel image after decompressing it. It's just that
> those routines are totally broken as far as I can see, but I don't
> think the pmac bootloaders will use them, they probably use a
> different implementation that works.

I take that back, the openfirmware stuff does have it's own flush_cache
(of course).

> Note that whatever machines are using those routines will probably
> have trouble too anyway

I hate to disappoint Ben, but nothing is having any trouble with that
code, even if it's not exactly right. :)

Regardless, I'll go and make all of the boot code code the same,
working, cache flushing code.  Thanks for finding that, Chris.

-- 
Tom Rini
http://gate.crashing.org/~trini/
