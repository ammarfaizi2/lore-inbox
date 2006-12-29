Return-Path: <linux-kernel-owner+w=401wt.eu-S1753952AbWL2Ann@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbWL2Ann (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbWL2Ann
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 19:43:43 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:20100 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbWL2Ann (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 19:43:43 -0500
Date: Thu, 28 Dec 2006 16:31:27 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
Message-Id: <20061228163127.8234fac9.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.63.0612290131500.27367@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
	<20061228124644.4e1ed32b.akpm@osdl.org>
	<Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
	<20061228210803.GR17561@ftp.linux.org.uk>
	<Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
	<20061228213438.GD20596@flint.arm.linux.org.uk>
	<20061228133246.ad820c6a.randy.dunlap@oracle.com>
	<20061228214830.GF20596@flint.arm.linux.org.uk>
	<20061228161019.b876e10b.randy.dunlap@oracle.com>
	<Pine.LNX.4.63.0612290131500.27367@gockel.physik3.uni-rostock.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 01:37:39 +0100 (CET) Tim Schmielau wrote:

> On Thu, 28 Dec 2006, Randy Dunlap wrote:
> > On Thu, 28 Dec 2006 21:48:30 +0000 Russell King wrote:
> > > On Thu, Dec 28, 2006 at 01:32:46PM -0800, Randy Dunlap wrote:
> > > > On Thu, 28 Dec 2006 21:34:38 +0000 Russell King wrote:
> > > > > The whole "all*config" idea on ARM is utterly useless - you can _not_
> > > > > get build coverage that way.
> > > > 
> > > > Uh, can J. Random Developer submit patches to the ARM build system
> > > > for testing?
> > > 
> > > Given that it takes about 8 to 12 hours to do a build cycle, that's
> > > not practical.  The only real solution is for us to accept that
> > > breakage will occur (and be prepared to keep a steady stream of
> > > fixes heading into Linus' tree - which has been ruled out by Linus)
> > > or J. Random Developer has to build a set of affected ARM defconfigs
> > > themselves.
> > 
> > I guess I don't get it.  Isn't that what we just went thru
> > with the struct nightmare^W work_struct changes?
> > But these header file changes are much simpler and more obvious...
> 
> Well, I think it's practical to build all arm configs yourself. I'll do 
> that for my sched.h #include changes. It's been less that two hours since 
> I started the builds on two cpus and I already got 35 out of 59 configs.

Yep, right, if I already had all of that cross-build stuff setup,
it wouldn't be a big deal.  But getting it all setup is a big deal
(to me).

> It's just that one has to be aware of it. Before Russell's post the 
> situation on arm seemed so confusing to me that I thought I'd just 
> compile allnoconfig, defconfig, allmodconfig and allyesconfig and let the 
> arm people figure out the rest.

---
~Randy
