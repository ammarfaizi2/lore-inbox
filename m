Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVFAU67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVFAU67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFAU4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:56:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15763 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261249AbVFAUz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:55:29 -0400
Message-ID: <429E20B6.2000907@austin.ibm.com>
Date: Wed, 01 Jun 2005 15:55:18 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <20050531112048.D2511E57A@skynet.csn.ul.ie>
In-Reply-To: <20050531112048.D2511E57A@skynet.csn.ul.ie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -		struct free_area *area;
>  		struct page *buddy;
> -
> +		

...

>  	}
> +
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -	return allocated;
> +	return count - allocated;
>  }
>  
> +
> +

Other than the very minor whitespace changes above I have nothing bad to 
say about this patch.  I think it is about time to pick in up in -mm for 
wider testing.




