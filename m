Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315432AbSEBVZi>; Thu, 2 May 2002 17:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315433AbSEBVZh>; Thu, 2 May 2002 17:25:37 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:13982 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315432AbSEBVZf>; Thu, 2 May 2002 17:25:35 -0400
Date: Thu, 02 May 2002 15:23:39 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?] 
Message-ID: <149580000.1020378219@flay>
In-Reply-To: <E173MG4-00024o-00@w-gerrit2>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I *think* the ranges were typically aligned to 4 GB, although with 8 GB
> in a single node, I don't remember what the mapping layout looked like.
> 
> Which made everything but node 0 into HIGHMEM.
> 
> With the "flat" addressing mode that Martin has been using (the
> dummied down for NT version) everything is squished together.  That
> makes it a bit harder to do node local data structures, although he
> may have enough data from the MPS table to split memory appropriately.

I have enough data, I know which phys mem ranges are in each node,
but I still need to change the virtual <-> physical mapping in order to
spread ZONE_NORMAL around. Pat has already spread the high memory
around into specific pg_data_t's per node.

M.

