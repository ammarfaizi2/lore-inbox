Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315111AbSECWGm>; Fri, 3 May 2002 18:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315730AbSECWGm>; Fri, 3 May 2002 18:06:42 -0400
Received: from dsl-213-023-039-070.arcor-ip.net ([213.23.39.70]:5291 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315111AbSECWGl>;
	Fri, 3 May 2002 18:06:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dave Engebretsen <engebret@vnet.ibm.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Sat, 4 May 2002 00:06:02 +0200
X-Mailer: KMail [version 1.3.2]
Cc: William Lee Irwin III <wli@holomorphy.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E173RjF-0002Ch-00@starship> <3CD2E940.D421185F@vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E173lBj-0003iP-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 May 2002 21:47, Dave Engebretsen wrote:
> We don't need the reverse translation on iSeries as the kernel never
> knows about the actual hardware address, other than when putting an
> entry in the hardware page tables (processor and I/O).

So the kernel page tables are carrying what I'd call a logical address,
that is, zero-based, indexing your logical-to-physical table (physical
taken in a non-literal sense).

This would suggest that your current arrangement is a strict subset of
my current config_nonlinear design, flat table and all, but with
phys_to_pagenum defined as a compile-time error.

-- 
Daniel
