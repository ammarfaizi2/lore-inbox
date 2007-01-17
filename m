Return-Path: <linux-kernel-owner+w=401wt.eu-S932299AbXAQMBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbXAQMBR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 07:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbXAQMBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 07:01:17 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:64913 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbXAQMBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 07:01:16 -0500
Date: Wed, 17 Jan 2007 07:00:48 -0500
From: David Hollis <dhollis@davehollis.com>
Subject: Re: 2.6.20-rc4-mm1 USB (asix) problem
In-reply-to: <20070116225909.GA6932@pool-71-123-123-29.spfdma.east.verizon.net>
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Message-id: <1169035248.11226.11.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20070113203113.GB14587@pool-71-123-103-45.spfdma.east.verizon.net>
	<1168889276.19899.105.camel@dhollis-lnx.sunera.com>
	<20070115195024.GA8135@pool-71-123-103-45.spfdma.east.verizon.net>
	<1168893137.19899.109.camel@dhollis-lnx.sunera.com>
	<20070116225909.GA6932@pool-71-123-123-29.spfdma.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-16 at 17:59 -0500, Eric Buddington wrote:
> On Mon, Jan 15, 2007 at 08:32:17PM +0000, David Hollis wrote:
> > Interesting.  It would really be something if your devices happen to
> > work better with 0.  Wouldn't make much sense at all unfortunately.  If
> > 0 works, could you also try setting it to 2 or 3?  The PHY select value
> > is a bit field with the 0 bit being to select the onboard PHY, and 1 bit
> > being to 'auto-select' the PHY based on link status.  The data sheet
> > indicates that 3 should be the default, but all of the literature I have
> > seen from ASIX says to write a 1 to it.
> 
> My hardware is ver. B1.
> 
> 0, 2, and 3 all worked for me. 1, as before, does not.
> 

That's good to hear.  Some other patches have started floating around to
deal with these cases of internal vs. external PHY's and also seem to
work.

> 'rmmod asix' takes a really long time (45-80s) with any setting, and
> sometimes coincides with ksoftirqd pegging (99.9% CPU) for several
> seconds.

This I haven't seen before.  Does it occur even when the device is able
to work (using 0 or the like from above)?  This may be due to something
else in the USB subsystem or something.

-- 
David Hollis <dhollis@davehollis.com>

