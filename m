Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSHVTSk>; Thu, 22 Aug 2002 15:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSHVTSk>; Thu, 22 Aug 2002 15:18:40 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:24591 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315762AbSHVTSh>; Thu, 22 Aug 2002 15:18:37 -0400
Date: Thu, 22 Aug 2002 20:22:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Bligh <mjbligh@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [patch] SImple Topology API v0.3 (1/2)
Message-ID: <20020822202239.A30036@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Dobson <colpatch@us.ibm.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Martin Bligh <mjbligh@us.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <3D6537D3.3080905@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D6537D3.3080905@us.ibm.com>; from colpatch@us.ibm.com on Thu, Aug 22, 2002 at 12:13:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 12:13:23PM -0700, Matthew Dobson wrote:
> --- linux-2.5.27-vanilla/include/linux/mmzone.h	Sat Jul 20 12:11:05 2002
> +++ linux-2.5.27-api/include/linux/mmzone.h	Wed Jul 24 17:33:41 2002
> @@ -220,15 +20,15 @@
>  #define NODE_MEM_MAP(nid)	mem_map
>  #define MAX_NR_NODES		1
>  
> -#else /* !CONFIG_DISCONTIGMEM */
> -
> -#include <asm/mmzone.h>
> +#else /* CONFIG_DISCONTIGMEM */
>  
>  /* page->zone is currently 8 bits ... */
>  #define MAX_NR_NODES		(255 / MAX_NR_ZONES)
>  
>  #endif /* !CONFIG_DISCONTIGMEM */
>  
> +#include <asm/mmzone.h>
> +

What is the exact purpose of this change?

