Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314653AbSEBQ7v>; Thu, 2 May 2002 12:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314654AbSEBQ7u>; Thu, 2 May 2002 12:59:50 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2782 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314653AbSEBQ7t>;
	Thu, 2 May 2002 12:59:49 -0400
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?] 
In-Reply-To: Your message of Thu, 02 May 2002 09:07:05 PDT.
             <3971861785.1020330424@[10.10.2.3]> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1661.1020358682.1@us.ibm.com>
Date: Thu, 02 May 2002 09:58:02 -0700
Message-Id: <E173Juk-0000Qr-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3971861785.1020330424@[10.10.2.3]>, > : "Martin J. Bligh" writes:
> > With numa-q there's a 512M hole in each node IIRC. that's fine
> > configuration, similar to the wildfire btw.
> 
> There's 2 different memory models - the NT mode we use currently
> is contiguous, the PTX mode is discontiguous. I don't think it's
> as simple as a 512Mb fixed size hole, though I'd have to look it
> up to be sure.

No - it definitely isn't as simple as a 512 MB hole.  Depends on how much
memory is in each node, holes could be all kinds of sizes.  You could,
in theory, have had 128 MB in one node and 8 GB in another node.  I don't
think we had holes within the node from the software side - I think the
requirement was that all DIMMS were added in low to high memory slots.
Not sure what forced that requirement - could have been PTX, BIOS,
cache controllers, etc.

gerrit
