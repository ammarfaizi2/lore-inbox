Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290109AbSBNFtP>; Thu, 14 Feb 2002 00:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBNFtF>; Thu, 14 Feb 2002 00:49:05 -0500
Received: from dsl-65-185-109-125.telocity.com ([65.185.109.125]:11393 "EHLO
	ohdarn.net") by vger.kernel.org with ESMTP id <S289775AbSBNFsv>;
	Thu, 14 Feb 2002 00:48:51 -0500
Subject: Re: Linux 2.4.18-pre9-mjc2
From: Michael Cohen <me@ohdarn.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <046e01c1b51b$01a50160$0f01000a@brisbane.hatfields.com.au>
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net> 
	<046e01c1b51b$01a50160$0f01000a@brisbane.hatfields.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 14 Feb 2002 00:48:47 -0500
Message-Id: <1013665727.25757.30.camel@ohdarn.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct fix is to remove __find_page_nolock entirely.



On Thu, 2002-02-14 at 00:46, Andrew Hatfield wrote:
> got this problem when applying 2.4.18-pre8-mjc to 2.4.18-pre8 to 2.4.17 as
> well as newly released 2.4.18-pre8-mjc2
> 
> filemap.c: In function `__find_page_nolock':
> filemap.c:404: structure has no member named `next_hash'
> 
> Not sure if this is related to Rik's rmap patch or Ingo's O(1) Scheduler
> patch (or again, something else entirely)
> 
> your mjc2 patch contains....
> patch-2.4.18-pre9-mjc2:-        struct page *next_hash;         /* Next page
> sharing our hash bucket in
> patch-2.4.18-pre9-mjc2:-        struct page **pprev_hash;       /*
> Complement to *next_hash. */
> 
> which modifes linux/include/linux/mm.h
> 
> 
> if i comment out the line in filemap.c it continues to compile... until
> problems with ip.h (more to come)
> 
>   --
> 
>   Andrew Hatfield
>   SecureONE - http://www.secureone.com.au/
>   President - South East Brisbane Linux Users Group  http://www.seblug.org/
> 
>   Kernel work available at http://development.secureone.com.au/kernel/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


