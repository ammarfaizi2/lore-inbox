Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWHHTmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWHHTmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWHHTmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:42:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24073 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030253AbWHHTme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:42:34 -0400
Date: Tue, 8 Aug 2006 21:42:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com,
       jgarzik@pobox.com
Subject: Re: [RFC: -mm patch] bcm43xx_main.c: remove 3 functions
Message-ID: <20060808194231.GQ3691@stusta.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060807210415.GO3691@stusta.de> <200608082032.38365.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608082032.38365.mb@bu3sch.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 08:32:37PM +0200, Michael Buesch wrote:
> On Monday 07 August 2006 23:04, Adrian Bunk wrote:
> > This patch removes three no longer used functions (that are even 
> > generating gcc warnings).
> > 
> > This patch doesn't look right, but it is the result of 
> > 58e5528ee464d38040b9489e10033c9387a10d56 in git-netdev...
> 
> Hm, can't find that commit in a tree.
> I looked at linus', netdev-2.6.

It's in netdev-2.6.git#ALL that gets included in -mm.

> But one thing is for sure. This patch is _wrong_. ;)
>...

And it seems to be your fault.  ;-)


commit 58e5528ee464d38040b9489e10033c9387a10d56
Author: Michael Buesch <mb@bu3sch.de>
Date:   Sat Jul 8 22:02:18 2006 +0200

    [PATCH] bcm43xx: init routine rewrite
    
    Rewrite of the bcm43xx initialization routines.
    This fixes several issues:
    * up-down-up-down-up... stale data issue
      (May fix some DHCP issues)
    * Fix the init vs IRQ handler race (and remove the workaround)
    * Fix init for cards with multiple cores (APHY)
      As softmac has no internal PHY handling (unlike dscape),
      this adds the file "phymode" to sysfs.
      The active PHY can be selected by writing either a, b or g
      to this file. Current PHY can be determined by reading from it.
    * Fix the controller restart code.
      Controller restart can now also be triggered through
      echo 1 > /debug/bcm43xx/ethX/restart
    
    Signed-off-by: Michael Buesch <mb@bu3sch.de>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>


> Greetings Michael.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

