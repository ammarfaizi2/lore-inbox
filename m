Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUCDXv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUCDXv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:51:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:59848 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261997AbUCDXvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:51:25 -0500
Subject: Re: problem with cache flush routine for G5?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <40479A50.9090605@nortelnetworks.com>
References: <40479A50.9090605@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1078444268.5698.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 10:51:08 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-05 at 08:06, Chris Friesen wrote:
> We're running into issues with the "flush_data_cache" routine on the G5.
> 
> For the G5, the L1 dcache is 32K and the L2 cache is 512K. At 128 
> bytes/cacheline, that's 256 and 4096 cachelines, respectively.
> 
> In the existing tree, NUM_CACHE_LINES is set to 128*8, or 1024.  Is this 
> an oversight or am I missing something?
> 
> Also, I'm curious why the dcbf instruction is not used for this.

First of all, why do you need to flush the cache at all ?

If you are talking about the cache flush in the 32 bits bootloaders,
then yes, this seem to be broken, you should ask Tom Rini who
maintain these things.

The kernel proper definitely doesn't contain such a routine.

Ben.


