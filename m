Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315575AbSECGjf>; Fri, 3 May 2002 02:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315576AbSECGje>; Fri, 3 May 2002 02:39:34 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:48805 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S315575AbSECGjc>; Fri, 3 May 2002 02:39:32 -0400
Date: Thu, 02 May 2002 23:39:09 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>, Gerrit Huizenga <gh@us.ibm.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <4024186083.1020382748@[10.10.2.3]>
In-Reply-To: <20020503082057.U11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> With the "flat" addressing mode that Martin has been using (the
>> dummied down for NT version) everything is squished together.  That
>> makes it a bit harder to do node local data structures, although he
>> may have enough data from the MPS table to split memory appropriately.
> 
> sure, the only issue is the API that the hardware provides to advertise
> the start/end of the memory for each node. It doesn't matter if it's
> squashed or not as long as you still know the start/end of the phys ram
> per node. It also won't make any difference with nonlinear or
> discontigmem because you need to fill the pgdat anyways to enable the
> numa heuristics (node-affine-allocations being the most sensible etc..).

Yup, we can grab that info from the BIOS generated tables - see 
Pat Gaughen's patch posted here a few days ago that parses those
tables and feeds the pgdats if you want the gory details.

Martin.

