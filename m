Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbULXXwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbULXXwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 18:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbULXXwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 18:52:21 -0500
Received: from holomorphy.com ([207.189.100.168]:6593 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261464AbULXXwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 18:52:16 -0500
Date: Fri, 24 Dec 2004 15:52:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [4/4]
Message-ID: <20041224235205.GX771@holomorphy.com>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <20041224125504.4caa4270.davem@davemloft.net> <20041224212513.GV771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041224212513.GV771@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 19:22:19 +0100 Andrea Arcangeli <andrea@suse.de> wrote:
>>> If those old cpus really supported smp in linux, then fixing this bit is
>>> trivial, just change it to short. Do they support short at least?

On Fri, Dec 24, 2004 at 12:55:04PM -0800, David S. Miller wrote:
>> No, they do not.  The smallest atomic unit is one 32-bit word.
>> And yes there are SMP systems using these chips.

On Fri, Dec 24, 2004 at 01:25:13PM -0800, William Lee Irwin III wrote:
> Would systems described as ev56 by /proc/cpuinfo have such chips?

I had this one in particular in mind:

# cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV56
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Rawhide
system variation        : Tincup
system revision         : 0
system serial number    : NI93009695
cycle frequency [Hz]    : 532819266 est.
timer frequency [Hz]    : 1200.00
page size [bytes]       : 8192
phys. address bits      : 40
max. addr. space #      : 127
BogoMIPS                : 910.04
kernel unaligned acc    : 29 (pc=fffffc00003158a8,va=fffffc004dafbd51)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaServer 1200 5/533 4MB
cpus detected           : 2
cpus active             : 2
cpu active mask         : 0000000000000003
L1 Icache               : 8K, 1-way, 32b line
L1 Dcache               : 8K, 1-way, 32b line
L2 cache                : 96K, 3-way, 64b line
L3 cache                : 4096K, 1-way, 64b line
#


-- wli
