Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSFEKm6>; Wed, 5 Jun 2002 06:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSFEKm5>; Wed, 5 Jun 2002 06:42:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18963 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315168AbSFEKm5>; Wed, 5 Jun 2002 06:42:57 -0400
Message-ID: <3CFDDD77.30207@evision-ventures.com>
Date: Wed, 05 Jun 2002 11:44:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
In-Reply-To: <3CFD453A.B6A43522@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> 
> laptop_mode

Great idea!.

> 
> This implementation doesn't try to be very smart - there's a direct
> ca
> --- 2.5.20/drivers/ide/ide.c~laptop-mode	Tue Jun  4 15:27:54 2002
> +++ 2.5.20-akpm/drivers/ide/ide.c	Tue Jun  4 15:27:54 2002
> @@ -1043,6 +1043,7 @@ static void do_request(struct ata_channe
>  
>  void do_ide_request(request_queue_t *q)
>  {
> +	disk_spun_up();
>  	do_request(q->queuedata);
>  }

Hugh? Perhaps moving this down to do_request would be
an idea worth consideration?

