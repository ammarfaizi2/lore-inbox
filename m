Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUCDX55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUCDX55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:57:57 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:34041 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262014AbUCDX5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:57:55 -0500
Date: Thu, 4 Mar 2004 16:57:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: problem with cache flush routine for G5?
Message-ID: <20040304235754.GK26065@smtp.west.cox.net>
References: <40479A50.9090605@nortelnetworks.com> <1078444268.5698.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078444268.5698.27.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 10:51:08AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2004-03-05 at 08:06, Chris Friesen wrote:
> > We're running into issues with the "flush_data_cache" routine on the G5.
> > 
> > For the G5, the L1 dcache is 32K and the L2 cache is 512K. At 128 
> > bytes/cacheline, that's 256 and 4096 cachelines, respectively.
> > 
> > In the existing tree, NUM_CACHE_LINES is set to 128*8, or 1024.  Is this 
> > an oversight or am I missing something?
> > 
> > Also, I'm curious why the dcbf instruction is not used for this.
> 
> First of all, why do you need to flush the cache at all ?
> 
> If you are talking about the cache flush in the 32 bits bootloaders,
> then yes, this seem to be broken, you should ask Tom Rini who
> maintain these things.

... unless this is a 'G5' that's not in a pmac, it's not my code, and
the openfirmware bootloaders don't, IIRC, do any cache stuff.

-- 
Tom Rini
http://gate.crashing.org/~trini/
