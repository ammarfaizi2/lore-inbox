Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbTJAVfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbTJAVfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:35:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50185 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262583AbTJAVfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:35:37 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test6: a few __init bugs
Date: 1 Oct 2003 21:26:07 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blfgpf$j8d$1@gatekeeper.tmr.com>
References: <20030930212551.GA20709@kroah.com> <1064958129.5264.237.camel@dooby.cs.berkeley.edu>
X-Trace: gatekeeper.tmr.com 1065043567 19725 192.168.12.62 (1 Oct 2003 21:26:07 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1064958129.5264.237.camel@dooby.cs.berkeley.edu>,
Robert T. Johnson <rtjohnso@eecs.berkeley.edu> wrote:
| On Tue, 2003-09-30 at 14:25, Greg KH wrote:
| > Hm, good point.  Can you think of a better place for this that would
| > have helped you out?
| 
| Take two.  It might not have prevented me from reporting the potential
| bug, but I would've known you'd thought about it, it might help future
| developers, and it's unlikely to become dangerously wrong.  Thanks.
| 
| Best,
| Rob
| 
| --- drivers/pci/quirks.c.orig	Tue Sep 30 14:17:40 2003
| +++ drivers/pci/quirks.c	Tue Sep 30 14:39:48 2003
| @@ -750,6 +750,9 @@
|  
|  /*
|   *  The main table of quirks.
| + *
| + *  Note: any hooks for hotpluggable devices in this table must _NOT_
| + *        be declared __init.
|   */
|  
|  static struct pci_fixup pci_fixups[] __devinitdata = {

Good job, that. Clear, and anyone who doesn't immediately see why
probably is at a skill level to just say 'oh' and do what it says.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
