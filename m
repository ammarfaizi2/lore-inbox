Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbTA2RnS>; Wed, 29 Jan 2003 12:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbTA2RnS>; Wed, 29 Jan 2003 12:43:18 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:24772 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266730AbTA2RnR>;
	Wed, 29 Jan 2003 12:43:17 -0500
Date: Wed, 29 Jan 2003 17:48:42 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no more MTRRs available ?
Message-ID: <20030129174842.GE1856@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030129162354.55f2ace4.skraw@ithnet.com> <Pine.LNX.4.44.0301291025240.18828-100000@coffee.psychology.mcmaster.ca> <20030129164552.182e0cb8.skraw@ithnet.com> <20030129172001.GM780@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129172001.GM780@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 09:20:01AM -0800, William Lee Irwin III wrote:

 > Looks better than what I'm getting on 2.5.59:
 > 
 > curly:~# cat /proc/mtrr
 > reg00: base=0xc0000000 (49152MB), size=16384MB: uncachable, count=1
 > reg01: base=0x00000000 (   0MB), size=524288MB: write-back, count=1
 > reg02: base=0x800000000 (524288MB), size=262144MB: write-back, count=1
 > Yes, this is standard ia32 (P-III/Coppermine cpus), and hence the
 > numbers here are utter garbage.

Bizarre. The size field isn't being shifted, and your base is somewhere
off in 64bit land.
See Andi's "RED-PEN" comments in various parts of arch/i386/kernel/cpu/mtrr/
They need fixing at some point, and could be the cause of your problems.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
