Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVBQQAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVBQQAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVBQQAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:00:17 -0500
Received: from mail.charite.de ([160.45.207.131]:17816 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262282AbVBQQAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:00:11 -0500
Date: Thu, 17 Feb 2005 17:00:00 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Dale Blount <linux-kernel@dale.us>, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
Message-ID: <20050217160000.GA6680@charite.de>
Mail-Followup-To: Dale Blount <linux-kernel@dale.us>,
	linux-kernel@vger.kernel.org
References: <20050215145618.GP24211@charite.de> <20050216153338.GA26953@atrey.karlin.mff.cuni.cz> <20050216200441.GH19871@charite.de> <1108590885.17089.17.camel@dale.velocity.net> <20050216145548.53f67fec.akpm@osdl.org> <20050217105818.GS6680@charite.de> <20050217132148.GE6680@charite.de> <4214BD6F.7080203@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4214BD6F.7080203@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy.Dunlap <rddunlap@osdl.org>:

> >Is it normal that the kernel with debugging enabled is not larger than
> >the normal kernel?
> >-
> 
> No, it should be much larger.  Recheck the .config file
> for CONFIG_DEBUG_INFO=y.  Maybe you need to do 'make clean'
> first.

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_INFO=y
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y

I built that using "make-kpkg"

make-kpkg clean
CONCURRENCY_LEVEL=4 MAKEFLAGS="CC=gcc-3.4" make-kpkg --revision=20050217 kernel_image

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
