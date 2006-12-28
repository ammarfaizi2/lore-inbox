Return-Path: <linux-kernel-owner+w=401wt.eu-S1755001AbWL1Vsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbWL1Vsj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755011AbWL1Vsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:48:39 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4333 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbWL1Vsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:48:38 -0500
Date: Thu, 28 Dec 2006 21:48:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
Message-ID: <20061228214830.GF20596@flint.arm.linux.org.uk>
Mail-Followup-To: Randy Dunlap <randy.dunlap@oracle.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de> <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de> <20061228210803.GR17561@ftp.linux.org.uk> <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de> <20061228213438.GD20596@flint.arm.linux.org.uk> <20061228133246.ad820c6a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228133246.ad820c6a.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 01:32:46PM -0800, Randy Dunlap wrote:
> On Thu, 28 Dec 2006 21:34:38 +0000 Russell King wrote:
> > The whole "all*config" idea on ARM is utterly useless - you can _not_
> > get build coverage that way.
> 
> Uh, can J. Random Developer submit patches to the ARM build system
> for testing?

Given that it takes about 8 to 12 hours to do a build cycle, that's
not practical.  The only real solution is for us to accept that
breakage will occur (and be prepared to keep a steady stream of
fixes heading into Linus' tree - which has been ruled out by Linus)
or J. Random Developer has to build a set of affected ARM defconfigs
themselves.

Or alternatively the guy who's running kautobuild needs an amount of
rather powerful donated hardware to stubstantially increase it's
throughput.

Or cross-gcc needs to be optimised to compile faster.

I don't see any of the above happening, so...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
