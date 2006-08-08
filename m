Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWHHXTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWHHXTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWHHXTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:19:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:62390 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965068AbWHHXT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:19:29 -0400
Date: Tue, 8 Aug 2006 16:19:15 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: Still get build warnings - gcc-3.4.6 - 2.6.17.8
Message-ID: <20060808231915.GA23161@kroah.com>
References: <200608082148.11433.nick@linicks.net> <20060808141246.25ee5db7.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808141246.25ee5db7.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 02:12:46PM -0700, Randy.Dunlap wrote:
> On Tue, 8 Aug 2006 21:48:11 +0100 Nick Warne wrote:
> 
> > Hi all,
> > 
> > I have had these warnings for ages:
> > 
> > kernel/power/pm.c:241: warning: `pm_register' is deprecated (declared at 
> > kernel/power/pm.c:64)
> > kernel/power/pm.c:241: warning: `pm_register' is deprecated (declared at 
> > kernel/power/pm.c:64)
> > kernel/power/pm.c:242: warning: `pm_unregister_all' is deprecated (declared at 
> > kernel/power/pm.c:97)
> > kernel/power/pm.c:242: warning: `pm_unregister_all' is deprecated (declared at 
> > kernel/power/pm.c:97)
> > kernel/power/pm.c:243: warning: `pm_send_all' is deprecated (declared at 
> > kernel/power/pm.c:216)
> > kernel/power/pm.c:243: warning: `pm_send_all' is deprecated (declared at 
> > kernel/power/pm.c:216)
> > 
> > and I think at one time there was a fix about that I applied, but it seems it 
> > never made it into kernel.org.
> > 
> > Or is this my ggc problem?
> 
> It's not a gcc (nor ggc) problem.  Those functions are just deprecated.
> Current 2.6.18-rc4 and 2.6.18-rc3-mm2 still have those same warnings.
> 
> fwiw, I don't seem to have any patches to fix/remove them.

pm_unregister_all is removed in the -mm tree, from a patch in my tree.

thanks,

greg k-h
