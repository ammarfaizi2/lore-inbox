Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265309AbTLMWcR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 17:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbTLMWcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 17:32:17 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:51846 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265309AbTLMWcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 17:32:12 -0500
Date: Sat, 13 Dec 2003 23:32:08 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Use-after-free in pte_chain in 2.6.0-test11
Message-ID: <20031213223208.GB25959@vana.vc.cvut.cz>
References: <20031213220459.GA22152@vana.vc.cvut.cz> <20031213221320.GT8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213221320.GT8039@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 02:13:20PM -0800, William Lee Irwin III wrote:
> On Sat, Dec 13, 2003 at 11:04:59PM +0100, Petr Vandrovec wrote:
> >   today I get this one while attempting to build new kernel. Running kernel is
> > 2.6.0-test11-c1511 (bk as of 2003-12-05 23:35:35-08:00). Does anybody
> > have any clue what could happen, or should I start looking for a new
> > memory modules?
> >   AMD K7/1GHz box, 512MB RAM, no vmmon/vmnet loaded since reboot, gcc-3.3.2
> > as of last week Debian unstable. Kernel built with all possible memory 
> > debugging enabled... 
> >   Unfortunately I have no idea which process did this clone() call, and
> > whether it succeeded or died. 
> 
> CONFIG_DEBUG_PAGEALLOC should have oopsed this...

Maybe pte_chain is too small to get unmapped (it is 128 bytes here)? Or it is 
really hardware bug :-(

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

