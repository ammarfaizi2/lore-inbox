Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVATSSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVATSSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVATSOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:14:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:45487 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261398AbVATSOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:14:00 -0500
Date: Thu, 20 Jan 2005 10:13:51 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips default mlock limit fix
Message-ID: <20050120101351.J24171@build.pdx.osdl.net>
References: <20050119175945.K469@build.pdx.osdl.net> <20050120160005.GA5672@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050120160005.GA5672@linux-mips.org>; from ralf@linux-mips.org on Thu, Jan 20, 2005 at 05:00:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Baechle (ralf@linux-mips.org) wrote:
> On Wed, Jan 19, 2005 at 05:59:45PM -0800, Chris Wright wrote:
> 
> > Mips RLIMIT_MEMLOCK incorrectly defaults to unlimited, it was confused
> > with RLIMIT_NPROC.  Found while consolidating resource.h headers.
> 
> Thanks, I applied a recent change off by one line.  To avoid this I've
> changed the code to use named initializers, see
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-cvs-patches&i=95f18dfc8e770c9885b796a676935677%40NO-ID-FOUND.mhonarc.org

That works too.  I made a similar change in the consolidation patch.  This
was just meant to be a very simple stop gap fix, while the consolidation
bits bake in -mm before they go to Linus.  I prefer to leave it as is,
only so I don't have to respin the patches, but it's not that big a deal.
Either way, Linus should pick up one of the mips fixes.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
