Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVCKXoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVCKXoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVCKXlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:41:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46597 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261798AbVCKXhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:37:24 -0500
Date: Sat, 12 Mar 2005 00:37:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version
Message-ID: <20050311233722.GS3723@stusta.de>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org> <20050310225340.GD3205@stusta.de> <200503111849.j2BImsJp003370@ccure.user-mode-linux.org> <20050311165526.GA3723@stusta.de> <200503112354.j2BNrFJp005237@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503112354.j2BNrFJp005237@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 06:53:15PM -0500, Jeff Dike wrote:
> bunk@stusta.de said:
> > And therefore you added a patch that helps only those distros at the
> > price of breaking other people and distros using sane compilers? 
> 
> Didn't you start this thread by pointing out that SuSE has a gcc 3.3.4
> which isn't?  I would call that a compiler which lies about its version, and
> for the purposes of this argument, I would say that it is not a sane
> compiler.

I said:

<--  snip  -->

This line has to be something like

( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4) && \
   HEAVILY_PATCHES_SUSE_GCC ) 

<--  snip  -->

IOW:
Only heavily patches gcc 3.3 compiler define __gcov_init.


Anton's original report said that he needs __gcov_init with
SuSE gcc 3.3.4 .


> Given this, your original (correct) claim was that my patch would not help
> such compilers.  Are you now claiming that it does help such compilers, and
> no one else?

No, my claim is that no sane gcc 3.3 defines __gcov_init.

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

