Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269068AbUIXSZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269068AbUIXSZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUIXSYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:24:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:2439 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268894AbUIXSXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:23:33 -0400
Date: Fri, 24 Sep 2004 11:23:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: resource provisioning
Message-ID: <20040924112328.V1973@build.pdx.osdl.net>
References: <20040924151604.30416.qmail@web51808.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040924151604.30416.qmail@web51808.mail.yahoo.com>; from phyprabab@yahoo.com on Fri, Sep 24, 2004 at 08:16:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Phy Prabab (phyprabab@yahoo.com) wrote:
> I would like to know if the linux kernel has a
> mechanism to control computing resources at a uid
> level, which I will call "resource provisioning".  For
> example, I would like to define on a multi cpu machine
> that a list of uid's can not consume more than 1 cpu
> and no more than 1G RAM, irregardless or how many jobs
> they launch on or to the system.

You can already do this in some pretty crude fashion via rlimits and
sched_setaffinity (although the later doesn't have direct pam support
that I know of, so you'd have to manage that on your own).

> So I guess, is this the correct term and is there a
> posibilitity to do this now?

Otherwise, you must look at out of tree patches.  Linux-vserver does
this, CKRM will allow you resource control, and PAGG + other module
(perhaps job?) will give you this as well.

> I would like to avoid the virtual servers method as I
> do not want to carve the machines in question into
> more machines.

Note: the vserver method above doesn't create actual virtual machines,
more like a software construct that you could consider a resource domain.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
