Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSBNFvz>; Thu, 14 Feb 2002 00:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBNFvq>; Thu, 14 Feb 2002 00:51:46 -0500
Received: from holomorphy.com ([216.36.33.161]:52906 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289775AbSBNFvk>;
	Thu, 14 Feb 2002 00:51:40 -0500
Date: Wed, 13 Feb 2002 21:51:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Hatfield <lkml@secureone.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre9-mjc2
Message-ID: <20020214055105.GL767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Hatfield <lkml@secureone.com.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net> <046e01c1b51b$01a50160$0f01000a@brisbane.hatfields.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <046e01c1b51b$01a50160$0f01000a@brisbane.hatfields.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 03:46:53PM +1000, Andrew Hatfield wrote:
> got this problem when applying 2.4.18-pre8-mjc to 2.4.18-pre8 to 2.4.17 as
> well as newly released 2.4.18-pre8-mjc2
> filemap.c: In function `__find_page_nolock':
> filemap.c:404: structure has no member named `next_hash'
> Not sure if this is related to Rik's rmap patch or Ingo's O(1) Scheduler
> patch (or again, something else entirely)
> your mjc2 patch contains....
> patch-2.4.18-pre9-mjc2:-        struct page *next_hash;         /* Next page
> sharing our hash bucket in
> patch-2.4.18-pre9-mjc2:-        struct page **pprev_hash;       /*
> Complement to *next_hash. */
> which modifes linux/include/linux/mm.h
> if i comment out the line in filemap.c it continues to compile... until
> problems with ip.h (more to come)

It contains the ratcache by Momchil Velikov which eliminates the need for
those fields within struct page.
This is not the fix you're looking for...


Cheers,
Bill
