Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271965AbTGRVHC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271880AbTGRVCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:02:04 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:30852 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S271821AbTGRU7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:59:39 -0400
Date: Sat, 19 Jul 2003 09:05:57 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Software suspend testing in 2.6.0-test1
In-reply-to: <20030718180449.GB195@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Peter Osterlund <petero2@telia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058562197.2141.21.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030718175045.GA195@elf.ucw.cz>
 <Pine.LNX.4.44.0307181101110.22018-100000@cherise>
 <20030718180449.GB195@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In 2.4, I ended up fusing the freezer and shrinking memory together. The
essence is:

freeze all other processes
while need to free memory
    unfreeze processes
    shrink memory until think we have enough
    freeze processes

Regards,

Nigel

On Sat, 2003-07-19 at 06:04, Pavel Machek wrote:
> Hi!
> 
> > > I wanted to avoid that: we do want user threads refrigerated at that
> > > point so that we know noone is allocating memory as we are trying to
> > > do memory shrink. I'd like to avoid having refrigerator run in two
> > > phases....
> > 
> > But we should be the only process running, and we can guarantee that by 
> > not sleeping and doing preempt_disable() when we begin. Especially 
> > if we start the refrigeration sequence after we shrink
> > memory. Right? 
> 
> If we refrigerate after we shrink, userspace can allocate everything
> just after shrink.
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

