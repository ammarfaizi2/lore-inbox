Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbTC1E5n>; Thu, 27 Mar 2003 23:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbTC1E5n>; Thu, 27 Mar 2003 23:57:43 -0500
Received: from holomorphy.com ([66.224.33.161]:63661 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262198AbTC1E5m>;
	Thu, 27 Mar 2003 23:57:42 -0500
Date: Thu, 27 Mar 2003 21:08:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 48GB NUMA-Q boots, with major IO-APIC hassles
Message-ID: <20030328050839.GP1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030115105802.GQ940@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115105802.GQ940@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 02:58:02AM -0800, William Lee Irwin III wrote:
> Minor extrapolation: aside from potential explosions in very unusual
> corner cases, with these hacks/workarounds 64GB NUMA-Q should boot and
> run (slowly) with an approximate LowTotal of 173296 kB. The main obstacle
> is our setup here would require an additional NR_CPUS > BITS_PER_LONG
> patch, and there isn't much local interest in even seeing whether or how
> poorly it would run without working patches (e.g. hugh's MMUPAGE_SIZE that
> I'm fwd. porting) to do something about runaway mem_map lowmem consumption.

I was only 3MB off wrt. mainline's 64GB LowTotal, not bad at all:

HighTotal:    65134592 kB
HighFree:     65116864 kB
LowTotal:       176076 kB
LowFree:        144180 kB

Turns out NR_CPUS > BITS_PER_LONG was avoided. I'll dig up whatever else
I can here. AIM7 with 10000 tasks and various other things were runnable
on 48GB, but I still need to straighten various fragmentation things out
before benching produces meaningful numbers instead of runs vs. doesn't.


-- wli
