Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSEXVUY>; Fri, 24 May 2002 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311710AbSEXVUX>; Fri, 24 May 2002 17:20:23 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:29064 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S311180AbSEXVUW>;
	Fri, 24 May 2002 17:20:22 -0400
Date: Fri, 24 May 2002 14:18:56 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible discrepancy regarding streaming DMA mappings in DMA-mapping.txt?
Message-ID: <20020524141856.M7205@ayrnetworks.com>
In-Reply-To: <20020524133711.K7205@ayrnetworks.com> <20020524.132641.104219414.davem@redhat.com> <20020524135842.L7205@ayrnetworks.com> <20020524.135352.131897757.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 01:53:52PM -0700, David S. Miller wrote:
> Now that we've established that, you want a new operation.
> That operation is "Re-prepare DMA memory so that PCI realm
> will see it".  And the semantics of this would be to, on
> CPUs which are no cache coherent with PCI, to flush the cache
> to prevent inconsistencies between PCI and the CPU.
> 
> The CPU cache flush is needed in both cases to/from cases.
> 
> So do you finally understand why you must create a new interface
> to accomplish what you want?

Yes, that clears things up. I'll work on this.

Thanks,
William
