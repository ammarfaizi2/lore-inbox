Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272877AbTHKROf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272873AbTHKROZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:14:25 -0400
Received: from defout.telus.net ([199.185.220.240]:57998 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S272872AbTHKRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:13:46 -0400
Subject: Re: test3 responsible for atomic blast!
From: Bob Gill <gillb4@telusplanet.net>
To: Bongani Hlope <bonganilinux@mweb.co.za>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030810224853.4a291e6e.bonganilinux@mweb.co.za>
References: <1060547281.6445.13.camel@localhost.localdomain>
	 <20030810224853.4a291e6e.bonganilinux@mweb.co.za>
Content-Type: text/plain
Organization: 
Message-Id: <1060622081.4200.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Aug 2003 11:14:41 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_SPINLOCK_SLEEP is not set:
(but thank you for replying anyway).

# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
# CONFIG_DEBUG_IOVIRT is not set
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_HIGHMEM=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

>On Sun, 2003-08-10 at 14:48, Bongani Hlope wrote:
> On Sun, 10 Aug 2003 14:28:01 -0600
> Bob Gill <gillb4@telusplanet.net> wrote:
> 
> > The really good news is 2.6.0-test3 is *much* more efficient at
> > delivering error messages than earlier versions!  
> > The following is from /var/log/messages:
> 
> 8<
> 
> > unknown_bootoption+0x0/0xfa
> > Aug 10 14:07:38 localhost kernel:
> > Aug 10 14:07:38 localhost kernel: bad: scheduling while atomic!
> > Aug 10 14:07:38 localhost kernel: Call Trace:
> > Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
> > Aug 10 14:07:38 localhost kernel:  [<c011d729>] schedule+0x6e4/0x6e9
> > Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
> > Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
> > Aug 10 14:07:38 localhost kernel:  [<c0107269>] default_idle+0x0/0x2c
> > Aug 10 14:07:38 localhost kernel:  [<c0105000>] rest_init+0x0/0xf5
> > Aug 10 14:07:38 localhost kernel:  [<c0107308>] cpu_idle+0x38/0x3a
> > Aug 10 14:07:38 localhost kernel:  [<c039672a>] start_kernel+0x1bd/0x215
> > Aug 10 14:07:38 localhost kernel:  [<c039643f>]
> > unknown_bootoption+0x0/0xfa
> > 
> > ... the bad: scheduling while atomic!  keeps blasting away at my screen
> > until I shutdown.  I *do* shutdown right away before the system decides
> > to really hang (and take out my root partition on next startup like it
> > has done when I get these atomic crashes).  Long before any real testing
> > begins, nasty bugs like this have to go!
> > 
> > 
> > -- 
> > Bob Gill <gillb4@telusplanet.net>
> 
> The system wont really hang (and take out you root partition) disable CONFIG_DEBUG_SPINLOCK_SLEEP (kernel hacking -> Sleep-inside-spinlock checking) on you .config if you want them to go away. 
-- 
Bob Gill <gillb4@telusplanet.net>

