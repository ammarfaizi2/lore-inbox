Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTIDCvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264621AbTIDCvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:51:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:24707 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264606AbTIDCtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:49:15 -0400
Date: Wed, 3 Sep 2003 19:49:04 -0700
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030904024904.GI5227@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <20030904005822.GC5227@work.bitmover.com> <20030904011253.GA4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904011253.GA4306@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 06:12:53PM -0700, William Lee Irwin III wrote:
> On Wed, Sep 03, 2003 at 02:51:35PM -0700, William Lee Irwin III wrote:
> >> This is only truly feasible when the nodes are homogeneous. They will
> >> not be as there will be physical locality (esp. bits like device
> >> proximity) concerns. 
> 
> On Wed, Sep 03, 2003 at 05:58:22PM -0700, Larry McVoy wrote:
> > Huh?  The nodes are homogeneous.  Devices are either local or proxied.
> 
> Virtualized devices are backed by real devices at some level, so the
> distance from the node's physical location to the device's then matters.

Go read what I've written about this.  There is no sharing, devices are 
local or remote.  You share in the page cache only, if you want fast access
to a device you ask it to put the data in memory and you map it.  It's 
absolutely as fast as an SMP.  With no locking.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
