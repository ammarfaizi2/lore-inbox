Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314228AbSEBCCq>; Wed, 1 May 2002 22:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314229AbSEBCCp>; Wed, 1 May 2002 22:02:45 -0400
Received: from dsl-213-023-038-139.arcor-ip.net ([213.23.38.139]:24986 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314228AbSEBCCp>;
	Wed, 1 May 2002 22:02:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 04:02:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172j1d-0001rS-00@starship> <20020502014504.GD32767@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172jRy-0001rq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 03:45, William Lee Irwin III wrote:
> On Wed, May 01, 2002 at 03:35:20AM +0200, Daniel Phillips wrote:
> > to use a hash table instead of a table lookup.  Bill Irwin suggested a btree
> > would work here as well.
> 
> I remember suggesting a sorted array of extents on which binary
> search could be performed. A B-tree seems unlikely but perhaps if
> it were contiguously allocated and some other tricks done it might
> do, maybe I don't remember the special sauce used for the occasion.

Thanks for the correction.  When you said 'extents' I automatically thought
'btree of extents'.  I'd tend to go for the hash table anyway - your binary
search is going to take quite a few more steps to terminate than the bucket
search, given some reasonable choice of hash table size.

-- 
Daniel
