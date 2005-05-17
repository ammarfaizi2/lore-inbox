Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVEQXRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVEQXRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEQXRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:17:08 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:24050 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261959AbVEQXQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:16:43 -0400
Date: Tue, 17 May 2005 16:11:48 -0400
From: Christopher Li <lkml@chrisli.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
Message-ID: <20050517201148.GA12997@64m.dyndns.org>
References: <428A661C.1030100@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428A661C.1030100@ammasso.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is missing the gcc default include path.

Check your pre-processor.h in sparse to see that match your gcc
include path or not.

If not, remove pre-processor.h and recompile sparse should solve
the problem.

Chris

On Tue, May 17, 2005 at 04:46:04PM -0500, Timur Tabi wrote:
> I'm trying to run sparse on my external module, but sparse complains about 
> not being able to find stdarg.h.  I know this bug was supposed to have been 
> fixed back in January, but I'm using the latest code, so I can't explain 
> what's wrong.  I've tried this on a couple different 2.6 kernels.
> 
> Here's the output I get:
> 
> make -C /lib/modules/2.6.8-24-smp/source 
> SUBDIRS=/root/AMSO1100/software/host/linux/sys/devccil  C=1 V=2
> make[2]: Entering directory `/usr/src/linux-2.6.8-24'
>   CHECK   /root/AMSO1100/software/host/linux/sys/devccil/devnet.c
> include/linux/kernel.h:10:11: error: unable to open 'stdarg.h'
> make[3]: *** [/root/AMSO1100/software/host/linux/sys/devccil/devnet.o] 
> Error 1
> make[2]: *** [_module_/root/AMSO1100/software/host/linux/sys/devccil] Error 
> 2
> make[2]: Leaving directory `/usr/src/linux-2.6.8-24'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/AMSO1100/software/host/linux/sys/devccil'
> make: *** [build] Error 2
> 
> -- 
> Timur Tabi
> Staff Software Engineer
> timur.tabi@ammasso.com
> 
> One thing a Southern boy will never say is,
> "I don't think duct tape will fix it."
>      -- Ed Smylie, NASA engineer for Apollo 13
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
