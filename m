Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSEFBtE>; Sun, 5 May 2002 21:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314057AbSEFBtD>; Sun, 5 May 2002 21:49:03 -0400
Received: from dsl-213-023-038-176.arcor-ip.net ([213.23.38.176]:10430 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314052AbSEFBtC>;
	Sun, 5 May 2002 21:49:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Mon, 6 May 2002 03:48:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020502180632.I11414@dualathlon.random> <E174XFK-0004CJ-00@starship> <20020506034218.H6712@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E174Xc6-0004CU-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 May 2002 03:42, Andrea Arcangeli wrote:
> On Mon, May 06, 2002 at 03:24:58AM +0200, Daniel Phillips wrote:
> > What do you mean by 'implement a static view of them'?
> 
> See the attached email. assuming chunks of 256M ram every 1G, 1G phys
> goes at 3G+256M virt, 2G goes at 3G+512M etc...

So, __va(0x40000000) = 0xc0000000, and __va(0x80000000) = 0, i.e., not a kernel
address at all, because with config_discontigmem __va is a simple linear
relation.  What do you do about that?

-- 
Daniel
