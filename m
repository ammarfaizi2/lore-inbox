Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUCXUYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUCXUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:24:13 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:2223 "EHLO
	santa.timesys") by vger.kernel.org with ESMTP id S261568AbUCXUYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:24:08 -0500
Date: Wed, 24 Mar 2004 15:24:02 -0500
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Tom Rini <trini@kernel.crashing.org>, kgdb-bugreport@lists.sourceforge.net,
       Anurekh Saxena <anurekh.saxena@timesys.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Kgdb-bugreport] kgdb_arch_set/remove_break() ?
Message-ID: <20040324202402.GA20260@timesys.com>
References: <20040319160359.GD4569@smtp.west.cox.net> <200403242005.21197.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403242005.21197.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Anurekh Saxena <anurekh.saxena@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 24, 2004 at 08:05:21PM +0530, Amit S. Kale wrote:
> On Friday 19 Mar 2004 9:33 pm, Tom Rini wrote:
> > Hi.  Right now I'm writing up a porting doc that describes the various
> > hook functions we've got.  I noticed that nothing is calling
> > kgdb_arch_set/remove_break.  Is there some arch we're expecting will
> > need this?  I'd like to just go ahead and remove them
> 
> I can't remember why that was done. A processor other than PPC, x86 and x86_64 
> needs a special implementation of set and remove breakpoint, I guess.
> 
> Anurekh, who did initial implementation of arch independent-dependent split 
> may have some comments on this.


*set_break
*remove_break

These functions should only be defined for architecutes that support
hardware breakpoint. Set KGDB_HW_BREAKPOINT flag.
