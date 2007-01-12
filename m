Return-Path: <linux-kernel-owner+w=401wt.eu-S1161044AbXALLUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbXALLUE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbXALLUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:20:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2977 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161044AbXALLUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:20:01 -0500
Date: Fri, 12 Jan 2007 11:19:27 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jeff@garzik.org>
Cc: Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net,
       Avi Kivity <avi@qumranet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
Message-ID: <20070112111927.GB7145@ucw.cz>
References: <45A39A97.5060807@qumranet.com> <45A39D0D.7090007@garzik.org> <200701110834.43800.arnd@arndb.de> <45A5F4A5.9000408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A5F4A5.9000408@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> >>Can we please avoid adding a ton of new ioctls?  
> >>ioctls inevitably require 64-bit compat code for 
> >>certain architectures, whereas sysfs/procfs does not.
> >
> >For performance reasons, an ascii string based 
> >interface is not
> >desireable here, some of these calls should be 
> >optimized to
> >the point of counting cycles.
> 
> sysfs does not require ASCII...

Yep, but at that point you have 32 vs. 64bit nightmare back... and
stronger, because sysfs does not have compat handling.

-- 
Thanks for all the (sleeping) penguins.
