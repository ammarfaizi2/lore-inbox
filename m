Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTJTPaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTJTPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:30:24 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:12161 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262609AbTJTPaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:30:22 -0400
Date: Mon, 20 Oct 2003 08:30:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031020153020.GA6062@ip68-0-152-218.tc.ph.cox.net>
References: <20031014232511.GA17741@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0310201655210.18000-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310201655210.18000-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 04:55:39PM +0300, Meelis Roos wrote:
> > Can you apply the following patch (2.6)?  I'm expecting it to print out that
> > it hard-codes to 32mb.
> 
> > +		puts("Hard-coded\n");
> 
> Yes, hard-coded.

Okay, thanks.  I now know what the problem is.  We no longer probe OF to
get the memory size.  What I'm going to do is to take one of the patches
that has existed for a while now to put back the code needed so that we
can still talk with OF, and we'll add in a test for that as well.  I
hope to have time this week to do it.

Just curious, what bridge is in this machine (an output of lspci would
do fine, too).  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
