Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314557AbSEBPmR>; Thu, 2 May 2002 11:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314578AbSEBPmQ>; Thu, 2 May 2002 11:42:16 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:32670 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314557AbSEBPmP>;
	Thu, 2 May 2002 11:42:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 17:42:40 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020502153402.A11414@dualathlon.random> <3968942217.1020327505@[10.10.2.3]> <20020502173522.F11414@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172wFc-00024h-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 17:35, Andrea Arcangeli wrote:
> On Thu, May 02, 2002 at 08:18:33AM -0700, Martin J. Bligh wrote:
> > At the moment I use the contig memory model (so we only use discontig for
> > NUMA support) but I may need to change that in the future.
> 
> I wasn't thinking at numa-q, but regardless numa-Q fits perfectly into
> the current discontigmem-numa model too as far I can see.

No it doesn't.  The config_discontigmem model forces all zone_normal memory
to be on node zero, so all the remaining nodes can only have highmem locally.
Even with good cache hardware, this has to hurt.

-- 
Daniel
