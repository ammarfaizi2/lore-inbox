Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTFTRZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTFTRZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:25:08 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:46072 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262687AbTFTRZE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 13:25:04 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Watson, Craig" <craig.watson@ngc.com>, "'Larry McVoy'" <lm@bitmover.com>
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Date: Fri, 20 Jun 2003 12:38:34 -0500
X-Mailer: KMail [version 1.2]
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Werner Almesberger <wa@almesberger.net>, miquels@cistron-office.nl,
       linux-kernel@vger.kernel.org
References: <94D43CABC1C4FA43B0FD9B52F70565A12D1CC6@xcgfl021.northgrum.com>
In-Reply-To: <94D43CABC1C4FA43B0FD9B52F70565A12D1CC6@xcgfl021.northgrum.com>
MIME-Version: 1.0
Message-Id: <03062012383404.27684@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 June 2003 12:12, Watson, Craig wrote:
[snip]
> However, I think we are seeing some innovation in the work Greg
> Kroah-Hartman, Alan Stern, Patrick Mochel, Iñaky Pérez-González,
> et al are doing trying to develop a class oriented file structure in
> the device driver realm of the kernel (Re: Flaw in the driver-model
> implementation of attributes)  I've been following that thread
> because I see some real innovation there.  I don't think I'm really
> qualified to contribute but it is great to watch.  As is evident in
> that thread, real innovation isn't easy.  It takes hard work and a
> lot of back and forth banter to really hone a new idea into something
> worthwhile.  Maybe some of the guys Alan is putting through the
> wringer don't always feel too happy about his questions but in the
> long run his scrutiny will contribute to a better product.  Myself,
> I really appreciate the work these guys are doing.  Innovation is
> much harder than copying.  Most people doing it as a hobby aren't
> willing to put in the effort it takes to really make an innovative
> contribution.
>
> If these guys actually hammer out a clear and consistent improvement
> in the organization of the device driver structure, I think we'll
> have to chalk that up as an open source innovation.

maybe.

for some reason, this looks almost like a re-engineering of the DEC
hardware tree... node>nexus>bus>device>unit thing. Node was the specific
host (ie, could be a cluster). Nexus was the specific bus adapter on the
system backplane in the host (there could be more than one IO nexus 
controller) Bus was the specific type of bus controller attached to the nexus
(one or more, I vaguely remember a maixmum of 2 - BI or UNIBUS), device (the
device controller attached to the bus - disk tape/terminal/network/..) and
the unit number assigned to the hardware. There was at least one more level
for disk/tape/terminal units attached.

Which was also redone in IRIX a few years ago to support connect/disconnect
of SCSI devices and controllers. Then redone again to be able to power down
different levels for hot plugging/replacement.

I still hope that they do work it out, since it will almost certainly be
more efficient than what was done on the Vax system.
