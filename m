Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSEFAzR>; Sun, 5 May 2002 20:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313943AbSEFAzQ>; Sun, 5 May 2002 20:55:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2823 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313773AbSEFAzQ>; Sun, 5 May 2002 20:55:16 -0400
Date: Mon, 6 May 2002 01:55:05 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020506015505.B14956@flint.arm.linux.org.uk>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E173LwB-00027n-00@starship> <20020503071554.P11414@dualathlon.random> <E174Vq8-0004BK-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 01:54:52AM +0200, Daniel Phillips wrote:
> I must be guilty of not explaining clearly.  Suppose you have the following
> physical memory map:
> 
> 	          0: 128 MB
> 	  8000,0000: 128 MB
> 	1,0000,0000: 128 MB
> 	1,8000,0000: 128 MB
> 	2,0000,0000: 128 MB
> 	2,8000,0000: 128 MB
> 	3,0000,0000: 128 MB
> 	3,8000,0000: 128 MB
> 
> The total is 1 GB of installed ram.  Yet the kernel's 1G virtual space,
> can only handle 128 MB of it.

I see no problem with the above with the existing discontigmem stuff.
discontigmem does *not* require a linear relationship between kernel
virtual and physical memory.  I've been running kernels for a while
on such systems.

Which was the reason for my comment at the start of this thread:
| On ARM, however, we have cherry to add here.  __va() may alias certain
| physical memory addresses to the same virtual memory address, which
| makes:

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

