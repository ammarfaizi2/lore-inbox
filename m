Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266735AbTA2Rxi>; Wed, 29 Jan 2003 12:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbTA2Rxi>; Wed, 29 Jan 2003 12:53:38 -0500
Received: from holomorphy.com ([66.224.33.161]:38062 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266735AbTA2Rxh>;
	Wed, 29 Jan 2003 12:53:37 -0500
Date: Wed, 29 Jan 2003 10:00:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no more MTRRs available ?
Message-ID: <20030129180011.GN780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030129162354.55f2ace4.skraw@ithnet.com> <Pine.LNX.4.44.0301291025240.18828-100000@coffee.psychology.mcmaster.ca> <20030129164552.182e0cb8.skraw@ithnet.com> <20030129172001.GM780@holomorphy.com> <20030129174842.GE1856@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129174842.GE1856@codemonkey.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 09:20:01AM -0800, William Lee Irwin III wrote:
>> Looks better than what I'm getting on 2.5.59:
>> curly:~# cat /proc/mtrr
>> reg00: base=0xc0000000 (49152MB), size=16384MB: uncachable, count=1
>> reg01: base=0x00000000 (   0MB), size=524288MB: write-back, count=1
>> reg02: base=0x800000000 (524288MB), size=262144MB: write-back, count=1
>> Yes, this is standard ia32 (P-III/Coppermine cpus), and hence the
>> numbers here are utter garbage.

On Wed, Jan 29, 2003 at 05:48:42PM +0000, Dave Jones wrote:
> Bizarre. The size field isn't being shifted, and your base is somewhere
> off in 64bit land.
> See Andi's "RED-PEN" comments in various parts of arch/i386/kernel/cpu/mtrr/
> They need fixing at some point, and could be the cause of your problems.

OTOH since 0-512GB are in there this explains why the (massive) perf.
decrease only happens sometimes. The MTRR corruption issues are only
visible with 48GB atm. I haven't been focusing on MTRR's but I may
arrange to trace the codepaths etc. in the eventual future to find
where the bits are going bad esp. as benchmark time approaches.

-- wli
