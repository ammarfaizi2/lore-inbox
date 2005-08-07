Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752701AbVHGUix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbVHGUix (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbVHGUix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:38:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:22178 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752701AbVHGUiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:38:52 -0400
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 16:38:49 -0400
Message-Id: <1123447130.12766.35.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 11:47 -0700, Linus Torvalds wrote:
> James and gang found the aic7xxx slowdown that happened after 2.6.12, and 
> we'd like to get particular testing that it's fixed, so if you have a 
> relevant machine, please do test this.
> 
> There are other fixes too, a number of them reverting (at least for now)  
> patches that people had problems with. In general, anybody who has
> reported regressions since 2.6.12, please re-test with -rc6 and report
> back (even if, or perhaps _particularly_ if, no change to the regression).

It looks like CONFIG_4KSTACKS has gone away (IOW 8K stacks are no longer
an option).  But now I get this ominous warning when I compile
ndiswrapper:

*** WARNING: Kernel seems to have 4K size stack option (CONFIG_4KSTACKS)
removed; many Windows drivers will need at least 8K size stacks. You
should read wiki about 4K size stack issue. Don't complain about crashes
until you resolve this

As ndiswrapper seems to be the only option for many wireless chipsets,
this certainly looks like it will lead to regressions.

Why was this option removed?  It's pretty clear that lots of out of tree
drivers still require it.

Lee



