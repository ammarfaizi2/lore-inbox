Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWCOAJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWCOAJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCOAJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:09:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:6365 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1752059AbWCOAJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:09:52 -0500
Date: Tue, 14 Mar 2006 18:09:23 -0600
From: Mark Maule <maule@sgi.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060315000923.GC25848@sgi.com>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314215736.GV13973@stusta.de> <4417580B.2090205@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4417580B.2090205@ce.jp.nec.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 06:55:55PM -0500, Jun'ichi Nomura wrote:
> Adrian Bunk wrote:
> >>include2/asm/msi.h: In function `ia64_msi_init':
> >>include2/asm/msi.h:23: warning: implicit declaration of function 
> >>`msi_register'
> >>In file included from include2/asm/machvec.h:408,
> >>                from include2/asm/io.h:70,
> >>                from include2/asm/smp.h:20,
> >>                from /build/rc6/source/include/linux/smp.h:22,
> >>...
> >
> >To avoid any wrong impression:
> >
> >This kind of warnings isn't harmless.
> >
> >gcc tries to guess the prototype of the function, and if gcc guessed 
> >wrong this can cause nasty and hard to debug runtime errors.
> 
> Sure.
> But for this case, gcc emits the above warning for any files
> which includes, for example, include/linux/smp.h on ia64.
> So while the warning is harmless, it may cause other harmful
> warnings being overlooked.
> 

Yes, this should be cleaned up.  I'll take a look.

I thought though that we had all of this compiling cleanly ... guess not.

Mark
