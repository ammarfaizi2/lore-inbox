Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291641AbSBHQuj>; Fri, 8 Feb 2002 11:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291637AbSBHQu3>; Fri, 8 Feb 2002 11:50:29 -0500
Received: from holomorphy.com ([216.36.33.161]:39570 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291641AbSBHQuK>;
	Fri, 8 Feb 2002 11:50:10 -0500
Date: Fri, 8 Feb 2002 08:49:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix i810_dma.c freeing mem inside mem_map
Message-ID: <20020208164953.GC767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16Z3Kb-0003cm-00@holomorphy> <Pine.LNX.4.21.0202081229490.964-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202081229490.964-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, William Lee Irwin III wrote:
>> --- linux/drivers/char/drm/i810_dma.c.bak	Thu Feb  7 21:09:49 2002
>> +++ linux/drivers/char/drm/i810_dma.c	Thu Feb  7 21:09:59 2002
>> @@ -301,7 +301,7 @@
>>  		atomic_dec(&p->count);
>>  		clear_bit(PG_locked, &p->flags);
>>  		wake_up_page(p);
>> -		free_page(p);
>> +		free_page(page);
>>  	}
>>  }

On Fri, Feb 08, 2002 at 12:31:07PM +0000, Hugh Dickins wrote:
> What tree does this patch apply to?
> Hugh

rmap12d

Cheers,
Bill
