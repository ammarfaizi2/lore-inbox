Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbTA2RN1>; Wed, 29 Jan 2003 12:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTA2RN1>; Wed, 29 Jan 2003 12:13:27 -0500
Received: from holomorphy.com ([66.224.33.161]:29102 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266564AbTA2RN0>;
	Wed, 29 Jan 2003 12:13:26 -0500
Date: Wed, 29 Jan 2003 09:20:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no more MTRRs available ?
Message-ID: <20030129172001.GM780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030129162354.55f2ace4.skraw@ithnet.com> <Pine.LNX.4.44.0301291025240.18828-100000@coffee.psychology.mcmaster.ca> <20030129164552.182e0cb8.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129164552.182e0cb8.skraw@ithnet.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 04:45:52PM +0100, Stephan von Krawczynski wrote:
> # cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
> reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
> reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
> reg03: base=0xe0000000 (3584MB), size= 256MB: write-back, count=1
> reg04: base=0xf0000000 (3840MB), size= 128MB: write-back, count=1
> reg05: base=0xf7000000 (3952MB), size=  16MB: uncachable, count=1
> reg06: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
> reg07: base=0x200000000 (8192MB), size=8192MB: write-back, count=1

Looks better than what I'm getting on 2.5.59:

curly:~# cat /proc/mtrr
reg00: base=0xc0000000 (49152MB), size=16384MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=524288MB: write-back, count=1
reg02: base=0x800000000 (524288MB), size=262144MB: write-back, count=1

Yes, this is standard ia32 (P-III/Coppermine cpus), and hence the
numbers here are utter garbage.


-- wli
