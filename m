Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284282AbRLXA3O>; Sun, 23 Dec 2001 19:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284285AbRLXA2y>; Sun, 23 Dec 2001 19:28:54 -0500
Received: from holomorphy.com ([216.36.33.161]:20618 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S284282AbRLXA2s>;
	Sun, 23 Dec 2001 19:28:48 -0500
Date: Sun, 23 Dec 2001 16:28:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache - take two
Message-ID: <20011223162839.B750@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87bsgp7fcq.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <87bsgp7fcq.fsf@fadata.bg>; from velco@fadata.bg on Mon, Dec 24, 2001 at 12:15:33AM +0200
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 12:15:33AM +0200, Momchil Velikov wrote:
> This is the second mutation of the scalable page cache patch.  It:
> 
>         - removes the global page cache hash table and the associated lock
> 
> 	- implements the page cache as a per mapping radix tree. This
>           increases the size of ``struct inode'' by 8 bytes (in 32bit
>           ports).  The branch factor is a compile time constant
>           ``RAD_MAP_SHIFT'' (currently 7, 128 pointers)
> 
>         - decreases the size of ``struct page'' by removing
>           ``next_hash'' and ``pprev_hash' fields as they are no longer
>           needed for the page cache.  NOTE that this curently breaks
>           sparc64 and arm ports. The sparc64 port is trivialy fixable.
> 
> The patch is stable on UP (survives make -j6) and does not have
> noticeable performance impact (at least for the kernel compile
> benchmark) in either direction.

Beautiful programming!


Cheers,
Bill
