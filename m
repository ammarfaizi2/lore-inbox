Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTB0LUS>; Thu, 27 Feb 2003 06:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbTB0LUS>; Thu, 27 Feb 2003 06:20:18 -0500
Received: from holomorphy.com ([66.224.33.161]:39041 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264644AbTB0LUQ>;
	Thu, 27 Feb 2003 06:20:16 -0500
Date: Thu, 27 Feb 2003 03:28:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: Andi Kleen <ak@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       lse-tech@sourceforge.net, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [PATCH] New dcache / inode hash tuning patch
Message-ID: <20030227112849.GB1185@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gianni Tedesco <gianni@ecsc.co.uk>, Andi Kleen <ak@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>, lse-tech@sourceforge.net,
	akpm@digeo.com, linux-kernel@vger.kernel.org
References: <20030226164904.GA21342@wotan.suse.de> <15730000.1046283789@[10.10.2.4]> <20030226183304.GA30836@wotan.suse.de> <1046344898.28559.12.camel@lemsip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046344898.28559.12.camel@lemsip>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 18:33, Andi Kleen wrote:
>> Can you play a bit with the hash table sizes? Perhaps double the 
>> dcache hash and half the inode hash ?
>> I suspect it really just needs a better hash function. I'll cook
>> something up based on FNV hash.

On Thu, Feb 27, 2003 at 11:21:38AM +0000, Gianni Tedesco wrote:
> Didn't wli do some work in this area? I seem to recall him recommending
> FNV1a for dcache...

The work I did here was inconclusive but _suggested_ (non-rigorously)
that FNV was merely more expensive with little benefit for the most
straightforward hash function replacement strategy.

More intelligent mixing strategies for parent + child names etc. may
reveal some use for it yet, but I have zero results in that area.

There is much room for experimentation AFAICT.


-- wli
