Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314603AbSEBQHe>; Thu, 2 May 2002 12:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314610AbSEBQHd>; Thu, 2 May 2002 12:07:33 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:26275 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314603AbSEBQHc>; Thu, 2 May 2002 12:07:32 -0400
Date: Thu, 02 May 2002 09:07:05 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <3971861785.1020330424@[10.10.2.3]>
In-Reply-To: <20020502173522.F11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With numa-q there's a 512M hole in each node IIRC. that's fine
> configuration, similar to the wildfire btw.

There's 2 different memory models - the NT mode we use currently
is contiguous, the PTX mode is discontiguous. I don't think it's
as simple as a 512Mb fixed size hole, though I'd have to look it
up to be sure.

>> At the moment I use the contig memory model (so we only use discontig for
>> NUMA support) but I may need to change that in the future.
> 
> I wasn't thinking at numa-q, but regardless numa-Q fits perfectly into
> the current discontigmem-numa model too as far I can see.

As Dan already mentioned, we need CONFIG_NONLINEAR to spread
around ZONE_NORMAL.

M.

