Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVCLMfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVCLMfS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 07:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVCLMfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 07:35:18 -0500
Received: from port-212-202-144-146.static.qsc.de ([212.202.144.146]:62432
	"EHLO mail.hennerich.de") by vger.kernel.org with ESMTP
	id S261735AbVCLMfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 07:35:07 -0500
Date: Sat, 12 Mar 2005 13:32:41 +0100
From: Tobias Hennerich <Tobias@Hennerich.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Strange memory leak in 2.6.x
Message-ID: <20050312133241.A11469@bart.hennerich.de>
References: <20050308133735.A13586@bart.hennerich.de> <20050308173811.0cd767c3.akpm@osdl.org> <20050309102740.D3382@bart.hennerich.de> <20050311183207.A22397@bart.hennerich.de> <1110565420.2501.12.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1110565420.2501.12.camel@boxen>; from alexn@dsv.su.se on Fri, Mar 11, 2005 at 07:23:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Mar 11, 2005 at 07:23:40PM +0100, Alexander Nyberg wrote:
> Yikes something isn't right with these backtraces that page_owner is
> showing. Even without frame pointers it shouldn't be this noisy.

If you could send me some pointers to documents how to interpret
this output, i would appreciate it.

> I'm afraid I'm going to need to ask for more help, could you please
> select CONFIG_FRAME_POINTER under 
> Kernel hacking => "Compile the kernel with frame pointers"

Done. Our .config looks now like this:

...
#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
CONFIG_PAGE_OWNER=y
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
... 

> And when that kernel is booted, could you directly send me the output
> of /proc/page_owner (sort or unsorted) so that I can see if something is
> wrong with the data it's producing (just to be sure).

See http://download.hennerich.de/page_owner_sorted_20050312_1040.bz2

> If it works better with CONFIG_FRAME_POINTER, i'm also going to have to
> ask you to do another one of these runs that you just did.

The cronjob which generates each 10 minutes a new actual file of 
page_owner_sorted is still running... and I'm afraid that we will
run into problems sooner or later again...

Best regards	Tobias

-- 
T+T Hennerich GmbH --- Zettachring 12a --- 70567 Stuttgart
Fon:+49(711)720714-0  Fax:+49(711)720714-44  Vanity:+49(700)HENNERICH
UNIX - Linux - Java - C  Entwicklung/Beratung/Betreuung/Schulung
http://www.hennerich.de/
