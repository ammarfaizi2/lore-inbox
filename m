Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTARIIE>; Sat, 18 Jan 2003 03:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTARIID>; Sat, 18 Jan 2003 03:08:03 -0500
Received: from holomorphy.com ([66.224.33.161]:33153 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263291AbTARIH4>;
	Sat, 18 Jan 2003 03:07:56 -0500
Date: Sat, 18 Jan 2003 00:16:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <20030118081649.GA780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200301171535.21226.efocht@ess.nec.de> <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain> <20030118070808.GA789@holomorphy.com> <420180000.1042877550@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420180000.1042877550@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I suspect some of these results may be off on NUMA-Q (or any PAE box)
>> if CONFIG_MTRR was enabled. Michael, Martin, please doublecheck
>> /proc/mtrr and whether CONFIG_MTRR=y. If you didn't enable it, or if
>> you compile times aren't on the order of 5-10 minutes, you're unaffected.
>> The severity of the MTRR regression in 2.5.59 is apparent from:
>> $ cat /proc/mtrr
>> reg00: base=0xc0000000 (3072MB), size=1024MB: uncachable, count=1
>> reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1

On Sat, Jan 18, 2003 at 12:12:31AM -0800, Martin J. Bligh wrote:
> Works for me, I have MTRR on.
> larry:~# cat /proc/mtrr
> reg00: base=0xe0000000 (3584MB), size= 512MB: uncachable, count=1
> reg01: base=0x00000000 (   0MB), size=16384MB: write-back, count=1

Okay, it sounds like the problem needs some extra RAM to trigger. We
can bounce quads back & forth if need be, but I'll at least take a shot
at finding where it happened before you probably need to look into it.


Thanks,
Bill
