Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314339AbSEHOFb>; Wed, 8 May 2002 10:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314383AbSEHOFa>; Wed, 8 May 2002 10:05:30 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:45247 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S314339AbSEHOF2>;
	Wed, 8 May 2002 10:05:28 -0400
Subject: Re: 48 bit ATA support in Linux 2.4
From: Steve Lord <lord@sgi.com>
To: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Cc: Dan Chen <crimsun@email.unc.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200205081607249.SM00162@there>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 May 2002 09:03:08 -0500
Message-Id: <1020866588.29836.17.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-08 at 09:02, Robert Szentmihalyi wrote:
> 
> Can anybody who knows the XFS code please tell what the alias VM_PAGEBUF
> in this enumeration is used for and how I could fix this?
> 
> The original 2.4.49-pre7 code seems to define another alias for 11 in this enum:
>  
> /* CTL_VM names: */
> enum
> {
> 	VM_SWAPCTL=1,		/* struct: Set vm swapping control */
> 	VM_SWAPOUT=2,		/* int: Linear or sqrt() swapout for hogs */
> 	VM_FREEPG=3,		/* struct: Set free page thresholds */
> 	VM_BDFLUSH=4,		/* struct: Control buffer cache flushing */
> 	VM_OVERCOMMIT_MEMORY=5,	/* Turn off the virtual memory safety limit */
> 	VM_BUFFERMEM=6,		/* struct: Set buffer memory thresholds */
> 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
> 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
> 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
> 	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
> 	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
> 	VM_MIN_READAHEAD=12,    /* Min file readahead */
> 	VM_MAX_READAHEAD=13,    /* Max file readahead */
> };
> 
> Any hints?
> 


Just push the VM_PAGEBUF number up to an unused value, there are no
user space programs which actually use it, just the /proc interface
is normally used for this.

Steve


-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
